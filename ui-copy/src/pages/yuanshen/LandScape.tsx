import { useState, useEffect } from 'react'
import Title from '../../assets/y-title-3.png'
import Landscape1 from '../../assets/y-landscape-1.png'
import Landscape2 from '../../assets/y-landscape-2.png'
import Landscape3 from '../../assets/y-landscape-3.png'
import Left from '../../assets/y-left-arrow.png'
import LeftActive from '../../assets/y-left-arrow-active.png'
import Right from '../../assets/y-right-arrow.png'
import RightActive from '../../assets/y-right-arrow-active.png'

export default () => {
  type Type = '' | 'left' | 'right'
  const [current, setCurrent] = useState(0)
  const [active, setActive] = useState('')
  useEffect(() => {
    const timer = setInterval(() => toggleCurrent('right'), 3000)
    return () => clearInterval(timer)
  }, [current])
  const toggle = (type: Type) => {
    setActive(type)
  }
  const toggleCurrent = (direction: 'left' | 'right' = 'right') => {
    if (direction == 'left') {
      setCurrent(current === 0 ? 2 : current - 1)
    } else {
      setCurrent(current === 2 ? 0 : current + 1)
    }
  }
  const effect = (type: Type) => {
    return {
      onMouseEnter: () => toggle(type),
      onMouseLeave: () => toggle('')
    }
  }
  return (
    <div className="flex justify-center items-center relative w-screen h-screen bg-[url('/img/bg-3.png')]">
      <img className="cursor-pointer absolute left-[100px] top-[40px]" src={Title} />
      <div className="h-[700px] m-auto flex items-center">
        <img className="cursor-pointer" src={active === 'left' ? LeftActive : Left} { ...effect('left') } onClick={() => toggleCurrent('left')} />
        <img className="h-full mx-8" src={[Landscape1, Landscape2, Landscape3][current]} />
        <img className="cursor-pointer" src={active === 'right' ? RightActive : Right} { ...effect('right') } onClick={() => toggleCurrent('right')} />
      </div>
    </div>
  )
}