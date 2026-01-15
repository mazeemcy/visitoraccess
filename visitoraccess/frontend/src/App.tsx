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
    <div style={{ fontFamily: 'Arial, sans-serif', padding: 20 }}>
      <h1>Visitor Access - Frontend (Minimal)</h1>
      <div style={{ marginBottom: 12 }}>
        <button onClick={checkHealth}>Check backend /health</button>
        {status && <span style={{ marginLeft: 8 }}>Status: {status}</span>}
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 12 }}>
        <div style={{ border: '1px solid #ddd', padding: 12 }}>
          <h2>Pages</h2>
          <Dashboard />
          <Controllers />
          <Zones />
        </div>

        <div style={{ border: '1px solid #ddd', padding: 12 }}>
          <h2>Login</h2>
          <Login />
        </div>
      </div>
    </div>
  )
}

export default App
