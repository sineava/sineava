/**
 * @desc 写一个函数,实现sum(x)(y)和sum(x,y)相等
 */
function sum(a, b) {
  if (b) return a + b
  return function fn(...rest) {
    return a + rest[0]
  }
}

const r1 = sum(1)(2)
const r2 = sum(1, 2)
console.log(r1, r2)