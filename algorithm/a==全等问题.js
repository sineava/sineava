// 如何实现让a==1&&a==2&&a==3为ture
const a = {
  value: 0,
  valueOf() { // a ==会调用valueOf
    return ++this.value
  }
}
console.log(a == 1 && a == 2 && a == 3)