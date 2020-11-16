output "rg-integration_test_name" {
  # Only output integration test for cleaning up
  # value = var.target == "integration_test" ? module.rg-integration_test[0].name : ""
  value = module.rg-integration_test[0].name 

  depends_on = [
    module.rg-integration_test
  ]
}

output "rg-compute_name" {
  # value = var.target == "integration_test" ? "" : module.rg-compute[0].name
  value = module.rg-compute[0].name

  depends_on = [ 
    module.rg-compute
  ]
}

output "rg-data_name" {
  # value = var.target == "integration_test" ? "" : module.rg-data[0].name
  value = module.rg-data[0].name

  depends_on = [ 
    module.rg-data
  ]
}

output "func-venue-name" {
  value = module.func[0].name
}

// TODO: Don't show slot_name output if not create slot
output "func-venue-slot_name" {
  value = module.func[0].slot_name
}