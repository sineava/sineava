// 用递归算法实现，数组长度为5且元素的随机数在2-32间不重复的值
const set = new Set([])
const random = () => {
  const num = Math.floor(Math.random() * 31) + 2
  if (!set.has(num)) set.add(num)
  if (set.size < 5) random()
}

random()
console.log(Array.from(set))