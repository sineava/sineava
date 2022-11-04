const str = 'HeLl0wOrLd'

const newStr = str.replace(/([a-z]*)([A-Z]*)/g, (_, s1, s2) => {
  return `${s1.toUpperCase()}${s2.toLowerCase()}`
})
console.log(newStr) // hElL0WoRlD