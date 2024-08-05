resource "aws_iam_openid_connect_provider" "this" {
  count = var.create_oidc_provider ? 1 : 0
  client_id_list = var.audiences
  thumbprint_list = var.github_thumbprint
  url             = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_role" "this" {
  count                = var.create_oidc_role ? 1 : 0
  name                 = var.role_name
  description          = var.role_description
  max_session_duration = var.max_session_duration
  assume_role_policy   = join("", data.aws_iam_policy_document.this[0].*.json)
  tags                 = var.tags
  depends_on = [aws_iam_openid_connect_provider.this]
}

resource "aws_iam_role_policy_attachment" "attach" {
  count = var.create_oidc_role ? length(var.oidc_role_attach_policies) : 0

  policy_arn = var.oidc_role_attach_policies[count.index]
  role       = join("", aws_iam_role.this.*.name)

  depends_on = [aws_iam_role.this]
}

data "aws_iam_policy_document" "this" {
  count = var.create_oidc_role ? 1 : 0

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test   = "StringLike"
      values = [
        for repo in var.repositories :
        "repo:%{if length(regexall(":+", repo)) > 0}${repo}%{else}${repo}:*%{endif}"
      ]
      variable = "token.actions.githubusercontent.com:sub"
    }

    condition {
      test = "StringEquals"
      values = [
        for audience in var.audiences :
        "${audience}"
      ]
      variable = "token.actions.githubusercontent.com:aud"
    }
    
    principals {
      identifiers = [try(aws_iam_openid_connect_provider.this[0].arn, var.oidc_provider_arn)]
      type        = "Federated"
    }
  }
}
