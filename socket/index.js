import { WebSocketServer } from 'ws'

const wss = new WebSocketServer({ port: 8080 })
const clients = [] // 连接池

wss.on('connection', function connection(ws) {
  clients.push(ws)
  ws.on('message', function message(data) {
      const { type, ...user } = JSON.parse(data)
      if (type === 0) { // 退出连接
        clients.forEach(w => {
          w.send(JSON.stringify({ payload: user.nickname, type }))
        })
      }
      if (type === 1) { // 初次进入
        clients.forEach(w => {
          w.send(JSON.stringify({ payload: user.nickname, type }))
        })
      }
      if (type === 2) { // 发送消息
        const date = new Date()
        const hours = date.getHours()
        const minutes = date.getMinutes()
        clients.forEach(w => {
          w.send(JSON.stringify({ payload: { ...user, time: `${hours}:${minutes}` }, type }))
        })
      }
      if (type === 3) { // 图片传输
        clients.forEach(w => {
          w.send(JSON.stringify({ payload: { ...user }, type }))
        })
      }
  })
})

wss.on('close', function close(ws) {
  console.log(ws)
})