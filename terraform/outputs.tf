output "name" {
  value = var.target == "integration_test" ? module.rg-integration_test[0].name : ""
}