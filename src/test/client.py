import socket
import time

HOST = '127.0.0.1'
PORT = 3080

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:

    s.connect((HOST, PORT))

    while True:
        s.sendall(b'Hello, world\r\n\r\n')
        time.sleep (2)

