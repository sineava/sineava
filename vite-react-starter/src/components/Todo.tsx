import { Component } from 'react'

interface State {
  items: string[]
  text: string
}
interface ListProps {
  items: any[]
}

class List extends Component<ListProps> {
  constructor(props: ListProps) {
    super(props)
  }
  remove(idx: number, e: any) {
    console.log(idx, e)
  }
  render() {
    return (
      <ul>
        { this.props.items.map((item: any, i: number) => (
          <li key={i}>
            {item}
            <button onClick={this.remove.bind(this, i)}>delete</button>
          </li>
        )) }
      </ul>
    )
  }
}

export default class extends Component<any, State> {
  constructor(props: any) {
    super(props)
    this.state = {
      items: [],
      text: ''
    }
  }
  change(e: any) {
    this.setState({
      text: e.target.value
    })
  }
  click() {
    this.setState(state => ({
      items: [...state.items, state.text],
      text: ''
    }))
  }
  render() {
    const { text, items } = this.state
    return (
      <>
        <input value={text} onChange={this.change.bind(this)} />
        <button onClick={this.click.bind(this)}>add</button>
        <List items={items} />
      </>
    )
  }
}