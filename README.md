mist.io monitoring playbooks
============================
This repo contains all the ansible playbooks and scripts used by [mist.io](https://mist.io/) to enable server monitoring.

Currently supported distros are recent versions of:
- Debian based distros: Tested with debian and ubuntu
- RedHat based distros: Tested with Fedora, RHEL, CentOS, Amazon
- Suse based distros: Tested with Suse, openSuse
- FreeBSD

ansible/enable.yml
------------------
Installs collectd on the target machines for mist.io monitoring.

Params:
- `uuid`: machine unique identifier assigned by mist.io. Required.
- `password`: machine password to encrypt collectd traffic, assigned by mist.io. Required.
- `monitor`: monitor server host/ip where collectd will send data to. Optional, defaults to `monitor1.mist.io`.
- `hosts`: Run the playbook on machines found in the inventory file, matching `hosts`. Optional, defaults to `all`.

ansible/disable.yml
-------------------
Disables mist.io monitoring on tharget machines by stopping collectd and removing any relevant cronjobs.

Params:
- hosts: Run the playbook on machines found in the inventory file, matching `hosts`. Optional, defaults to `all`.

local_run.py
------------
Enables mist.io monitoring on localhost. It will create a temporary directory and set up a virtualenv with all required dependencies in order to enable monitoring.

```
usage: local_run.py [-h] [-m MONITOR_SERVER] [--no-check-certificate]
                    uuid password

Deploy mist.io CollectD on localhost.

positional arguments:
  uuid                  Machine uuid assigned by mist.io.
  password              Machine password assigned by mist.io, used to
                        sign/encrypt CollectD data.

optional arguments:
  -h, --help            show this help message and exit
  -m MONITOR_SERVER, --monitor-server MONITOR_SERVER
                        Remote CollectD server to send data to.
                        (default: monitor1.mist.io)
  --no-check-certificate
                        Don't verify SSL certificates when fetching
                        dependencies from HTTPS. (default: False)
```
