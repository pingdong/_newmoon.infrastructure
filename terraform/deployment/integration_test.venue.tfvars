service             = "newmoon"
environment         = "it"
tags                = {}
location            = "East US 2"

target              = "integration_test"
integration_testing = {
                        features  = ["venue"],
                        suffix    = "298F"
                      }