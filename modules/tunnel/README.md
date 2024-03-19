# [Tunnel](https://docs.aws.amazon.com/systems-manager/)

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

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ssm_logs"></a> [ssm\_logs](#module\_ssm\_logs) | ..//bucket/ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.jump_host](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/autoscaling_group) | resource |
| [aws_iam_instance_profile.jump_host_profile](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.jump_host_policy_ssm](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/iam_policy) | resource |
| [aws_iam_role.jump_host_role](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.jump_host_ssm](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_key.ssm_key](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/kms_key) | resource |
| [aws_launch_template.jump_host](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/launch_template) | resource |
| [aws_s3_bucket_policy.ssm_logs](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/s3_bucket_policy) | resource |
| [aws_security_group.jump_host](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/security_group) | resource |
| [aws_ssm_document.session_manager](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/ssm_document) | resource |
| [aws_ami.amazon-linux-2](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/data-sources/ami) | data source |
| [aws_iam_policy_document.jump_host_policy_assume](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.jump_host_policy_ssm](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ssm_logs](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_roles"></a> [allowed\_roles](#input\_allowed\_roles) | AWS users/roles granted jump server permissions. | `list(string)` | n/a | yes |
| <a name="input_aws_account"></a> [aws\_account](#input\_aws\_account) | The AWS account where resources are created. | `number` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Identify the deployment environment. | `string` | n/a | yes |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Whether deletion protection is active on the bucket. | `bool` | n/a | yes |
| <a name="input_key"></a> [key](#input\_key) | The project-service key. | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | The private subnets for the VPC. | `list(string)` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project key. | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | The service key. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Identifier for the VPC. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | Identifier for the tunnel's security group. |
<!-- END_TF_DOCS -->