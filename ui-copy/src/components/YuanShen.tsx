import { useEffect, useState } from 'react'
import './YuanShen.css'
import Door from '../pages/yuanshen/Door'
import Dollar from '../pages/yuanshen/Dollar'
import LandScape from '../pages/yuanshen/LandScape'
import Hero from '../pages/yuanshen/Hero'
import Monster from '../pages/yuanshen/Monster'
import Activity from '../pages/yuanshen/Activity'
import Carousel from '../pages/yuanshen/Carousel'
import _ from 'lodash'

export default () => {
  // let currentH = 0
  // let page = 0
  const [currentH, setCurrentH] = useState(0)
  const [page, setPage] = useState(0)
  useEffect(() => {
    document.title = '原神临摹'
    // const ev = _.debounce(scroll, 60)
    // document.addEventListener('wheel', ev)
    // return () => {
    //   document.removeEventListener('wheel', ev)
    // }
  }, [currentH, page])
  function scroll() {
    const currentHight = window.pageYOffset
    const total = document.body.offsetHeight
    const step = total / 3
    if (currentHight > currentH) { // 向下滚动
      if (page === 3) return
      setPage(page + 1)
    } else if (currentHight < currentH) { // 向上滚动
      if (page === 0) return
      setPage(page - 1)
    }
    const percent = page * step
    setCurrentH(percent)
    window.scrollTo(0, percent)
  }
  return (
    <>
      <Door key="door" />
      <Dollar key="dollar" />
      <LandScape key="landscape" />
      <Hero key="hero" />
      <Monster key="monster" />
      <Activity key="activity" />
      <Carousel key="carousel" />
    </>
  )
}