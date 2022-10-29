import { useState } from 'react'
import Video from './components/Video'
import Logo from '../../assets/y-logo.png'
import Enter from '../../assets/y-enter.png'
import EnterActive from '../../assets/y-enter-active.png'
import Play from '../../assets/y-play.png'
import PlayActive from '../../assets/y-play-active.png'
import PcDownload from '../../assets/y-pc-download.png'
import PcDownloadActive from '../../assets/y-pc-download-active.png'
import OtherDownload from '../../assets/y-other-download.png'
import OtherDownloadActive from '../../assets/y-other-download-active.png'
import CloudDownload from '../../assets/y-cloud-download.png'
import CloudDownloadActive from '../../assets/y-cloud-download-active.png'
import Allow from '../../assets/y-allow.png'

export default () => {
  type Type = '' | 'enter' | 'play' | 'pc' | 'other' | 'cloud'
  const [active, setActive] = useState('')
  const [play, setPlay] = useState(false)
  const toggle = (type: Type) => {
    setActive(type)
  }
  const playVideo = () => {
    setPlay(true)
  }
  const handler = (e: any, type?: 'prevent') => {
    if (type) {
      e.stopPropagation()
    } else {
      setPlay(false)
    }
  }
  const effect = (type: Type) => {
    return {
      onMouseEnter: () => toggle(type),
      onMouseLeave: () => toggle('')
    }
  }
  return (
    <div className="relative w-screen h-screen bg-[url('/img/bg-1.png')]">
      <div className="ml-[52px] mr-[100px] flex justify-between items-center">
        <img src={Logo} className="cursor-pointer" />
        <img className="cursor-pointer" src={active === 'enter' ? EnterActive : Enter} { ...effect('enter') } />
      </div>
      <div className="absolute bottom-[126px] right-[610px]">
        <img className="cursor-pointer w-5/6" src={active === 'play' ? PlayActive : Play} { ...effect('play') } onClick={playVideo} />
      </div>
      { play && <Video handler={handler} /> }
      <img src={Allow} className="absolute bottom-[30px] ml-[100px] cursor-pointer" />
      <div className="absolute bottom-[30px] w-full flex justify-center gap-x-2">
        <img className="cursor-pointer w-[300px]" src={active === 'pc' ? PcDownloadActive : PcDownload} { ...effect('pc') } />
        <img className="cursor-pointer w-[300px]" src={active === 'other' ? OtherDownloadActive : OtherDownload} { ...effect('other') } />
        <img className="cursor-pointer w-[300px]" src={active === 'cloud' ? CloudDownloadActive : CloudDownload} { ...effect('cloud') } />
      </div>
    </div>
  )
}