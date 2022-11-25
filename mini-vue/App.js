// const { effect, reactive } = require('@vue/reactivity')
import { effectWatch, reactive } from './core/reactivity.js'
import { h } from './core/h.js'

// console.log('---------api调用---------')

// let a = reactive({
//   value: 1
// })
// let b

// effectWatch(() => {
//   b = a.value + 1
//   console.log(b)
// })

// a.value = 0

export default {
  render(context) {
    // const div = document.createElement('div')
    // div.innerText = context.state.count
    // return div
    // return h('div', { id: 'sb' }, context.state.count.toString())
    return h('div', { class: 'hello' }, [h('span', null, '2233'), h('a', { href: 'https://baidu.com' }, '百度')])
  },
  setup() {
    const state = reactive({ count: 0 })
    window.state = state
    return { state }
  }
}

// App.render(App.setup())