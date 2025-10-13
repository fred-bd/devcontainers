storage "file" {
  path = "/vault/files"
}

listener "tcp" {
  address = "[::]:8200"
  cluster_address = "[::]:8201"
  tls_disable = true
}

default_lease_ttl =  "168h"
max_lease_ttl = "720h"
ui = true
