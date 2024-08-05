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
