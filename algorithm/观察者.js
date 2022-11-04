class Observer {
  constructor(name) {
    this.name = name
  }
  update({ type, target }) {
    if (type !== 'kill') return
    if (target === this.name) {
      console.log(`逗我呢?悬赏干掉我自己🐱‍`)
    } else {
      console.log(`杀手: ${this.name}, 目标: ${target}, 任务已完成`)
    }
  }
}

class Subject {
  constructor() {
    this.observerList = []
  }
  addObserver(observer) {
    this.observerList.push(observer)
  }
  notify(task) {
    this.observerList.forEach(observer => {
      console.log(`${observer.name}准备开始任务!`)
      observer.update(task)
    })
  }
}

const subject = new Subject()
const observer1 = new Observer('张三')
const observer2 = new Observer('李四')
subject.addObserver(observer1)
subject.addObserver(observer2)

const task = {
  type: 'kill',
  target: '张三'
}

subject.notify(task)