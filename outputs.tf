output "ip" {
  value = "${aws_spot_instance_request.k8s-main.public_ip}"
}