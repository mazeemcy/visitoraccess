import React from 'react'

export default function Login() {
  return (
    <form onSubmit={(e) => e.preventDefault()}>
      <div>
        <label>Username<br /><input name="username" /></label>
      </div>
      <div>
        <label>Password<br /><input name="password" type="password" /></label>
      </div>
      <button type="submit">Sign in</button>
    </form>
  )
}
