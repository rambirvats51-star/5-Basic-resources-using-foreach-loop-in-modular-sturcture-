module "rg" {
    source = "../resorces/rg"
    rg=var.rgs
}

module "stg" {
    depends_on = [ module.rg ]
source = "../resorces/stg"
stg=var.stgs
  
}
module "vnet" {
    depends_on = [ module.rg ]
    source = "../resorces/vnet"
    vnet = var.vnets
  
}
module "subnet" {
    depends_on = [ module.vnet ]
    source = "../resorces/subnet"
    subnet=var.subnets  
}
module "pip" {
    depends_on = [ module.rg ]
  source = "../resorces/pip"
  pip=var.pips
}
module"vm"{
source = "../resorces/vm"
vms =var.vm
}