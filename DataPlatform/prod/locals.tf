locals {
  env     = "prod"
  domain_name = "DataPlatform"

  data_products = {
    "DataPlatformProduct1": {
        "data_classification": "L1",
        "contains_pii": false,
        "amplitude": true,
        "emr": {
            "master_instance_type": "m5.xlarge",
            "core_instance_type": "m5.xlarge",
            "core_instance_count": 5,
            "release_label": "emr-4.6.0",
            "applications": [
                "Spark"
            ]
        }
    }
}
}
