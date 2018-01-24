.PHONY: setup_test setup_local_test clean_up cli test cycle

CONTAINER_NAME?=ansible-local-runner
TEST_CONTAINER_TAG?=16.04-py3-ansible-2.4.2.0-lint-3.4.20-testinfra-1.10.1

setup_test:
	docker run --rm --privileged -d --name $(CONTAINER_NAME) \
	-v $(PWD):/etc/ansible/roles/role_to_test \
	-v /sys/fs/cgroup:/sys/fs/cgroup:ro  \
	-h $(CONTAINER_NAME) \
	thomasjpfan/ansible-ubuntu-local-runner:$(TEST_CONTAINER_TAG)

setup_local_test:
	docker run --rm --privileged -d --name $(CONTAINER_NAME) \
	-v $(PWD):/etc/ansible/roles/role_to_test \
	-v /sys/fs/cgroup:/sys/fs/cgroup:ro  \
	-v $(PWD)/dep_roles:/root/.ansible/roles -t \
	-e ANSIBLE_PLAYBOOK_ARGS="-e docker_use_local_cache=true" \
	--network ng \
	-h $(CONTAINER_NAME) \
	thomasjpfan/ansible-ubuntu-local-runner:$(TEST_CONTAINER_TAG)

cli:
	docker exec -ti $(CONTAINER_NAME) /bin/bash

test:
	docker exec -ti $(CONTAINER_NAME) cli all

cycle: setup_local_test test clean_up

clean_up:
	docker stop $(CONTAINER_NAME)