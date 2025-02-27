# OIDC

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.32.1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.32.1 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.github](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/iam_role) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/data-sources/iam_policy_document) | data source |
| [tls_certificate.github](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Identify the deployment environment. | `string` | n/a | yes |
| <a name="input_gha_oidc_role_name"></a> [gha\_oidc\_role\_name](#input\_gha\_oidc\_role\_name) | Name of the github action OIDC role. | `string` | n/a | yes |
| <a name="input_key"></a> [key](#input\_key) | The project-service key. | `string` | n/a | yes |
| <a name="input_oidc_allowed"></a> [oidc\_allowed](#input\_oidc\_allowed) | Github org/repos/branches allowed to assume to OIDC role. | `list(map(string))` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project key. | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | The service key. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gha_oidc_provider_arn"></a> [gha\_oidc\_provider\_arn](#output\_gha\_oidc\_provider\_arn) | The ARN of the github OIDC provider resource. |
| <a name="output_gha_oidc_role_name"></a> [gha\_oidc\_role\_name](#output\_gha\_oidc\_role\_name) | The name of the Github Actions OIDC role. |
<!-- END_TF_DOCS -->