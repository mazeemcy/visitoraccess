import React from 'react'
import { render, screen } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import useTheme from './useTheme'

function TestComponent() {
  const { theme, toggle } = useTheme()
  return (
    <div>
      <span data-testid="theme">{theme}</span>
      <button onClick={toggle}>toggle</button>
    </div>
  )
}

describe('useTheme', () => {
  beforeEach(() => {
    localStorage.clear()
    // reset classlist
    document.documentElement.classList.remove('theme-light')
  })

  test('defaults to system preference when no localStorage entry', async () => {
    // mock matchMedia to prefer light
    Object.defineProperty(window, 'matchMedia', {
      writable: true,
      value: (query: string) => ({ matches: query.includes('light'), addListener: () => {}, removeListener: () => {} }),
    })

    render(<TestComponent />)

    const theme = await screen.findByTestId('theme')
    expect(theme).toHaveTextContent('light')
    expect(document.documentElement.classList.contains('theme-light')).toBe(true)
  })

  test('reads from localStorage and toggles theme & persists', async () => {
    localStorage.setItem('va_theme', 'dark')
    render(<TestComponent />)

    const theme = await screen.findByTestId('theme')
    expect(theme).toHaveTextContent('dark')
    expect(document.documentElement.classList.contains('theme-light')).toBe(false)

    await userEvent.click(screen.getByRole('button', { name: /toggle/i }))

    // after toggle should be light
    expect(document.documentElement.classList.contains('theme-light')).toBe(true)
    expect(localStorage.getItem('va_theme')).toBe('light')
  })
})
