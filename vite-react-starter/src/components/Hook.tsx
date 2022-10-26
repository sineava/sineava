import { useEffect, useState, useContext } from 'react'
import Context from './Context'
import { useWindowWidth } from './useWidth'

export default function() {
  const [name, setName] = useState('')
  const [password, setPassword] = useState('')
  const theme = useContext(Context)
  const width = useWindowWidth()
  useEffect(() => {
    document.title = `${name} ${password}`
  })
  function handleNameChange(e: any) {
    setName(e.target.value)
  }
  function handlePasswordChange(e: any) {
    setPassword(e.target.value)
  }
  return (
    <section className={`p-4 ${theme}`}>
      <label>
        username:
        <input type="text" value={name} onChange={handleNameChange} className="border border-black ml-2" />
      </label>
      <label className="ml-2">
        password:
        <input type="password" value={password} onChange={handlePasswordChange} className="border border-black ml-2" />
      </label>
      <label className="ml-2">
        width:
        <span className="ml-2">{ width }</span>
      </label>
    </section>
  )
}