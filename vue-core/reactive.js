function receiver(target) {
  const handler ={
    get(target, key, receiver) {
      return Reflect.get(target, key, receiver)
    },
    set(target, key, value, receiver) {
      return Reflect.set(target, key, value, receiver)
    }
  }
  return new Proxy(target, handler)
}

export { receiver }