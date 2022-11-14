// 引入css
const link = document.createElement('link')
link.rel = 'stylesheet'
link.href = 'https://npm.elemecdn.com/picture-bed@1.0.9/css/scrollbar.css'
document.head.appendChild(link)

// 解决csdn无法复制问题
const views = document.querySelector('#content_views')
views && views.removeAttribute('id')

// 解决csdn的登录后复制显示
;[...document.querySelectorAll('.hljs-button')].forEach(
  item => item.setAttribute('style', 'opacity: 0')
)

// 去除顶部栏
const toolbarTop = document.querySelector('#csdn-toolbar')
toolbarTop && toolbarTop.parentNode.removeChild(toolbarTop)

// 隐藏侧边栏
const leftAside = document.querySelector('.blog_container_aside')
leftAside && leftAside.parentNode.removeChild(leftAside)
const rightAside = document.querySelector('#rightAside')
rightAside && rightAside.parentNode.removeChild(rightAside)

// 中间适配
const mainBox = document.querySelector('#mainBox')
const main = document.querySelector('#mainBox main')
mainBox.setAttribute('style', 'width: 100%;display: flex;justify-content: center')
main.setAttribute('style', 'width: 90vw !important;opacity: .9;')

// 去除右侧通知
const toolbar = document.querySelector('.csdn-side-toolbar')
toolbar && toolbar.parentNode.removeChild(toolbar)

// 更换背景图片
document.body.setAttribute('style', `background-image: url('https://npm.elemecdn.com/picture-bed@1.0.8/cover/bg-06.jpg') !important;background-attachment:fixed;background-size:cover;`)

// 去除所有底部信息
let child = main.lastElementChild
while(child && main.children.length > 2) {
  main.removeChild(child)
  child = main.lastElementChild
}