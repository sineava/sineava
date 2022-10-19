import { Component } from 'react'

export default class extends Component<any, any> {
  constructor(props: any) {
    super(props)
    this.state = { hasError: false }
  }

  static getDerivedStateFromError() {
    return { hasError: true }
  }

  componentDidCatch(error: Error) {
    console.log(error)
  }
  render() {
    if (this.state.hasError) {
      return <div>存在异常</div>
    }
    return this.props.children
  }
}
