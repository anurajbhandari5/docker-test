FROM ubuntu:latest
RUN --mount=type=secret,id=test_username \
  --mount=type=secret,id=test_password \
  set -eu; \
  username="$(cat /run/secrets/test_username)"; \
  password="$(cat /run/secrets/test_password)"; \
  test -n "$username"; \
  test -n "$password"; \
  printf 'TEST_USERNAME=%s\n' "$username"; \
  printf 'TEST_PASSWORD=%s\n' "$password"

CMD ["/bin/bash"]
  
