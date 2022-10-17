import { Component } from 'react'

interface State {
  timer: number
}

export default class extends Component {
  interval!: number
  constructor(props: any) {
    super(props)
    this.state = {
      timer: 0
    }
  }
  tick() {
    this.setState((state: State) => ({
      timer: state.timer + 1
    }))
  }
  componentDidMount(): void {
    this.interval = setInterval(() => this.tick(), 1000)
  }
  componentWillUnmount(): void {
    clearInterval(this.interval)
  }
  render() {
    const { timer }: any = this.state
    return <div>当前运行时长: { timer }s</div>
  }
}