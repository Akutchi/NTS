import socket
import time
import json

HOST = '127.0.0.1'
PORT = 3080

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:

    s.connect((HOST, PORT))
    m = {"test": "this is a test"}
    data = json.dumps(m)

    while True:
        s.sendall(bytes(data, encoding="utf-8"))
        time.sleep (2)

