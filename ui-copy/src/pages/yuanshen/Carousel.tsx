import { useEffect, useState } from 'react'
import Title from '../../assets/y-title-8.png'
import Carousel1 from '../../assets/y-carousel-1.png'
import Carousel2 from '../../assets/y-carousel-2.png'
import Carousel3 from '../../assets/y-carousel-3.png'
import Carousel4 from '../../assets/y-carousel-4.png'
import Carousel5 from '../../assets/y-carousel-5.png'

export default () => {
  const [animate, setAnimate] = useState(false)
  const [list, setList] = useState([
    Carousel1,
    Carousel2,
    Carousel3,
    Carousel4,
    Carousel5
  ])
  useEffect(() => {
    const timer = setInterval(() => {
      setAnimate(true)
      setList([...list.slice(1), list[0]])
      const time = setTimeout(() => {
        setAnimate(false)
        clearTimeout(time)
      }, 300)
    }, 4000)
    return () => clearTimeout(timer)
  }, [animate, list])
  return (
    <div className="flex justify-center items-center relative w-screen h-screen bg-[url('/img/bg-7.png')]">
      <img className="cursor-pointer absolute left-[100px] top-[40px] z-20" src={Title} />
      <div className="relative mx-auto flex w-[1200px] h-[500px]">
        <div className={`absolute w-[773px] h-[440px] z-20 left-0 top-[50px] ${animate && 't-carousel-left-transfer'}`}>
          <img className="w-full h-full" src={list[4]} />
          <div className={`absolute left-0 top-0 w-full h-full bg-[#000] z-30 opacity-50`}></div>
        </div>
        <div className={`absolute left-[200px] top-[20px] w-[848px] h-[497px] z-40 ${animate && 't-carousel-left-big'}`}>
          <img className="w-full h-full" src={list[0]} />
        </div>
        <div className={`absolute w-[773px] h-[440px] z-20 right-0 top-[50px] ${animate && 't-carousel-left-little'}`}>
          <img className="w-full h-full" src={list[1]} />
          <div className={`absolute left-0 top-0 w-full h-full bg-[#000] z-30 opacity-50`}></div>
        </div>
      </div>
    </div>
  )
}