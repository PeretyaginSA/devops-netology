



```ansible
root@bhdevops:/home/peretyaginsa/mnt-homeworks/08-ansible-02-playbook/playbook# ansible-playbook -i inventory/prod.yml site.yml 

PLAY [Install Clickhouse] ******************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] **************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 0, "group": "root", "item": "clickhouse-common-static", "mode": "0644", "msg": "Request failed", "owner": "root", "response": "HTTP Error 404: Not Found", "size": 246310036, "state": "file", "status_code": 404, "uid": 0, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] **************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] *********************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create database] *********************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install vector] **********************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Get vector distrib] ******************************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Create directrory vector] ************************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Extract vector from archive] *********************************************************************************************************************************************************************************************************************
ok: [vector-01]

PLAY RECAP *********************************************************************************************************************************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
vector-01                  : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

root@bhdevops:/home/peretyaginsa/mnt-homeworks/08-ansible-02-playbook/playbook# 
root@bhdevops:/home/peretyaginsa/mnt-homeworks/08-ansible-02-playbook/playbook# 
root@bhdevops:/home/peretyaginsa/mnt-homeworks/08-ansible-02-playbook/playbook# ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Clickhouse] ******************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] **************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 0, "group": "root", "item": "clickhouse-common-static", "mode": "0644", "msg": "Request failed", "owner": "root", "response": "HTTP Error 404: Not Found", "size": 246310036, "state": "file", "status_code": 404, "uid": 0, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] **************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] *********************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create database] *********************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install vector] **********************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Get vector distrib] ******************************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Create directrory vector] ************************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Extract vector from archive] *********************************************************************************************************************************************************************************************************************
ok: [vector-01]

PLAY RECAP *********************************************************************************************************************************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
vector-01                  : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```