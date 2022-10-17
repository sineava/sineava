import { Component } from "react"
import { tempature as temp } from '../utils/utils'

type ctx = 'hs' | 'cs'

export default class extends Component<any, { tempature: any, cur: any }> {
  constructor(props: any) {
    super(props)
    this.state = {tempature: '', cur: ''}
  }
  change = (e: Event, ctx: ctx) => {
    this.setState({
      tempature: (e.target as any).value,
      cur: ctx
    })
  }
  render() {
    const { cur, tempature } = this.state
    const cs = cur === 'cs' ? tempature : temp.toCelsius(tempature)
    const hs = cur === 'hs' ? tempature : temp.toFahrenheit(tempature)
    return (
      <>
        <Temp ctx="hs" change={this.change} tempature={hs} />
        <Temp ctx="cs" change={this.change} tempature={cs} />
        <Status tempature={cs} />
      </>
    )
  }
}

class Temp extends Component<{ ctx: ctx, tempature: number, change: (e: Event, ctx: ctx) => void; }> {
  constructor(props: any) {
    super(props)
    this.state = {
      temp
    }
  }
  render() {
    const { ctx, change, tempature }: any = this.props
    return (
      <>
        <fieldset>
          <legend>{ctx === 'hs' ? '华氏度' : '摄氏度'}</legend>
          <input type="number" value={tempature} onChange={e => change(e, ctx)} />
        </fieldset>
      </>
    )
  }
}

class Status extends Component<any> {
  constructor(props: any) {
    super(props)
  }
  render() {
    const { tempature } = this.props
    return <p>温度{ tempature > 50 ? '过高' : '合适' }</p>
  }
}