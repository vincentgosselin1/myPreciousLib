# pc_receiver.py — run on the Windows lab PC
import socket

HOST = "0.0.0.0"
PORT = 5000
OUT_FILE = "counter_log.txt"

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((HOST, PORT))
    s.listen(1)
    print(f"Listening on port {PORT}...")
    conn, addr = s.accept()
    print(f"Connected by {addr}")

    with conn, open(OUT_FILE, "a") as f:
        buffer = ""
        while True:
            data = conn.recv(1024).decode()
            if not data:
                break
            buffer += data
            while "\n" in buffer:
                line, buffer = buffer.split("\n", 1)
                print(line)
                f.write(line + "\n")
                f.flush()
