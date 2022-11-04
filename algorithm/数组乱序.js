const arr = [1, 2, 3, 4, 5]
const shuffle = arr => arr.sort(() => Math.random() - 0.5)
console.log(shuffle(arr))