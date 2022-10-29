import { useState } from 'react'
import Video from './components/Video'
import Title from '../../assets/y-title-4.png'
import Hero1 from '../../assets/y-hero-1.png'
import Hero2 from '../../assets/y-hero-2.png'
import Hero3 from '../../assets/y-hero-3.png'
import Hero4 from '../../assets/y-hero-4.png'
import Hero5 from '../../assets/y-hero-5.png'
import Avatar1 from '../../assets/y-hero-avatar1.png'
import Avatar1Active from '../../assets/y-hero-avatar1-active.png'
import Avatar2 from '../../assets/y-hero-avatar2.png'
import Avatar2Active from '../../assets/y-hero-avatar2-active.png'
import Avatar3 from '../../assets/y-hero-avatar3.png'
import Avatar3Active from '../../assets/y-hero-avatar3-active.png'
import Avatar4 from '../../assets/y-hero-avatar4.png'
import Avatar4Active from '../../assets/y-hero-avatar4-active.png'
import Avatar5 from '../../assets/y-hero-avatar5.png'
import Avatar5Active from '../../assets/y-hero-avatar5-active.png'
import CnCv1 from '../../assets/y-cn-cv-01.png'
import CnCvActive1 from '../../assets/y-cn-cv-active-01.png'
import JpCv1 from '../../assets/y-jp-cv-01.png'
import JpCvActive1 from '../../assets/y-jp-cv-active-01.png'
import VideoBtn from '../../assets/y-video-btn.png'
import VideoActiveBtn from '../../assets/y-video-active-btn.png'
import AudioAsset from '../../assets/audio.mp3'
export default () => {
  const [current, setCurrent] = useState(0)
  const [cv, setCv] = useState('')
  const [status, setStatus] = useState(false)
  const play = (type: 'CnCv1' | 'JpCv1') => {
    playAudio()
    setCv(type)
  }
  const handler = (e: any, type?: 'prevent') => {
    if (type) {
      e.stopPropagation()
    } else {
      setStatus(false)
    }
  }
  const playAudio = () => {
    const audio = new Audio()
    audio.src = AudioAsset
    audio.play()
    audio.onended = () => {
      setCv('')
    }
  }
  return (
    <div className="flex justify-center items-center relative w-screen h-screen bg-[url('/img/bg-4.png')]">
      <img className="w-full h-full z-10 object-cover" src={[Hero1, Hero2, Hero3, Hero4, Hero5][current]} />
      <img className="cursor-pointer absolute left-[100px] top-[40px] z-20" src={Title} />
      <img className="cursor-pointer absolute left-[720px] top-[180px] z-20 w-[80px]" src={VideoBtn} onClick={() => setStatus(true)} />
      <div className="absolute left-[460px] top-[540px] z-20">
        <img className="cursor-pointer h-[70px]" src={cv === 'CnCv1' ? CnCvActive1 : CnCv1} onClick={() => play('CnCv1')} />
        <img className="cursor-pointer mt-[20px] h-[70px]" src={cv === 'JpCv1' ? JpCvActive1 : JpCv1} onClick={() => play('JpCv1')} />
      </div>
      <div className="absolute bottom-[60px] z-20 flex gap-x-14">
        <img className="w-[50px] cursor-pointer" src={current === 0 ? Avatar1Active : Avatar1} onClick={() => setCurrent(0)} />
        <img className="w-[50px] cursor-pointer" src={current === 1 ? Avatar2Active : Avatar2} onClick={() => setCurrent(1)} />
        <img className="w-[50px] cursor-pointer" src={current === 2 ? Avatar3Active : Avatar3} onClick={() => setCurrent(2)} />
        <img className="w-[50px] cursor-pointer" src={current === 3 ? Avatar4Active : Avatar4} onClick={() => setCurrent(3)} />
        <img className="w-[50px] cursor-pointer" src={current === 4 ? Avatar5Active : Avatar5} onClick={() => setCurrent(4)} />
      </div>
      { status && <Video handler={handler} /> }
    </div>
  )
}