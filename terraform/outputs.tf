output "name" {
  # Only output integration test for cleaning up
  value = var.target == "integration_test" ? module.rg-integration_test[0].name : ""
}