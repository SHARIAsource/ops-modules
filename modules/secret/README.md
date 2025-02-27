# [Secret](https://docs.aws.amazon.com/secretsmanager/)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.32.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.32.1 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.this](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/secretsmanager_secret_version) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | A description of the secret. | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Identify the deployment environment. | `string` | n/a | yes |
| <a name="input_keepers"></a> [keepers](#input\_keepers) | Define values that on change will force regeneration of the random value. | `map(any)` | n/a | yes |
| <a name="input_key"></a> [key](#input\_key) | The project-service key. | `string` | n/a | yes |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | ARN of thw KMS key to be used to encrypt the secret. | `string` | n/a | yes |
| <a name="input_length"></a> [length](#input\_length) | The length of the generated random password | `number` | `64` | no |
| <a name="input_min_special"></a> [min\_special](#input\_min\_special) | Minimum number of special characters. | `number` | `5` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the new secret. | `string` | n/a | yes |
| <a name="input_override_special"></a> [override\_special](#input\_override\_special) | Supply special characters to use for use in random strings. | `string` | `"!@#$%&*()-_=+[]{}<>:?"` | no |
| <a name="input_project"></a> [project](#input\_project) | The project key. | `string` | n/a | yes |
| <a name="input_recovery_window"></a> [recovery\_window](#input\_recovery\_window) | Number of days that must elapse before a secret can be deleted. | `number` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region for replicating the secret. | `string` | `null` | no |
| <a name="input_service"></a> [service](#input\_service) | The service key. | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | The username for a username/password blob. | `string` | `null` | no |
| <a name="input_username_password_pair"></a> [username\_password\_pair](#input\_username\_password\_pair) | If true, the password will be in username/password blob format. | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN for the secret. |
| <a name="output_name"></a> [name](#output\_name) | Name of the secret. |
| <a name="output_version_arn"></a> [version\_arn](#output\_version\_arn) | ARN for the secret version. |
<!-- END_TF_DOCS -->