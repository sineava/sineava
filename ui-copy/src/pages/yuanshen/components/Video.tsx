export default ({ handler }: any) => (
  <div className="fixed top-0 left-0 w-full h-full z-30" onClick={handler}>
    <video className="absolute m-auto left-0 top-0 right-0 bottom-0 z-40" width="640px" preload="auto" controls autoPlay controlsList="nodownload" onClick={(e) => handler(e, 'prevent')}>
      <source src="https://webstatic.mihoyo.com/upload/static-resource/2022/09/16/f536b81cf99ea2c2a2ae87b1e643ec4c_7786134220728107534.mp4" type="video/mp4" />
      浏览器不支持mp4格式
    </video>
    <div className="absolute w-full h-full bg-[#000] opacity-70 z-10"></div>
  </div>
)