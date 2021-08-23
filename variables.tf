variable "rgName"{ 
    type = string 
    #default = "src-terraform-rg"
    }
variable "location" { 
    type = string 
    default = "eastus"
    }
variable "subscription_id" {
     type = string 
     }
variable "client_id" { 
    type = string 
    }
variable "client_secret" { 
    type = string 
    }
variable "tenant_id" { 
    type = string 
    }
