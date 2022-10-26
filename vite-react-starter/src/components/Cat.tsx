import { Component } from 'react'

export default class extends Component<any, any> {
  render() {
    const { clientX, clientY } = this.props
    return [
      <p>clientX: { clientX }</p>,
      <p>clientY: { clientY }</p>
    ]
  }
}