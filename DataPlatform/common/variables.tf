variable "env" {
  type        = string
  description = "The environment name, e.g. dev, prod, etc."
}

variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "data_products" {
  description = "Domain data products"
  type = map(object({
    data_classification : string
    contains_pii: bool,

    amplitude: bool,
    emr: optional(object({
      master_instance_type: string,
      core_instance_type: string,
      core_instance_count: number,
      release_label: string,
      applications: set(string)
    }))
  }))
}
