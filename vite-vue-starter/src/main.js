import { createApp, defineCustomElement } from 'vue'
import './style.css'
import App from './App.vue'

const CustomElement = defineCustomElement({
  props: {
    msg: String
  },
  template: `<div>{{ msg }}</div>`
})

customElements.define('mine-element', CustomElement)
// document.body.appendChild(new CustomElement({ msg: 'hello' }))

const app = createApp(App)

app.config.errorHandler = (err) => {
  console.log(err)
}

app.config.globalProperties.window = window

app.mount('#app')
