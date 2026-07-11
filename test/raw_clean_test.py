import socket, time

HOST = "192.168.192.40"
PORT = 4005

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.settimeout(3)
s.connect((HOST, PORT))
t_start = time.time()
print(f"[{0.0:.3f}] connected")

def send(cmd):
    s.sendall((cmd + "\r").encode())
    print(f"[{time.time()-t_start:.3f}] SENT: {cmd!r}")

def read_reply(label, timeout=2.0):
    s.settimeout(timeout)
    buf = b""
    try:
        while True:
            data = s.recv(4096)
            if not data:
                break
            buf += data
            if b"\r" in buf:
                break
    except socket.timeout:
        pass
    print(f"[{time.time()-t_start:.3f}] {label}: {buf!r}")
    return buf

send("ADR 10")
read_reply("ADR reply")

# Force a clean, known OFF baseline first.
send("F")
read_reply("F (power off) reply")
time.sleep(1.0)

send("S1")
read_reply("S1 baseline (confirmed OFF)")

send("CMDSTATE")
read_reply("CMDSTATE baseline")

send("N")
read_reply("N reply")

gaps = [0.2, 0.2, 0.3, 0.3, 0.5, 0.5, 1.0, 1.0, 2.0, 2.0]
for gap in gaps:
    time.sleep(gap)
    send("S1")
    read_reply("S1")

print("=== done ===")
s.close()
