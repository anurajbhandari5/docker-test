FROM ubuntu:latest
RUN apt-get update \
  && apt-get install -y --no-install-recommends curl ca-certificates \
  && rm -rf /var/lib/apt/lists/*

RUN --mount=type=secret,id=test_username \
  --mount=type=secret,id=test_password << 'EOF'
set -eu;
username="$(cat /run/secrets/test_username)"
password="$(cat /run/secrets/test_password)"
test -n "$username"
test -n "$password"
curl -fsS -u "$username:$password" "https://httpbin.org/basic-auth/user/passwd" > /tmp/auth-response.json
grep -q '"authenticated": true' /tmp/auth-response.json
grep -q '"user": "user"' /tmp/auth-response.json
EOF
CMD ["/bin/bash"]
  
