Content-Type: multipart/mixed; boundary="==BOUNDARY=="
MIME-Version: 1.0

--==BOUNDARY==
MIME-Version: 1.0
Content-Type: text/x-shellscript; charset="us-ascii"
#!/bin/bash

# cluster to join
echo ECS_CLUSTER=${cluster_name} >> /etc/ecs/ecs.config
