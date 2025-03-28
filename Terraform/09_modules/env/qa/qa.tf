module "qa" {
    source          = "../../aks"
    rg_name         = "QARG"
    rg_location     = "EastUS"
    acr_name        = "nextopsqaacr23"
    acr_sku         = "Basic"
    admin_enabled   = false 
    aks_name        = "nextopsqaaks23"
    pod_cidr        = "10.6.0.0/16"
    service_cidr    = "10.7.0.0/16"
    dns_service_ip  = "10.7.0.10"
    env             = "qa"  
}