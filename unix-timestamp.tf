###############################################################################
# Unix Epoch (seconds since 1970‑01‑01 00:00:00 UTC)
###############################################################################

######################  Linux branch  ######################
data "external" "unix_epoch_linux" {
  count       = local.is_linux ? 1 : 0
  working_dir = var.working_dir == null ? path.module : var.working_dir

  program = [
    "bash",
    "-c",
    # prints: {"epoch":"1746336000"}
    "printf '{\"epoch\":\"%s\"}' \"$(date +%s)\""
  ]
}

######################  Windows branch  ######################
data "external" "unix_epoch_windows" {
  count       = local.is_windows ? 1 : 0
  working_dir = var.working_dir == null ? path.module : var.working_dir

  program = [
    "powershell",
    "-Command",
    # PowerShell/Windows compatible: %s gives epoch seconds
    "$epoch = Get-Date -UFormat %s; Write-Output ('{\"epoch\":\"'+$epoch+'\"}')"
  ]
}



###############################################################################
# Normalise the result
###############################################################################
locals {
  unix_timestamp = local.is_linux ? data.external.unix_epoch_linux[0].result.epoch : data.external.unix_epoch_windows[0].result.epoch
}
