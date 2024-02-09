# 네오위즈파트너스 & 에이치랩코리아 기술과제


_※ **2번 기술과제 질문**_

- terraform: 1.6.3
- aws provider: 5.0

## VPC 구성

- VPC
- internet gateway
- public subnet
- private subnet
- Public route table
- Nat Gateway
- eip
- Route table association

## EC2 구성

- EC2 1대
- network_interface

## ALB 구성

- ALB 
- target_group
- target_group_attachment
- listener


## USER DATA

------- 
#!/bin/bash

sudo yum update -y

sudo yum install nginx

sudo amazon-linux-extras install -y nginx1

sudo systemctl start nginx.service

-------