# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip : 71.78.22.43
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис
  
```json
{
	"info" : "Sample JSON output from our service\t",
	"elements": [
        {
		"name" : "first",
           	"type" : "server",
           	"ip" : "7175"
        },
        {
                "name" : "second",
                "type" : "proxy",
                "ip" : "71.78.22.43"
        }
    ]
}
  
```

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import socket
import json
import yaml

file_json = "log.json"
file_yaml = "log.yaml"

sites = {'drive.google.com' : '', 'mail.google.com' : '', 'google.com' : ''}

dump_result = []

for site,ip in sites.items():
    ip_addr = socket.gethostbyname(site)
    sites.update({site:ip_addr})
    dump_result.append({'Site' : site, 'ip address': ip_addr})
    print(dump_result)

with open(file_json, 'w') as fjson:
    json.dump(dump_result, fjson, indent=4)

with open(file_yaml, 'w') as fyaml:
    yaml.dump(dump_result, fyaml, sort_keys=False, default_flow_style=False)
```

### Вывод скрипта при запуске при тестировании:
```
[{'Site': 'drive.google.com', 'ip address': '64.233.162.194'}]
[{'Site': 'drive.google.com', 'ip address': '64.233.162.194'}, {'Site': 'mail.google.com', 'ip address': '173.194.221.83'}]
[{'Site': 'drive.google.com', 'ip address': '64.233.162.194'}, {'Site': 'mail.google.com', 'ip address': '173.194.221.83'}, {'Site': 'google.com', 'ip address': '173.194.222.113'}]
```

### json-файл(ы), который(е) записал ваш скрипт:
```json
[
    {
        "Site": "drive.google.com",
        "ip address": "64.233.162.194"
    },
    {
        "Site": "mail.google.com",
        "ip address": "173.194.221.83"
    },
    {
        "Site": "google.com",
        "ip address": "173.194.222.113"
    }
]
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
- Site: drive.google.com
  ip address: 64.233.162.194
- Site: mail.google.com
  ip address: 173.194.221.83
- Site: google.com
  ip address: 173.194.222.113
```

