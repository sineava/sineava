import HelloWorld from './components/HelloWorld'
import Timer from './components/Timer'
import Todo from './components/Todo'
import Tempature from './components/Tempature'
import Fancy from './components/Fancy'
import Product from './components/Product'
import Lazy from './components/Lazy'
import ErrorBounary from './components/ErrorBounary'
import ErrorComp from './components/ErrorComp'
import Level from './components/Level'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import ThemeContext from './components/Context'
import { useState, Component } from 'react'

const Left = () => <div>left</div>
const Right = () => <div>right</div>

export default () => {
  const [theme, setTheme] = useState('dark')
  const toggle = () => {
    setTheme(theme === 'dark' ? 'light' : 'dark')
  }
  return (
    <>
      <HelloWorld msg="hello world" />
      <Timer />
      <Todo />
      <Tempature />
      <Fancy color="red" left={ <Left /> }  right={ <Right /> }>
        <div>2233</div>
      </Fancy>
      <Product />
      <Lazy />
      {/* <ErrorBounary>
        <ErrorComp />
      </ErrorBounary> */}
      <Router>
        <Routes>
          <Route path="/" element={<div>/</div>} />
          <Route path="/home" element={<div>/home</div>} />
        </Routes>
      </Router>
      <ThemeContext.Provider value={ theme }>
        <Level />
      </ThemeContext.Provider>
      <button onClick={toggle}>toggle theme</button>
      <ul>
        <Lis />
      </ul>
    </>
  )
}

class Lis extends Component {
  render() {
    return [
      <li>a</li>,
      <li>b</li>,
      <li>c</li>
    ]
  }
}