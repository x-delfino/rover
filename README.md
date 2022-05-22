# Rover - Vagrant templating

Vagrantfile built with external json to simplify slightly differing repeatable builds.

## Features
- Multiple guests
- Ansible playbooks
- Ansible galaxy


Provided templates use the following base boxes from [tiffin](https://github.com/x-delfino/tiffin):

| Basebox | Arch | Vagrant Cloud |
|----|------|---------------|
| [Kali 2022.1](https://github.com/x-delfino/tiffin/tree/main/templates/linux/kali) | ARM64 | [delfino/kali-2022.1-arm64](https://app.vagrantup.com/delfino/boxes/kali-2022.1-arm64) |
| [Debian 11.3](https://github.com/x-delfino/tiffin/tree/main/templates/linux/debian) | ARM64 | [delfino/debian-11.3-arm64](https://app.vagrantup.com/delfino/boxes/debian-11.3-arm64) |

Provided templates install roles from the following collections from [ansible-collections](https://github.com/x-delfino/ansible-collections):
| Collection | Galaxy |
|------------|--------|
| [utils](https://github.com/x-delfino/ansible-collections/tree/main/utils) | [x_delfino.utils](https://galaxy.ansible.com/x_delfino/utils) |
| [security](https://github.com/x-delfino/ansible-collections/tree/main/security) | [x_delfino.security](https://galaxy.ansible.com/x_delfino/security) |
| [cloud](https://github.com/x-delfino/ansible-collections/tree/main/cloud) | [x_delfino.cloud](https://galaxy.ansible.com/x_delfino/cloud) |

## Requirements
- [Parallels Desktop Pro/Business](https://www.parallels.com/uk/products/desktop/) (only provider for now...):
  - [vagrant-parallels](https://kb.parallels.com/en/122843)
- [Vagrant](https://www.vagrantup.com/docs/installation)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (Optional)

## Usage
- Set variables in `vars.json`
- Run `vagrant up`
- develop/learn/test/hack away!

## JSON Schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "Vagrant variables",
  "description": "variables for Vagrantfile to automate builds",
  "type": "object",
  "properties": {
    "hosts": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "box": {
            "type": "string"
          },
          "ssh_agent": {
            "type": "boolean"
          },
          "hostname": {
            "type": "string"
          },
          "name": {
            "type": "string"
          },
          "cpus": {
            "type": "integer"
          },
          "memory": {
            "type": "integer"
          },
          "playbooks": {
            "type": "array",
            "items": {
              "type": "object",
              "properties": {
                "path": {
                  "type": "string"
                },
                "galaxy_file": {
                  "type": "string"
                },
                "groups": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                },
                "vars": {
                  "type": "object",
                  "properties": {
                    "key": {
                      "type": "string"
                    },
                    "value": {
                      "type": [
                        "integer",
                        "string",
                        "boolean",
                        "array",
                        "object",
                        "number"
                      ]
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
```

