import './stocker.css'
import Header from '../pages/stocker/Header'
import Main from '../pages/stocker/Main'
import { useEffect } from 'react'

export default () => {
  useEffect(() => {
    document.title = 'stocker临摹'
  }, [])
  return (
    <>
      <Header  />
      <Main />
    </>
  )
}