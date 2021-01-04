set -x BUILD_CONCURRENCY (math -s0 (nproc) / 2)

# https://docs.conan.io/en/latest/reference/env_vars.html#conan-password-conan-password-remote-name
set -x CONAN_PASSWORD_GITLAB $GITLAB_TOKEN
