const map = new Map()
const wMap = new WeakMap()

;(() => {
  const foo = { reference: 'test Map' }
  const bar = { reference: 'test WeakMap' }

  map.set(foo, 'Map')
  wMap.set(bar, 'WeakMap')

  map.set('k', 'Map')
  // 会报错,WeakMap不能使用常量(字符串数字等)作为key
  // wMap.set('k', 'WeakMap')

  console.log(map.get(foo))
  console.log(wMap.get(bar))
  console.log(map.get('k'))
})()

console.log(map) // key无法被垃圾回收机制回收,还是能拿到对象,容易产生内存泄漏
console.log(wMap) // 此时引用key对象会被GC回收,此时就无法拿到键值了