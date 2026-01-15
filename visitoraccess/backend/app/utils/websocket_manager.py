from typing import List, Dict


class ConnectionManager:
    def __init__(self):
        self.active_connections: Dict[str, List] = {}

    async def connect(self, websocket, client_id: str):
        if client_id not in self.active_connections:
            self.active_connections[client_id] = []
        self.active_connections[client_id].append(websocket)

    def disconnect(self, websocket, client_id: str):
        if client_id in self.active_connections:
            self.active_connections[client_id].remove(websocket)


manager = ConnectionManager()
