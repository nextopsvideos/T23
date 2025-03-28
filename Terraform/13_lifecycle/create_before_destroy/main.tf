resource "azurerm_resource_group" "myrg1" {
    name        = "NextOps10"
    location    = "EastUS"

    lifecycle {
      create_before_destroy = true
    }
}

