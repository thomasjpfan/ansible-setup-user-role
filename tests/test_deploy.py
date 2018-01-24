def test_users_exists(host):
    u = host.user("deploy")
    assert u.exists
    assert "docker" in u.groups


def test_authorized_keys(host):
    file = host.file("/home/deploy/.ssh/authorized_keys")
    assert file.exists
    assert file.is_file
    content = file.content_string

    pub_key = "tests/id_deploy.pub"

    with open(pub_key, "r") as f:
        pub_content = f.read()

    assert pub_content in content
