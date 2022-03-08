# Default enabled resources for all domains
resource "aws_s3_bucket" "data_product_bucket" {
  for_each = var.data_products
  bucket = "${var.domain_name}-${each.key}"
}

resource "aws_iam_role" "developer_role" {
  name = "${var.domain_name}DeveloperRole"
}

# EMR resource for each Data Product that requests it
resource "aws_emr_cluster" "domain_emr_cluster" {
  for_each = { for k, v in var.data_products : k => v if contains(keys(v), "emr") }

  name = "${var.domain_name}-${each.key}-EMRCluster"
  release_label = each.value.emr.release_label
  applications = each.value.emr.applications

  master_instance_group {
    instance_type = each.value.emr.master_instance_type
  }

  core_instance_group {
    instance_type = each.value.emr.core_instance_type
    instance_count = each.value.emr.core_instance_count
  }
}

# Amplitude resource for each Data Product that requests it
resource "aws_secretsmanager_secret" "amplitude_id_secret" {
  for_each = { for k, v in var.data_products : k => v if v.value.amplitude }
  name     = "${var.env}/${var.domain_name}/amplitude/${each.key}"
}
