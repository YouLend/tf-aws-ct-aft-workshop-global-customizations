locals {
  product_ou_id = "ou-og36-hp9po3tl"
}

resource "aws_organizations_policy" "require_tags" {
  name        = "require-mandatory-tags"
  description = "Deny creation of key AWS resources unless Project/Owner/Environment tags are set"
  content     = file("${path.module}/scp-required-tags.json")
  type        = "SERVICE_CONTROL_POLICY"
}

resource "aws_organizations_policy_attachment" "require_tags_to_ou" {
  policy_id = aws_organizations_policy.require_tags.id
  target_id = local.product_ou_id
}