import { Component } from 'react'
import search from '../assets/search.png'
import add from '../assets/add.png'

export default class extends Component<any, any> {
  table: {
    header: string[]
    list?: Array<Array<String | Boolean | Number>>
  }
  constructor(props: any) {
    super(props)
    this.table = {
      header: ['ck', 'ID Product', 'Product  Name', 'Stock', 'Price', 'Total Sales', 'Status'],
      list: [
        ['ck', 'ABC-12X', 'Syrup xyz', 40, '$1,200', 150, true],
        ['ck', 'FJK-190', 'Ketch trup', 20, '$799', 200, false],
        ['ck', 'ASW-180', 'Temls', 15, '$1,150', 120, true],
        ['ck', 'BMW-701', 'Stela', 100, '$8,100', 18, true]
      ]
    }
  }
  render() {
    const { header, list } = this.table
    const headerList = header.map((item: any, i: number) => <div className="t-cell">
      {i === 0 ? <input type="checkbox" /> :item}
    </div>)
    const available = <div className="bg-[#E0F7EC] text-[#7DD3AE] flex justify-center items-center w-[112px] h-[30px] m-auto">Available</div>
    const restock = <div className="bg-[#FDD6C5] text-[#FE6B01] flex justify-center items-center w-[112px] h-[30px] m-auto">Restock</div>
    const bodyList = list && list.map((i: any) => {
      const list = i.map((j: any, index: number) => {
        return <div className="t-cell align-middle">
          { index !== 0 ? index === i.length - 1 ? j ? available : restock : j : <input type="checkbox" /> }
        </div>
      })
      return (
        <div className={`table-row bg-[#fff] h-[70px] ${i !== 0 && 'border-[1px] border-[#484848] border-opacity-10'}`}>{ list }</div>
      )
    })
    return (
      <div className="mt-[58px] px-[200px]">
        <div className="flex justify-between">
          <span className="text-[#000] text-[20px] text-bold">Product Selling</span>
          <div className="relative flex">
            <input type="search" placeholder="Search" className="border border-gray-2 outline-none w-[196px] h-[30px] rounded indent-8" />
            <img className="absolute top-2 left-2" src={search} />
            <div className="w-[110px] h-[30px] bg-[#000] flex justify-center items-center rounded ml-[24px] text-[#fff] cursor-pointer">
              <img src={add} className="w-[12px]" />
              <span className="text-xs ml-[8px]">New Product</span>
            </div>
          </div>
        </div>
        <div className="table border-collapse w-full mt-[55px]">
          <div className="table-row bg-[#ECECEC] h-[70px] border-[1px]">{headerList}</div>
          {bodyList}
        </div>
      </div>
    )
  }
}