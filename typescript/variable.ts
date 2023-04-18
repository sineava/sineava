export interface Person {
  name: string
  age: number
  [k: string]: any
}

export type Cat = { breed: string, color: string }