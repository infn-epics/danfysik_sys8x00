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

def cmd(c, label):
    send(c)
    return read_reply(label)

cmd("ADR 10", "ADR reply")
cmd("F", "F (power off) reply")
time.sleep(1.0)
cmd("S1", "S1 baseline (confirmed OFF)")
cmd("N", "N reply")

# Exact 1-second poll group matching danfysik.template's SCAN_FAST=1s records:
# CMD, CMDSTATE, RA, AD 0, AD 8, AD 2, RAR, RR, PO, S1, S1(dup), PO(dup)
poll_sequence = ["CMD", "CMDSTATE", "RA", "AD 0", "AD 8", "AD 2", "RAR", "RR", "PO", "S1", "S1", "PO"]

for tick in range(10):
    time.sleep(1.0)
    print(f"--- tick {tick} ---")
    for c in poll_sequence:
        r = cmd(c, c)
        if c == "S1" and b"!" in r and len(r) >= 30:
            pass

print("=== done ===")
s.close()
