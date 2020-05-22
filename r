wget https://get.helm.sh/helm-v3.2.1-linux-amd64.tar.gz
tar xvfz helm-v3.2.1-linux-amd64.tar.gz
sudo cp linux-amd64/helm /usr/local/bin/
#curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
#chmod +x ./kubectl
#sudo mv kubectl /usr/local/bin/
sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
GO111MODULE="on" go get sigs.k8s.io/kind@v0.8.1
kind create cluster
helm repo add charts.gitpod.io https://charts.gitpod.io
helm dep update
mkdir -p ~/.kube
helm upgrade --install $(for i in $(cat configuration.txt); do echo -e "-f $i"; done) gitpod .
