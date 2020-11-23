// TODO: Don't show output if not create

output "rg-integration_test_name" {
  # Only output integration test for cleaning up
  value = substr(var.target, 0, 16) == "integration_test" ? module.rg-integration_test[0].name : ""
}

output "rg-compute_name" {
  value = substr(var.target, 0, 16) == "integration_test" ? "" : module.rg-compute[0].name
}

output "rg-data_name" {
  value = substr(var.target, 0, 16) == "integration_test" ? "" : module.rg-data[0].name
}

output "func-venue-name" {
  value = module.func[0].name
}

output "func-venue-slot_name" {
  value = module.func[0].slot_name
}