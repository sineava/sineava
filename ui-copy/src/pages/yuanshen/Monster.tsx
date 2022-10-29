import { useState } from 'react'
import Title from '../../assets/y-title-5.png'
import Monster1 from '../../assets/y-monster1.png'
import Monster1Active from '../../assets/y-monster1-active.png'
import Monster2 from '../../assets/y-monster2.png'
import Monster2Active from '../../assets/y-monster2-active.png'
import Desc1 from '../../assets/y-desc-1.png'
import Desc2 from '../../assets/y-desc-2.png'

const urls = [
  'https://uploadstatic.mihoyo.com/puzzle/upload/puzzle/2022/09/26/a4926264ffdd02a2c52e1281b560f99a_7314909191006900135.mp4',
  'https://uploadstatic.mihoyo.com/puzzle/upload/puzzle/2022/09/26/828f56d1be90d6e8bb403d338326e6bb_4921388826026954636.mp4'
]

export default () => {
  const [current, setCurrent] = useState(0)
  return (
    <div className="flex justify-center items-center relative w-screen h-screen bg-[url('/img/bg-5.png')]">
      <img className="cursor-pointer absolute left-[100px] top-[40px]" src={Title} />
      <div className="absolute left-[220px] top-[440px]">
        <img className="cursor-pointer" src={current === 0 ? Monster1Active : Monster1} onClick={() => setCurrent(0)} />
        <img className="cursor-pointer mt-[40px]" src={current === 1 ? Monster2Active : Monster2} onClick={() => setCurrent(1)}/>
      </div>
      <div className="absolute m-auto left-[544px] top-[122px] w-[686px] h-[686px] overflow-hidden rounded-full">
        <video src={urls[current]} className="w-full h-full object-cover" preload="auto" autoPlay muted loop />
      </div>
      <div className="absolute right-[30px] top-[290px] w-[560px] overflow-hidden">
        <img className="w-[2000px]" src={current === 0 ? Desc1 : Desc2} />
      </div>
    </div>
  )
}