###############################################################################
# Generate a random string – one data source per platform
###############################################################################

# Linux branch
data "external" "generate_random_string" {
  count       = local.is_linux ? 1 : 0
  working_dir = var.working_dir == null ? path.module : var.working_dir
  program = [
    "bash", "-c",
    "printf '{\"random_string\":\"%s\"}' \"$(head -c 256 /dev/urandom | tr -dc 'A-Za-z0-9' | head -c ${var.random_string_size})\""
  ]
}


# Windows branch
data "external" "generate_random_string_windows" {
  count       = local.is_windows ? 1 : 0
  working_dir = var.working_dir == null ? path.module : var.working_dir
  program     = ["powershell", "-Command", "$randomString = -join ((65..90) + (97..122) | Get-Random -Count ${var.random_string_size} | % {[char]$_}); $json = @{random_string=$randomString} | ConvertTo-Json -Compress; Write-Output $json"]
}

###############################################################################
# Normalise the result
###############################################################################

locals {
  random_string = local.is_linux ? lower(data.external.generate_random_string[0].result.random_string) : lower(data.external.generate_random_string_windows[0].result.random_string)
}
