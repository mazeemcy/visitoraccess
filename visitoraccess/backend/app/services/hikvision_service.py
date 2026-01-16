from requests.auth import HTTPDigestAuth
import requests


class HikvisionService:
    """Service for Hikvision access controllers"""

    def __init__(self, ip: str, port: int, username: str, password: str):
        self.ip = ip
        self.port = port
        self.username = username
        self.password = password
        self.base_url = f"http://{ip}:{port}/ISAPI"

    def get_device_info(self):
        """Fetch basic device information (placeholder)."""
        try:
            resp = requests.get(
                f"{self.base_url}/System/deviceInfo",
                auth=HTTPDigestAuth(self.username, self.password),
                timeout=5,
            )
            resp.raise_for_status()
            # Some devices may not return JSON; return text as fallback
            try:
                return resp.json()
            except Exception:
                return resp.text
        except Exception:
            return None
