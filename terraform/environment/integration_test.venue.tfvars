
# Used for integration testing

service                       = "newmoon"
environment                   = "it"
tags                          = {}
location                      = "East US 2"

target                        = "integration_test"
integration_testing-suffix    = "30db"
integration_testing-features  = ["venue"]
                    
local_development             = true