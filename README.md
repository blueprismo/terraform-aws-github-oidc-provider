# AWS github OIDC Provider

## Intro

This module is to create an AWS OIDC provider for github actions. Intended to be used by the github actions executors, to pass them a role.
This module also includes the Audience (`*:aud`) claim. You can see the github.com supported claims at https://token.actions.githubusercontent.com/.well-known/openid-configuration.

If you are using the official action to configure credentials: [aws-actions/configure-aws-credentials](https://github.com/aws-actions/configure-aws-credentials):

1. `role-to-assume` should be used as input for that action, with the role ARN created in this repository.
2. `sts.amazonaws.com` should be the url of the repository.

## TODOs

Configure scope level access for the subject. The syntax is `repo:OWNER/REPOSITORY:environment:NAME` (to be done)

## Additional information

Github Actions and OIDC provider by AWS: https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services
OIDC: https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.61.0 |


## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_audiences"></a> [audiences](#input\_audiences) | (Optional) List of audiences that will be in the JWT the OIDC provider generates | `list(string)` | <pre>[<br>  "sts.amazonaws.com"<br>]</pre> | no |
| <a name="input_create_oidc_provider"></a> [create\_oidc\_provider](#input\_create\_oidc\_provider) | Whether or not to create the associated oidc provider. If false, variable 'oidc\_provider\_arn' is required | `bool` | `true` | no |
| <a name="input_create_oidc_role"></a> [create\_oidc\_role](#input\_create\_oidc\_role) | Whether or not to create the OIDC attached role | `bool` | `true` | no |
| <a name="input_github_thumbprint"></a> [github\_thumbprint](#input\_github\_thumbprint) | GitHub OpenID TLS certificate thumbprint. | `list(string)` | <pre>[<br>  "6938fd4d98bab03faadb97b34396831e3780aea1"<br>]</pre> | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum session duration in seconds. | `number` | `3600` | no |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | ARN of the OIDC provider to use. Required if 'create\_oidc\_provider' is false | `string` | `null` | no |
| <a name="input_oidc_role_attach_policies"></a> [oidc\_role\_attach\_policies](#input\_oidc\_role\_attach\_policies) | Attach policies to OIDC role. | `list(string)` | `[]` | no |
| <a name="input_repositories"></a> [repositories](#input\_repositories) | List of GitHub organization/repository names authorized to assume the role. | `list(string)` | `[]` | no |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | (Optional) Description of the role. | `string` | `"Role assumed by the GitHub OIDC provider."` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | (Optional, Forces new resource) Friendly name of the role. | `string` | `"github-oidc-provider-aws"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | OIDC provider ARN |
| <a name="output_oidc_role"></a> [oidc\_role](#output\_oidc\_role) | CICD GitHub role. |
