class PubSub {
  constructor() {
    // killTask: 暗杀任务, protectTask: 保镖任务
    this.events = {}
  }
  subscribe(type, cb) {
    if (!this.events[type]) this.events[type] = []
    this.events[type].push(cb)
  }
  publish(type, ...args) {
    console.log(`中介发布任务: ${args}`)
    this.events[type] && this.events[type].forEach(cb => cb(...args))
  }
  unsubscribe(type, cb) {
    if (this.events[type].length === 0) {
      delete this.events[type]
      return
    }
    if (this.events[type]) {
      const index = this.events[type].findIndex(e => e === cb)
      this.events[type].splice(index, 1)
    }
  }
  unsubscribeAll(type) {
    this.events[type] && delete this.events[type]
  }
}

// 中介
const pubsub = new PubSub()
pubsub.subscribe('killTask', function(taskInfo) {
  console.log(`完成任务: ${taskInfo}`)
})
pubsub.subscribe('protectTask', function(taskInfo) {
  console.log(`完成任务: ${taskInfo}`)
})

pubsub.publish('killTask', '暗杀!')
pubsub.publish('protectTask', '保护!')