import React from 'react'

export default function Login() {
  return (
    <form onSubmit={(e) => e.preventDefault()}>
      <div className="form-row">
        <label>Username</label>
        <input name="username" placeholder="jane.doe" />
      </div>
      <div className="form-row">
        <label>Password</label>
        <input name="password" type="password" placeholder="••••••••" />
      </div>
      <div style={{display:'flex',gap:8}}>
        <button className="btn" type="submit">Sign in</button>
        <button className="btn" type="button" style={{background:'transparent', border:'1px solid rgba(255,255,255,0.06)', color:'var(--text)'}}>Forgot?</button>
      </div>
    </form>
  )
}
