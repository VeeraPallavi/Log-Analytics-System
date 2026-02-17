#!/usr/bin/env python3
import sys
import re

log_pattern = re.compile( r'^(\S+) \S+ \S+ \[([^\]]+)\] "(\S+) ([^"]+) (\S+)" (\d{3})')

for line in sys.stdin:
    try:
        match = log_pattern.match(line)
        if not match:
            continue

        status_code = int(match.group(6))
        endpoint = match.group(4)

        if status_code >= 400:
            print(f"STATUS_{status_code}\t1")
            print(f"ENDPOINT_{endpoint}\t1")

    except Exception:
        continue

