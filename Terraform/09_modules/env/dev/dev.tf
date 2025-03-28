module "dev" {
    source          = "../../aks"
    rg_name         = "DevRG"
    rg_location     = "EastUS"
    acr_name        = "nextopsdevacr23"
    acr_sku         = "Standard"
    admin_enabled   = true 
    aks_name        = "nextopsdevaks23"
    pod_cidr        = "10.2.0.0/16"
    service_cidr    = "10.3.0.0/16"
    dns_service_ip  = "10.3.0.10"
    env             = "dev"  
}