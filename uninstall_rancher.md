# Desinstalar K3s
sudo /usr/local/bin/k3s-uninstall.sh

# Desinstalar RKE2
sudo /usr/local/bin/rke2-uninstall.sh

# Parar e remover todos os contêineres Docker
sudo docker ps -aq | xargs sudo docker stop
sudo docker ps -aq | xargs sudo docker rm

# Remover todas as imagens Docker
sudo docker images -aq | xargs sudo docker rmi -f

# Remover volumes Docker (opcional)
sudo docker volume ls -q | xargs sudo docker volume rm

# Remover diretórios de configuração
sudo rm -rf /etc/rancher/k3s /var/lib/rancher/k3s /etc/rancher/rke2 /var/lib/rancher/rke2 /var/lib/docker

# Remover arquivos de serviço do systemd
sudo rm -f /etc/systemd/system/k3s.service /etc/systemd/system/k3s-agent.service /etc/systemd/system/rke2-server.service /etc/systemd/system/rke2-agent.service

# Recarregar o daemon do systemd
sudo systemctl daemon-reload

# Verificar processos relacionados ao Kubernetes
ps aux | grep -E 'k3s|rke2|kube|etcd'

# Verificar se a porta 6443 está liberada
sudo lsof -i :6443

# Reiniciar o sistema (opcional)
sudo reboot
