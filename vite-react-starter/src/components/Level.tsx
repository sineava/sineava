import { Component } from 'react'
import ThemeContext from './Context'

export default class extends Component {
  render() {
    return <Level1 />
  }
}

class Level1 extends Component {
  // static contextType = ThemeContext
  render() {
    // const { context }: any = this
    return (
      <ThemeContext.Consumer>
        {
          theme => <div>{theme}</div>
        }
      </ThemeContext.Consumer>
    )
    // return <div>{ context }</div>
  }
}