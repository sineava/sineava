import { Component } from 'react'
import Stocker from './components/Stocker'
import YuanShen from './components/YuanShen'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'

export default class extends Component {
  render() {
    return (
      <Router>
        <Routes>
          {/* <Route path="/" element={<YuanShen />} /> */}
          <Route path="/stocker" element={<Stocker />} />
          <Route path="yuanshen" element={<YuanShen />} />
        </Routes>
      </Router>
    )
  }
}