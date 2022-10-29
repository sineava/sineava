import { useState } from 'react'
import Title1 from '../../assets/y-title-6.png'
import Title2 from '../../assets/y-title-7.png'
import ActivityBg1 from '../../assets/y-activity-bg1.png'
import ActivityBg2 from '../../assets/y-activity-bg2.png'
import ActivityBg3 from '../../assets/y-activity-bg3.png'
import ActivityBg4 from '../../assets/y-activity-bg4.png'
import ActivityLogo1 from '../../assets/y-activity-logo1.png'
import ActivityLogo1Active from '../../assets/y-activity-logo1-active.png'
import ActivityLogo2 from '../../assets/y-activity-logo2.png'
import ActivityLogo2Active from '../../assets/y-activity-logo2-active.png'
import ActivityLogo3 from '../../assets/y-activity-logo3.png'
import ActivityLogo3Active from '../../assets/y-activity-logo3-active.png'
import ActivityLogo4 from '../../assets/y-activity-logo4.png'
import ActivityLogo4Active from '../../assets/y-activity-logo4-active.png'
export default () => {
  const [current, setCurrent] = useState(0)
  return (
    <div className="flex justify-center items-center relative w-screen h-screen bg-[url('/img/bg-6.png')]">
      <img className="cursor-pointer absolute left-[100px] top-[40px] z-20" src={Title1} />
      <img className="w-[30px] cursor-pointer absolute right-[370px] top-0 z-20" src={Title2} />
      <img className="cursor-pointer m-auto" src={[ActivityBg1, ActivityBg2, ActivityBg3, ActivityBg4][current]} />
      <div className="absolute right-[320px] top-[100px] flex flex-col gap-y-2 z-30">
        <img className="cursor-pointer h-[140px]" src={current === 0 ? ActivityLogo1Active : ActivityLogo1} onClick={() => setCurrent(0)} />
        <img className="cursor-pointer h-[140px]" src={current === 1 ? ActivityLogo2Active : ActivityLogo2} onClick={() => setCurrent(1)} />
        <img className="cursor-pointer h-[140px]" src={current === 2 ? ActivityLogo3Active : ActivityLogo3} onClick={() => setCurrent(2)} />
        <img className="cursor-pointer h-[140px]" src={current === 3 ? ActivityLogo4Active : ActivityLogo4} onClick={() => setCurrent(3)} />
      </div>
    </div>
  )
}