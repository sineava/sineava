import { useEffect, useState } from 'react'
import Title from '../../assets/y-title-8.png'
import Carousel1 from '../../assets/y-carousel-1.png'
import Carousel2 from '../../assets/y-carousel-2.png'
import Carousel3 from '../../assets/y-carousel-3.png'
import Carousel4 from '../../assets/y-carousel-4.png'
import Carousel5 from '../../assets/y-carousel-5.png'
import Step from '../../assets/y-step.png'
import StepActive from '../../assets/y-step-active.png'
import Weibo from '../../assets/y-icon-weibo.png'
import Wechat from '../../assets/y-icon-wechat.png'
import Bilibili from '../../assets/y-icon-bilibili.png'
import Mihoyo from '../../assets/y-icon-mihoyou.png'
import Left from '../../assets/y-left-arrow.png'
import LeftActive from '../../assets/y-left-arrow-active.png'
import Right from '../../assets/y-right-arrow.png'
import RightActive from '../../assets/y-right-arrow-active.png'

export default () => {
  type Type = '' | 'left' | 'right'
  const [initial] = useState(['t-pre-2', 't-pre-1', 't-slide-active', 't-next-1', 't-next-2'])
  const [images] = useState([Carousel4, Carousel5, Carousel1, Carousel2, Carousel3])
  const [current, setCurrent] = useState(0)
  const [active, setActive] = useState('')
  const status = (i: number) => {
    const status = [...initial.slice(current), ...initial.slice(0, current)][i]
    return ['t-pre-1', 't-next-1'].includes(status) ? `brightness-50 ${status}` : status
  }
  const toggleCurrent = (direction: 'left' | 'right' = 'right') => {
    if (direction == 'left') {
      setCurrent(current === 0 ? 4 : current - 1)
    } else {
      setCurrent(current === 4 ? 0 : current + 1)
    }
  }
  const toggle = (type: Type) => {
    setActive(type)
  }
  const effect = (type: Type) => {
    return {
      onMouseEnter: () => toggle(type),
      onMouseLeave: () => toggle('')
    }
  }

  useEffect(() => {
    const timer = setInterval(() => {
      setCurrent(current === 4 ? 0 : current + 1)
    }, 5000)
    return () => clearInterval(timer)
  })
  return (
    <div className="flex flex-col items-center relative w-screen h-screen bg-[url('/img/bg-7.png')]">
      <img className="cursor-pointer absolute left-[100px] top-[40px] z-20" src={Title} />
      <div className="relative mt-[100px] flex justify-center w-[1200px] h-[500px]">
        {
          images.map((item: any, i: number) => (
            <div key={i} className={`t-slide ${status(i)}`}><img src={item} /></div>
          ))
        }
      </div>
      <div className="h-[300px] mx-auto -mt-[300px] flex items-center z-10 gap-x-[840px]">
        <img className="cursor-pointer" src={active === 'left' ? LeftActive : Left} { ...effect('left') } onClick={() => toggleCurrent('left')} />
        <img className="cursor-pointer" src={active === 'right' ? RightActive : Right} { ...effect('right') } onClick={() => toggleCurrent('right')} />
      </div>
      <div className="flex justify-center mt-[40px] gap-x-8 cursor-pointer">
        { [...new Array(5)].map((_, i) => <img key={i} src={current === i ? StepActive : Step} onClick={() => setCurrent(i)} />) }
      </div>
      <div className="flex justify-center mt-[100px] gap-x-8 cursor-pointer">
        <img src={Weibo} />
        <img className="ml-[20px]" src={Wechat} />
        <img src={Bilibili} />
        <img src={Mihoyo} />
      </div>
    </div>
  )
}