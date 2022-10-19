import { Component } from 'react'

const arr = [
  {category: "Sporting Goods", price: "$49.99", stocked: true, name: "Football"},
  {category: "Sporting Goods", price: "$9.99", stocked: true, name: "Baseball"},
  {category: "Sporting Goods", price: "$29.99", stocked: false, name: "Basketball"},
  {category: "Electronics", price: "$99.99", stocked: true, name: "iPod Touch"},
  {category: "Electronics", price: "$399.99", stocked: false, name: "iPhone 5"},
  {category: "Electronics", price: "$199.99", stocked: true, name: "Nexus 7"}
];

export default class extends Component {
  render() {
    return (
      <div className="w-[400px] border border-cyan-400 p-2 rounded">
        <input className="border border-grey-500 w-full p-1 rounded" type="text" value="2233" readOnly />
        <Box />
      </div>
    )
  }
}

class Child extends Component<any> {
  constructor(props: any) {
    super(props)
  }
  render() {
    const { title } = this.props
    return arr.filter((x: any) => x.category === title).map((x: any, i: number) => <div key={i} className="text-sm flex justify-between">
      <span>{x.name}</span>
      <span className="text-gray-600">{x.price}</span>
    </div>)
  }
}

class Box extends Component {
  constructor(props: any) {
    super(props)
  }
  render() {
    const category: any = new Set(arr.map((x: any) => x.category))
    return (
      <div className="border border-yellow-400 mt-2 py-1 px-2">
        { Array.from(category).map((x: any, i: number) => (
          <div key={ i }>
            <div className="text-bold text-red-500 text-lg">{x}</div>
            <Child title={x} />
          </div>
        )) }
      </div>
    )
  }
}