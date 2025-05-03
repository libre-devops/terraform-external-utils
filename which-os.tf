###############################################################################
# Detect the OS
###############################################################################

# Full path to the helper that exists only on Windows
locals {
  windows_helper = "${abspath(path.module)}\\printf.cmd"
}

# If the helper file exists, we’re on Windows; otherwise assume Linux
data "external" "detect_os" {
  program = fileexists(local.windows_helper) ? [local.windows_helper, "{\"os\":\"Windows\"}"] : ["printf", "{\"os\":\"Linux\"}"]
}

locals {
  os         = data.external.detect_os.result.os
  is_windows = lower(local.os) == "windows"
  is_linux   = lower(local.os) == "linux"
}

