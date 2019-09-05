output "ip" {
  value = "${aws_spot_instance_request.k8s_main.public_ip}"
}