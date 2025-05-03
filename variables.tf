variable "linux_timestamp_format" {
  type        = string
  description = "The format of the timestamp to generate on Linux"
  default     = "+%d-%m-%Y:%H:%M"
}

variable "random_string_size" {
  type        = number
  description = "The size of the random string to generate"
  default     = 4
}

variable "windows_timestamp_format" {
  type        = string
  description = "The format of the timestamp to generate on Windows"
  default     = "dd-MM-yyyy:HH:mm"
}

variable "working_dir" {
  type        = string
  description = "The working directory for the module"
  default     = null
}
