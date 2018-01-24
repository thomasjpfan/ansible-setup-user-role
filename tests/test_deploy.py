import os


def test_users_exists(host):
    u = host.user("deploy")
    assert u.exists
    assert "docker" in u.groups


def test_local_ssh_dir_exists(host):
    assert os.path.exists("tests/ssh_keys/private/localhost.pem")
    assert os.path.exists("tests/ssh_keys/public/localhost.pub")


def test_authorized_keys(host):
    file = host.file("/home/deploy/.ssh/authorized_keys")
    assert file.exists
    assert file.is_file
    content = file.content_string

    ssh_key_dir = "tests/ssh_keys"
    assert os.path.exists(ssh_key_dir)

    pub_key = os.path.join(ssh_key_dir, "public", "localhost.pub")

    with open(pub_key, "r") as f:
        pub_content = f.read()

    assert pub_content in content
