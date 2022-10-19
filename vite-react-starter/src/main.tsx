import { StrictMode } from 'react'
import ReactDOM from 'react-dom/client'
import './index.css'
import App from './App'

ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  <StrictMode>
    <App />
  </StrictMode>
)

// 所以vue,react同时渲染是可行的,但是不推荐
ReactDOM.createRoot(document.getElementById('root2') as HTMLElement).render(
  <div>多root渲染</div>
)
