#!/usr/bin/python3

import subprocess
import json
import sys

def yandex_cloud_json():
    CMD="yc compute instance list --format json"
    
    yc = subprocess.Popen(
        CMD.split(),
        stdout = subprocess.PIPE,
        stderr = subprocess.DEVNULL
    )
    
    stdout, stderr = yc.communicate()

    return json.loads(stdout)

def inner_ip_from_host(host):
    return host["network_interfaces"][0]["primary_v4_address"]["address"]

def external_ip_from_host(host):
    return host["network_interfaces"][0]["primary_v4_address"]["one_to_one_nat"]["address"]



class YandexCloudInventory:
    def __init__(self, data):
        self.data = data

    def build_inventory(self, hosts, db_inner_ip):
        children = ["app", "db"]
        all = {
            "children": children
        }
        root = {
            "all": all,
            "db": {"hosts": ["dbserver"]},
            "app": {"hosts": ["appserver"], "vars": {"db_host": db_inner_ip}},
            "_meta": {"hostvars": hosts}
        }
        return root

    def collect_data(self):
        gg = {}

        for host in self.data:
            name = host["name"]
            inner_ip = inner_ip_from_host(host)
            external_ip = external_ip_from_host(host)
            h = {"ansible_host": external_ip }

            if "app" in name:
                gg["appserver"] = h
            if "db" in name:
                gg["dbserver"] = h
                db_inner_ip = inner_ip

        return self.build_inventory(gg, db_inner_ip)

    def __str__(self):
        return json.dumps(self.collect_data())

cmd = sys.argv[1]

if cmd == "--list":
    print(YandexCloudInventory(yandex_cloud_json()))
