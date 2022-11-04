const arr = [[1,2,3, [4, 5, 3, 2, [1, 0]], 3, 7, 9]]

const set = new Set()
const flat = (data) => {
  data.forEach(i => {
    if (Array.isArray(i)) {
      flat(i)
    } else {
      set.add(i)
    }
  })
}

flat(arr)
console.log(set)