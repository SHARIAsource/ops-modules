# [Load Balancer](https://docs.aws.amazon.com/elasticloadbalancing/)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.32.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.32.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.alb](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.alb](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/acm_certificate_validation) | resource |
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/lb_target_group) | resource |
| [aws_route53_record.alb](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/route53_record) | resource |
| [aws_security_group.alb](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/security_group) | resource |
| [aws_route53_zone.main](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_port"></a> [alb\_port](#input\_alb\_port) | Load balancer listening port. | `number` | n/a | yes |
| <a name="input_dns_ttl"></a> [dns\_ttl](#input\_dns\_ttl) | Time to live for the certificate's DNS record. | `number` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | The origin of the service. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Identify the deployment environment. | `string` | n/a | yes |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | Parameters configuring the ALB's healthcheck. | <pre>object({<br>    interval            = number, # Frequency (secs) of the health checks.<br>    matcher             = number, # HTTP status code indicating a passing health check.<br>    path                = string, # URL route of the healthcheck.<br>    threshold           = number, # Count before considering an unhealthy target healthy.<br>    timeout             = number, # Time (secs) without a response indicting a failed health check.<br>    unhealthy_threshold = number, # Consecutive failed health checks before considering a target unhealthy.<br>  })</pre> | n/a | yes |
| <a name="input_key"></a> [key](#input\_key) | The project-service key. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project key. | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | The service key. | `string` | n/a | yes |
| <a name="input_ssl_port"></a> [ssl\_port](#input\_ssl\_port) | Secure HTTPS listening port. | `number` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Public subnets of the VPC. | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Identifier for the VPC. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | Identify the security group controlling access to the ALB. |
<!-- END_TF_DOCS -->