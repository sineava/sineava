function test() {
  setTimeout(function(){
    console.log(this.name)
  }.bind(this), 1000)
}

const obj = {
  name: '测试this',
  test
}

obj.test()