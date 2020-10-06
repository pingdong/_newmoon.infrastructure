
service             = "newmoon"
environment         = "it"
tags                = {}
location            = "East US"

target              = "integration_test"
integration_testing = {
                        features  = ["venue1"]
                        suffix    = "298F"
                    }
                    
local_development   = true