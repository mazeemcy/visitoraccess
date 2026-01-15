import React, { useState } from 'react'
import { getHealth } from './api/client'
import Dashboard from './pages/Dashboard'
import Controllers from './pages/Controllers'
import Zones from './pages/Zones'
import Login from './pages/Login'

const App: React.FC = () => {
  const [status, setStatus] = useState<string | null>(null)

  const checkHealth = async () => {
    const h = await getHealth()
    setStatus(h ? 'healthy' : 'unreachable')
  }

  return (
    <div className="app">
      <header className="header">
        <div className="logo">VA</div>
        <div>
          <h1 className="title">Visitor Access</h1>
          <div className="sub">Simple demo UI — responsive & themed</div>
        </div>
        <div style={{marginLeft:'auto'}} className="controls">
          <button className="btn" onClick={checkHealth}>Check /health</button>
          {status && <div className="small">Status: {status}</div>}
        </div>
      </header>

      <div className="grid">
        <div className="card">
          <h2>Pages</h2>
          <div className="page-list">
            <div className="page-item"><Dashboard /></div>
            <div className="page-item"><Controllers /></div>
            <div className="page-item"><Zones /></div>
          </div>
        </div>

        <aside className="card">
          <h2>Login</h2>
          <Login />
        </aside>
      </div>

      <div className="footer">Built with ♥ — responsive layout and modern theme</div>
    </div>
  )
}

export default App
