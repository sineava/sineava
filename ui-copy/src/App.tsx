import { Component, Fragment } from 'react'
import Header from './components/Header'
import Main from './components/Main'

export default class extends Component {
  render() {
    return (
      <Fragment>
        <Header  />
        <Main />
      </Fragment>
    )
  }
}