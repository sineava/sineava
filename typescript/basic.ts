// const elem = <HTMLElement>document.querySelector('#app')
const elem = document.querySelector('#app')
elem!.innerHTML = '2233' // 非空断言

const a = 202222222222222222222n
console.log(a)

interface Person {
  name: string
  age: number
  [k: string]: any
}

const person: Person = {
  name: 'zs',
  age: 10,
  address: 'beijing'
}

console.log(person)

// 泛型
function identity<T, U>(k: T, v?: U): T {
  return k
}

const data = identity<number, number | undefined>(1)
console.log(data)

const house = { price: 10, address: '北京市' }
type House = typeof house

const newHouse: House = { price: 11, address: '重庆' }

const arr: Array<Object> = [newHouse]

type K1 = keyof House
const key: K1 = 'price'

const map: Map<string, string> = new Map([['name', 'zs'], ['address', '重庆']])

function slice<T extends object, U extends keyof T>(obj: T, k: U): T[U] {
  return obj[k]
}

console.log(slice(house, 'address'))

type CatName = 'juice' | 'purple'
interface CatInfo {
  color: string
}
const cats: Record<CatName, CatInfo> = {
  juice: { color: 'green' },
  purple: { color: 'red' }
}

// Partial => 参数转为可选
interface Animal {
  color: string
  hobbie: () => void
}

function yell(animal: Partial<Animal>) {
  console.log(animal.color)
}

yell({ color: 'red' })

// PICK => 属性挑选
function pick(animal: Pick<Animal, 'color'>) {
  console.log(animal.color)
}

pick({ color: 'pink' }) // 如果此时传入hobbie就会报错

// RECORD
interface Paper {
  title: string
}

type Method = 'get' | 'post' | 'delete' | 'put' | 'head'

const x: Record<Method, Paper> = {
  get: { title: 'get' },
  post: { title: 'post' },
  delete: { title: 'delete' },
  put: { title: 'put' },
  head: { title: 'head' }
}

console.log(x)