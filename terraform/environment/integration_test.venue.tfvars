
# Used for integration testing

service             = "newmoon"
environment         = "it"
tags                = {}
location            = "East US"

target              = "integration_test"
integration_testing = {
                        features  = ["venue"]
                        suffix    = "298F"
                      }
                    
local_development   = true