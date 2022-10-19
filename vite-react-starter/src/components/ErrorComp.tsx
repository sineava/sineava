import { Component } from "react"

export default class extends Component {
  render() {
    throw new Error('抛出自定义异常')
    return <div></div>
  }
}