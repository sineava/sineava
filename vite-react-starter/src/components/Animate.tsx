import { Component } from 'react'

export default class extends Component<any, any> {
  constructor(props: any) {
    super(props)
    this.state = {
      percent: 10,
      type: '',
      tabs: ['标签一', '标签二', '标签三']
    }
  }
  add = (type: 'js' | 'css') => {
    this.setState({ type })
    if (type === 'js') { // js方式控制
      const { percent } = this.state
      const targetPercent = percent >= 90 ? 100 : percent + 10
      const speed = (targetPercent - percent) / 400
      let start: null | number = null
      const animate = (timestamp: number) => {
        if (!start) start = timestamp
        const progress = timestamp - start
        const current = Math.min(parseInt(speed * progress + percent), targetPercent)
        this.setState({
          percent: current
        })
        if (current < targetPercent) {
          window.requestAnimationFrame(animate)
        }
      }
      window.requestAnimationFrame(animate)
    }
    if (type === 'css') {
      this.setState((state: any) => ({ percent: state.percent >= 90 ? 100 : state.percent + 10 }))
    }
  }
  decrement = (type: 'js' | 'css') => {
    this.setState({ type })
    if (type === 'js') {
      const { percent } = this.state
      const targetPercent = percent <= 10 ? 0 : percent - 10
      const speed = (percent - targetPercent) / 400
      let start: null | number = null
      const animate = (timestamp: number) => {
        if (!start) start = timestamp
        const progress = timestamp - start
        const current = Math.max(parseInt(String(percent - speed * progress), 10), targetPercent)
        this.setState({
          percent: current
        })
        if (current > targetPercent) {
          window.requestAnimationFrame(animate)
        }
      }
      window.requestAnimationFrame(animate)
    }
    if (type === 'css') {
      this.setState((state: any) => ({ percent: state.percent <= 10 ? 0 : state.percent - 10 }))
    }
  }
  render() {
    const { percent, type, tabs } = this.state
    const renderTabs = tabs.map((tab: any, i: number) => (
      <div key={i} className="t-tab">
        <span>{ tab }</span>
        <span className="ml-2 text-[#aaa] cursor-pointer">x</span>
      </div>
    ))
    return (
      <section>
        <div className="m-4">
          <p>requestAnimationFrame实现动画</p>
          <div className="w-full h-[20px] rounded-lg">
            <div className={`bg-green-500 h-full rounded text-[#fff] flex items-center ${type === 'css' && 't-progress'}`} style={{ width: `${percent}%` }}>{ percent }</div>
          </div>
          <div className="mt-2">
            <button className="w-[40px] py-1 bg-green-500 text-[#fff] rounded" onClick={() => this.add('js')}>+</button>
            <button className="w-[40px] py-1 bg-green-500 text-[#fff] rounded ml-2" onClick={() => this.decrement('js')}>-</button>
          </div>
        </div>
        <div className="m-4">
          <p>css方式实现动画</p>
          <div className="mt-2">
            <button className="w-[40px] py-1 bg-green-500 text-[#fff] rounded" onClick={() => this.add('css')}>+</button>
            <button className="w-[40px] py-1 bg-green-500 text-[#fff] rounded ml-2" onClick={() => this.decrement('css')}>-</button>
          </div>
        </div>
        <div className="m-4">
          <p>transition组件动画</p>
          <div className="flex">
            { renderTabs }  
          </div>
        </div>
      </section>
    )
  }
}