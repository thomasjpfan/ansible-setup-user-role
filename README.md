# Ansible Setup User

[![Build Status](https://travis-ci.org/thomasjpfan/ansible-setup-user-role.svg?branch=master)](https://travis-ci.org/thomasjpfan/ansible-setup-user-role)

Setups User and SSH keys

## Role Varialbes

```yaml
# User and groups to create
deploy_user: deploy
deploy_groups: ["docker"]

# Public key to include in authorized_key
deploy_local_public_key:

# Hashedp password for deploy user
deploy_hashed_password:
```

## Testing

This project uses [ansible-ubuntu-local-runner)](https://github.com/thomasjpfan/ansible-ubuntu-local-runner) to run tests in a docker container.

1. Start Container for testing:

```bash
make setup_test
```

2. Run Tests

```bash
make test
```

3. Stop up container

```bash
make clean_up
```

## License

MIT