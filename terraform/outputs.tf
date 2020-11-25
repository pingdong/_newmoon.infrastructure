output "rg-integration_test_name" {
  # Only output integration test for cleaning up
  value = var.target == "integration_test" ? module.rg-integration_test[0].name : ""
}

output "rg-compute_name" {
  value = var.target == "general" ? module.rg-compute[0].name : ""
}

output "rg-data_name" {
  value = var.target == "general" ? module.rg-data[0].name : ""
}

output "func-venue-name" {
  value = var.target == "general" || contains(var.integration_testing-features, "venue")  ? module.func[0].name : ""
}

output "func-venue-slot_name" {
  value = var.target == "general" && var.environment == "prod" ? module.func[0].slot_name : ""
}

output "func-venue-baseUrl" {
  value = var.target == "general" || contains(var.integration_testing-features, "venue") ? replace("https://<func_name>.azurewebsites.net/", "<func_name>", module.func[0].name) : ""
}

// TODO: Output masterKey of the Function