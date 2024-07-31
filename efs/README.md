


loggin into ec2 via session manager and then fiest  crreate a directory and then mount it 


sudo yum install -y amazon-efs-utils
sudo mkdir /mnt/efs




sudo mount -t efs -o tls fs-02dfdb412df3b410c:/ /mnt/efs