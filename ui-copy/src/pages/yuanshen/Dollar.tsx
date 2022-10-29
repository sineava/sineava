import Title from '../../assets/y-title-1.png'

export default () => {
  return (
    <div className="relative w-screen h-screen bg-[url('/img/bg-2.png')]">
      <img className="cursor-pointer absolute left-[100px] top-[40px]" src={Title} />
    </div>
  )
}