#default vars file act as "dev.tfvars"
#add to .gitignore if vars are private

#       define vars value for prod
instance_type = "t2.micro"
cidr_blocks = [
    {cidr_block = "10.10.0.0/16", name = "vpc-cidr-block"},
    {cidr_block = "10.10.1.0/24", name = "prv-_subnet-cidr-block"},
    {cidr_block = "10.10.2.0/24", name = "pub-_subnet-cidr-block"}
]
env_prefix = "dev"
a_z = "eu-west-3a"
public_key_location = "ec2-key-pair.pub"
region = "eu-west-3"

#my_ip = "my-ip/32" -> add your ip if want exclusive access for your pc