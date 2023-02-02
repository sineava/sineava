import { WebSocketServer } from 'ws'

const wss = new WebSocketServer({ port: 8080 })
let clients = [] // 连接池

wss.on('connection', function connection(ws, req) {
  ws.on('message', function message(data) {
    const { type, ...user } = JSON.parse(data)
    if (type === 0) { // 退出连接
      clients = clients.filter(client => client.username !== user.username)
      clients.forEach(w => {
        w.send(JSON.stringify({ payload: user.nickname, type }))
      })
    }
    if (type === 1) { // 初次进入
      const index = clients.findIndex(client => client.username === user.username)
      ws.username = user.username
      if (index === -1) {
        clients.push(ws)
      } else {
        clients[index] = ws
      }
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
        if (w.username !== user.username) {
          w.send(JSON.stringify({ payload: { ...user }, type }))
        }
      })
    }
    console.log(clients.length)
  })
})

wss.on('close', function close(ws) {
  console.log(ws)
})