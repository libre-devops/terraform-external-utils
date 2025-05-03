# Linux branch
data "external" "generate_linux_timestamp" {
  count       = local.is_linux ? 1 : 0
  working_dir = var.working_dir == null ? path.module : var.working_dir

  program = [
    "bash",
    "-c",
    "DATE=$(date '${var.linux_timestamp_format}'); printf '{\"id\":\"%s\",\"timestamp\":\"%s\"}' \"$DATE\" \"$DATE\""
  ]
}

# Windows branch
data "external" "generate_windows_timestamp" {
  count       = local.is_windows ? 1 : 0
  working_dir = var.working_dir == null ? path.module : var.working_dir

  program = [
    "powershell",
    "-Command",
    "$date = Get-Date -Format '${var.windows_timestamp_format}'; $json = @{ id = $date; timestamp = $date } | ConvertTo-Json -Compress; Write-Output $json"
  ]
}


###############################################################################
# Normalise the result
###############################################################################

locals {
  timestamp = local.is_linux ? lower(data.external.generate_linux_timestamp[0].result.timestamp) : lower(data.external.generate_windows_timestamp[0].result.timestamp)
}
