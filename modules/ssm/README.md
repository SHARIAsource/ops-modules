# [SSM](https://aws.amazon.com/systems-manager)
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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ssm_logs"></a> [ssm\_logs](#module\_ssm\_logs) | github.com/SHARIAsource/ops-modules//modules/bucket | c2106d0b49b07bde7b3dcb7f32cf5a53331c37ef |

## Resources

| Name | Type |
|------|------|
| [aws_kms_key.ssm_key](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/kms_key) | resource |
| [aws_ssm_document.session_manager](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/ssm_document) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account"></a> [aws\_account](#input\_aws\_account) | The AWS account where resources are created. | `number` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Identify the deployment environment. | `string` | n/a | yes |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Whether deletion protection is active on the bucket. | `bool` | n/a | yes |
| <a name="input_key"></a> [key](#input\_key) | The project-service key. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project key. | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | The service key. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | ARN of the SSM KMS key |
| <a name="output_logs_bucket_arn"></a> [logs\_bucket\_arn](#output\_logs\_bucket\_arn) | ARN of the SSM logs bucket. |
| <a name="output_logs_bucket_name"></a> [logs\_bucket\_name](#output\_logs\_bucket\_name) | The name/id of the SSM logs bucket. |
<!-- END_TF_DOCS -->