# [WAF](https://docs.aws.amazon.com/waf/)

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
| [aws_wafv2_ip_set.ipv4](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/wafv2_ip_set) | resource |
| [aws_wafv2_ip_set.ipv6](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/wafv2_ip_set) | resource |
| [aws_wafv2_web_acl.this](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/wafv2_web_acl) | resource |
| [aws_wafv2_web_acl_logging_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/wafv2_web_acl_logging_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_countries"></a> [countries](#input\_countries) | A list of country codes for scoping geo rules. | `list(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Identify the deployment environment. | `string` | n/a | yes |
| <a name="input_ipv4_ip_set_addresses"></a> [ipv4\_ip\_set\_addresses](#input\_ipv4\_ip\_set\_addresses) | Provide addresess for a WAFv2 IP set resource in ipv4 format. | `list(string)` | n/a | yes |
| <a name="input_ipv6_ip_set_addresses"></a> [ipv6\_ip\_set\_addresses](#input\_ipv6\_ip\_set\_addresses) | Provide addresess for a WAFv2 IP set resource in ipv6 format. | `list(string)` | n/a | yes |
| <a name="input_key"></a> [key](#input\_key) | The project-service key. | `string` | n/a | yes |
| <a name="input_log_destination_configs"></a> [log\_destination\_configs](#input\_log\_destination\_configs) | Optional ARN of a resource to receive WAF logs. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the WAF instance. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project key. | `string` | n/a | yes |
| <a name="input_rules"></a> [rules](#input\_rules) | Data for settings parameters in the rule declarations. | <pre>object({<br>    domestic_dos_limit = number,<br>    global_dos_limit   = number,<br>  })</pre> | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | The service key. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->