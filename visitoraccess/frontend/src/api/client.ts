export async function getHealth(): Promise<boolean> {
  try {
    const res = await fetch('http://127.0.0.1:8000/health')
    return res.ok
  } catch (err) {
    return false
  }
}
