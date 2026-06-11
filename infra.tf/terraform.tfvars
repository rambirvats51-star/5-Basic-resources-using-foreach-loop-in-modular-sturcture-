rgs={
rg1={
name="rg1"
location="central india"
}
}

stgs={
stg1={
  
     name="ramst51"
    location ="central india"
    resource_group_name = "rg1"
    account_tier = "Standard"
    account_replication_type ="LRS"
}
}


vnets={
vnets1={
    name="vnet"
    location ="central india"
    resource_group_name ="rg1"
    address_space = ["10.0.0.0/8"]
}
}
subnets={
  subnets1={
    name="frontend_subnet"
resource_group_name = "rg1"
address_prefixes = ["10.0.0.0/16"]
virtual_network_name = "vnet"
  
  }
   subnets2={
    name="backend_subnet"
resource_group_name = "rg1"
address_prefixes = ["10.2.0.0/16"]
virtual_network_name = "vnet"
  
  }
}
pips={
    pip1={
    
name="pip"
location = "central india"
resource_group_name = "rg1"
allocation_method ="Static"
}
}

vm={
vm1={
  pip_name = "pip"
  subnet_name = "frontend_subnet"
  nic_name    = "nic"
  location    = "central india"
  resource_group_name = "rg1"

  ip_configuration {

    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = Data.azurerm_public_ip.pip.[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {

  for_each = var.vm

  name                = each.value.vm_name
  resource_group_name = each.value.rg_name
  location            = each.value.location
  size                = "Standard_B1s"

  admin_username = "Rambirvats1984"
  admin_password = "Rambirvats1984"

  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  os_disk {

    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {

    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}






}



}





    



