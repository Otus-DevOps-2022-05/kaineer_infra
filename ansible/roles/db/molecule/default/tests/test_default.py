# check if mongodb is enabled and running
def test_mongo_running_and_enabled(host):
    mongo = host.service("mongodb")
    assert mongo.is_running, "Mongodb service should be running"
    assert mongo.is_enabled, "Mongodb service should be enabled"

# check if configuration file contains required line
def test_config_file(host):
    config_file = host.file("/etc/mongodb.conf")

    assert config_file.is_file, "Config file should exist"
    assert config_file.contains("bindIp: 0.0.0.0"), "Config file should contain bindIp line"

def test_mongo_port(host):
    localhost = host.addr("localhost")
    port = localhost.port(27017)

    assert port.is_reachable, "Port 27017 should be reachable"
