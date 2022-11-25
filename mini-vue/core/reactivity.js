// 1. effect
let currentEffect
class Dep {
  constructor(value) {
    this.effects = new Set()
    this._value = value
  }

  get value() {
    this.depend()
    return this._value
  }

  set value(newVal) {
    this._value = newVal
    this.notice()
  }

  // 1. 依赖收集
  depend() {
    if (currentEffect) {
      this.effects.add(currentEffect)
    }
  }

  // 2. 触发依赖
  notice() {
    this.effects.forEach(effect => effect())
  }
}

function effectWatch(effect) {
  currentEffect = effect
  effect()
  currentEffect = null
}

let b
const dep = new Dep(10)
effectWatch(() => {
  b = dep.value + 10
  console.log(b)
})

dep.value = 20

// 2. reactive
console.log('---------reactive------------')
const targetMap = new Map()
function getDep(target, key) {
  let depsMap = targetMap.get(target)
  if (!depsMap) {
    depsMap = new Map()
    targetMap.set(target, depsMap)
  }
  let dep = depsMap.get(key)
  if (!dep) {
    dep = new Dep()
    depsMap.set(key, dep)
  }
  return dep
}

function reactive(raw) {
  return new Proxy(raw, {
    get(target, key) {
      const dep = getDep(target, key)
      dep.depend()
      return Reflect.get(target, key)
    },
    set(target, key, receiver) {
      const dep = getDep(target, key)
      Reflect.set(target, key, receiver)
      dep.notice()
    }
  })
}

const user = reactive({
  age: 18,
  sex: 'male'
})

effectWatch(() => {
  const { age, sex } = user
  console.log(age, sex)
})

user.sex = 'female'
user.age = 30

// api暴露
export {
  reactive,
  effectWatch
}