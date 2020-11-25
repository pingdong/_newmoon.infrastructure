# Used for integration testing of skipping function apps
# Scenario: If a service contains multiple FuncApps, 
#           you may want to integration test each FuncApp separately

service                     = "newmoon"
environment                 = "it"
tags                        = {}
location                    = "East US 2"

target                      = "integration_test"
integration_testing-suffix  = "30db"
                    
local_development           = true