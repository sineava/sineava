const count = (str, target) => {
  let num = 0
  if (!target) return num
  while(str.match(target)) {
    str = str.replace(target, '')
    num++
  }
  return num
}

console.log(count('abcdef abcdef a', 'abc'))