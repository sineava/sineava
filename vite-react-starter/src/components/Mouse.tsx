import { Component } from 'react'

export default class extends Component<any, any> {
  constructor(props: any) {
    super(props)
    this.state = {
      clientX: 0,
      clientY: 0
    }
  }
  move = ({ clientX, clientY }: any) => {
    this.setState({ clientX, clientY })
  }
  render() {
    const { render } = this.props
    return (
      <div style={{ width: '1000px', height: '400px', backgroundColor: 'cyan' }} onMouseMove={this.move}>
        { render(this.state) }
      </div>
    )
  }
}