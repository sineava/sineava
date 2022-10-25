import { Component } from 'react'
import logo from '../assets/logo.png'
import setting from '../assets/setting.png'
import alarm from '../assets/alarm.png'
import avatar from '../assets/avatar.png'

export default class extends Component<any, any> {
  constructor(props: any) {
    super(props)
    this.state = {
      list: ['Overview', 'Analytics', 'Products', 'Reports'],
      current: 0
    }
  }
  trigger = (i: number) => {
    this.setState({ current: i })
  }
  render() {
    const { list, current } = this.state
    return (
      <div className="h-[110px] flex items-center justify-start border-b-[1px] border-[#817C7C]">
        <div className="flex text-base items-center w-[167px]">
          <img src={logo} className="w-[28px] " />
          <span className="ml-[10px] text-[#fff] font-bold">Stocker</span>
        </div>
        <ul className="flex justify-start text-[#7A7A7A]">
          { list.map((nav: string, i: number) => <li key={i} className={`mr-[20px] cursor-pointer ${current === i ? 'text-[#fff]' : ''}`} onClick={this.trigger.bind(this, i)}>{ nav }</li>) }
        </ul>
        <div className="ml-auto flex">
          <div className="t-icon"><img src={setting} /></div>
          <div className="t-icon ml-[40px] relative">
            <img src={alarm} />
            <div className="w-[6px] h-[6px] bg-[#DBCA2F] rounded-full absolute top-3 right-3" />
          </div>
          <img src={avatar} className="t-rotate w-[50px] h-[50px] ml-[40px] rounded-full cursor-pointer" />
          <div className="ml-[18px]">
            <p className="text-bold text-[#fff]">Grosiran shop</p>
            <p className="text-sm text-[#7A7A7A]">wholesaler</p>
          </div>
        </div>
      </div>
    )
  }
}