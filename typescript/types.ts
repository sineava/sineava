import type { Person, Cat } from './variable'

const per: Person = {
  name: 'mitty',
  age: 2
}

const cat: Cat = { breed: 'xx', color: '#00ff00' }

console.log(per)

interface Fn {
  (name: string): string
}

const obj: Fn = (name: string) => name
obj('hello')

function map<I,O>(arr: I[], func: (arg: I) => O): O[] {
  return arr.map(func)
}
const parsed = map(['1','2','3'], (n) => parseInt(n))
console.log(parsed)

// function longest<T extends { length: number }>(a: T, b: T): T {
//   return a.length >= b.length ? a : b
// }

const longest = <T extends {length: number}>(a: T, b: T): T => {
  return a.length >= b.length ? a : b
}

const long = longest([1,2,3], [1,2])
console.log(long)

const mapType = new Map<string, number | string>([['name', 'zs'], ['age', 20]])
console.log(mapType)

interface N {
  name: string
}

interface A {
  age: number
}

interface P extends N, A {
  address: string
}

const person: P = {
  name: 'zs',
  age: 20,
  address: 'cq'
}

console.log(person)

interface Box<T> {
  contents: T
}

const box: Box<string> = { contents: 'string' }
const numBox: Box<number> = { contents: 0 }

function fn(n: number) {
  return n
}

type Num = ReturnType<typeof fn>

const a: Num = 1

function first() {
  console.log("first(): factory evaluated");
  return function (target: any, propertyKey: string, descriptor: PropertyDescriptor) {
    console.log("first(): called");
  };
}

function second() {
  console.log('second fn execute')
  return (target: any, propertyKey: string, descriptor: PropertyDescriptor) => {
    console.log('second fn execute')
  }
}

class Example {
  @first()
  @second()
  demo() {

  }
}

const exam = new Example()
exam.demo()