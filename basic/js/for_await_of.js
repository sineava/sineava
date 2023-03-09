const iterator = {
  [Symbol.asyncIterator]() {
    return {
      i: 0,
      next() {
        if (this.i === 10) {
          return Promise.resolve({ done: true })
        }
        return Promise.resolve({ done: false, value: this.i++ })
      }
    }
  }
}

async function* asyncGenerator() {
  var i = 0
  while(i <= 10) {
    yield i ++
  }
}

;(async function() {
  for await(i of iterator) {
    console.log(i)
  }
  for await(i of asyncGenerator()) {
    console.log(`异步生成器: ${i}`)
  }
})()
