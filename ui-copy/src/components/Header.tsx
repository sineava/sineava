import { Component } from 'react'
import TopBar from './TopBar'
import Card from './Card'
import menu from '../assets/menu.png'
import down from '../assets/down.png'
import dollar from '../assets/dollar.png'
import book from '../assets/book.png'
import chart from '../assets/chart.png'

export default class extends Component<any, any> {
  constructor(props: any) {
    super(props)
    this.state = {
      list: ['Overview', 'Analytics', 'Products', 'Reports'],
      current: 0,
      cards: [
        { id: 1, title: 'Total Revenue', color: 'bg-[#24924E]', img: dollar, num: '$4.852', percent: 30 },
        { id: 2, title: 'Total Orders', color: 'bg-[#EBAE5B]', img: book, num: '12.107', percent: -10 },
        { id: 3, title: 'Avg.order value', color: 'bg-[#D3A070]', img: chart, num: '15.306', percent: 30 }
      ]
    }
  }
  render() {
    const { cards } = this.state
    const cardsList = cards.map((card: any) => <Card key={card.id} {...card}/>)
    return <div className="bg-[#181A1C] h-[544px] px-[200px]">
      <TopBar />
      <div className="flex justify-between items-center mt-[65px]">
        <div>
          <p className="text-[#fff] text-bold text-xl">Overview</p>
          <p className="text-[#7A7A7A] mt-[12px]">overview reports of your product</p>
        </div>
        <div className="flex">
          <div className="w-[90px] h-[30px] border border-[#454242]-2 rounded-sm flex justify-evenly items-center cursor-pointer">
            <img className="w-[10px]" src={menu} />
            <span className="text-[#7A7A7A] text-xs">Weekly</span>
            <img className="w-[6px]" src={down} />
          </div>
          <div className="px-[8px] h-[30px] bg-[#315F26] text-xs text-[#fff] flex justify-center items-center cursor-pointer rounded-sm ml-[20px]">
            More analystic
          </div>
        </div>
      </div>
      <div className="flex mt-[32px] gap-x-[99px]">
        { cardsList }
      </div>
    </div>
  }
}