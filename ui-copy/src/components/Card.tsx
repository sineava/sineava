import { Component, createRef } from 'react'

export default class extends Component<any, any> {
  canvasRef: any
  constructor(props: any) {
    super(props)
    this.canvasRef = createRef()
  }
  componentDidMount() {
    const ctx = this.canvasRef.current.getContext('2d')
    ctx.lineWidth = 2
    ctx.beginPath()
    ctx.moveTo(0,100)
    ctx.lineTo(77,80)
    ctx.lineTo(154,90)
    ctx.lineTo(231, 18)
    ctx.strokeStyle = '#198944'
    ctx.stroke()
    ctx.closePath()

    ctx.beginPath()
    ctx.arc(231,18, 4, 0, 2 * Math.PI, true)
    ctx.fillStyle = '#1EA551'
    ctx.fill()
    ctx.lineTo(308, 40)
    ctx.lineTo(385, 0)
    ctx.strokeStyle = '#198944'
    ctx.stroke()
  }
  render() {
    const { title, color, img, num, percent } = this.props
    return (
      <div className="p-[26px] rounded bg-[#292B29] w-[440px] h-[260px]">
        <div className="flex justify-between">
          <span className="text-[#7A7A7A]">{title}</span>
          <div className={`w-[44px] h-[30px] flex justify-center items-center ${color} rounded-sm`}>
            <img src={img} />
          </div>
        </div>
        <div className="mt-[30px] flex justify-between">
          <span className="text-[#fff] text-xl">{num}</span>
          <div>
            <span className={`${percent > 0 ? 'text-[#228D39]' : 'text-[#EBAE5B]'}`}>{percent > 0 && '+'}{percent}%</span>
          </div>
        </div>
        <div className="relative">
          <canvas ref={this.canvasRef} width="385" height="100" className="mt-[22px]"></canvas>
          <span className="px-2 py-[1px] bg-[#D9D9D9] rounded-3xl text-[#474545] absolute -top-5 left-[204px]">
            $200
          </span>
        </div>
      </div>
    )
  }
}