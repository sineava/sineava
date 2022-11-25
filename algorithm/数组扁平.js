let arr = []
function flat(data) {
  // 数组
  if (Array.isArray(data)) {
    data.forEach(flat)
  } else {
    arr.push(data)
  }
}

flat([1, 2, 3, [4, 5, [6, 8, 4]]])
console.log(arr)