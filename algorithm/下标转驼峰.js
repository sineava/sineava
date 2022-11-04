let origin = 'camcel_name'
let str = ''
const arr = origin.split('_')
for (let i = 0, len = arr.length; i < len; i++) {
  str += i === 0 ? arr[i] : `${arr[i].slice(0, 1).toUpperCase()}${arr[i].slice(1)}`
}

console.log(str)