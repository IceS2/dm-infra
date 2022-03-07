module "common" {
  source = "../common"

  env     = local.env

  domain_name   = local.domain_name
  data_products = local.data_products
}
