import socket, time, sys

HOST = "192.168.192.40"
PORT = 4005

# Pass the command to repeat as argv[1], e.g. "CMD", "CMDSTATE", "RA", "AD 0", "PO"
poll_cmd = sys.argv[1] if len(sys.argv) > 1 else "CMDSTATE"

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.settimeout(3)
s.connect((HOST, PORT))
t_start = time.time()
print(f"[{0.0:.3f}] connected, poll_cmd={poll_cmd!r}")

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

send("F")
read_reply("F (power off) reply")
time.sleep(1.0)

send("S1")
read_reply("S1 baseline (confirmed OFF)")

send("N")
read_reply("N reply")

# Poll ONLY the command under test, at ~1s interval (matching original SCAN_FAST),
# plus a S1 check each time so we can see when/if it reverts.
for i in range(10):
    time.sleep(1.0)
    send(poll_cmd)
    read_reply(f"{poll_cmd} #{i}")
    send("S1")
    read_reply(f"S1 #{i}")

print("=== done ===")
s.close()
