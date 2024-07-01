#---------------------------------------------------------
# General Configuration
#----------------------------------------------------------

variable "resource_group_name" {}

variable "app_service_name" {
  type = string
  default = "aasp2"
}

variable "service_plan_id" {
  description = "ID of the Service Plan that hosts the App Service"
  type        = string
  default     = "/subscriptions/4a9ac668-c3d5-4a20-859a-c680184367b8/resourceGroups/test-rg/providers/Microsoft.Web/serverFarms/testasp"
}

variable "location" {
  description = "Azure location."
  type        = string
  default     = "East US"
}

variable "default_tags_enabled" {
  description = "Option to enable or disable default tags."
  type        = bool
  default     = true
}

variable "product_code" {
  type = string
  default = "AzureDeprication"
}

variable "project_code" {
  type = string
  default = "DEV-DEVOPSENH"
}

variable "business_unit" {
  type = string
  default = "woodmac"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "contact" {
  type = string
  default = "wm-sre@woodmac.com"
}

variable "extra_tags" {
  description = "Extra tags to add."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------------
# App Configuration
#----------------------------------------------------------
variable "app_settings" {
  description = "Application settings for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#app_settings"
  type        = map(string)
  default     = {}
}

variable "site_config" {
  description = "Site config for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#site_config. IP restriction attribute is no more managed in this block."
  type        = any
  default     = {}
}

variable "connection_strings" {
  description = "Connection strings for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#connection_string"
  type        = list(map(string))
  default     = []
}

variable "sticky_settings" {
  description = "Lists of connection strings and app settings to prevent from swapping between slots."
  type = object({
    app_setting_names       = optional(list(string))
    connection_string_names = optional(list(string))
  })
  default = null
}

variable "client_affinity_enabled" {
  description = "Client affinity activation for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#client_affinity_enabled"
  type        = bool
  default     = true
}

variable "https_only" {
  description = "HTTPS restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#https_only"
  type        = bool
  default     = true
}

variable "client_certificate_enabled" {
  description = "Client certificate activation for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#client_certificate_enabled"
  type        = bool
  default     = false
}

#---------------------------------------------------------
# App Network Restrictions
#----------------------------------------------------------
variable "public_network_access_enabled" {
  description = "Whether enable public access for the App Service."
  type        = bool
  default     = false
}

variable "authorized_ips" {
  description = "IPs restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#ip_restriction"
  type        = list(string)
  default     = []
}

variable "authorized_subnet_ids" {
  description = "Subnets restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#ip_restriction"
  type        = list(string)
  default     = []
}

variable "authorized_service_tags" {
  description = "Service Tags restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#ip_restriction"
  type        = list(string)
  default     = []
}

variable "ip_restriction_headers" {
  description = "IPs restriction headers for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#headers"
  type        = map(list(string))
  default     = null
}

variable "scm_authorized_ips" {
  description = "SCM IPs restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#scm_ip_restriction"
  type        = list(string)
  default     = []
}

variable "scm_authorized_subnet_ids" {
  description = "SCM subnets restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#scm_ip_restriction"
  type        = list(string)
  default     = []
}

variable "scm_authorized_service_tags" {
  description = "SCM Service Tags restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#scm_ip_restriction"
  type        = list(string)
  default     = []
}

variable "scm_ip_restriction_headers" {
  description = "IPs restriction headers for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#headers"
  type        = map(list(string))
  default     = null
}

variable "app_service_vnet_integration_subnet_id" {
  description = "Id of the subnet to associate with the app service"
  type        = string
  default     = null
}

#---------------------------------------------------------
# Backup options and Storage accounts
#----------------------------------------------------------
variable "backup_enabled" {
  description = "`true` to enable App Service backup"
  type        = bool
  default     = true
}

variable "backup_custom_name" {
  description = "`true` to enable App Service backup"
  type        = bool
  default     = false
}

variable "backup_frequency_interval" {
  description = "Frequency interval for the App Service backup."
  type        = number
  default     = 1
}

variable "backup_retention_period_in_days" {
  description = "Retention in days for the App Service backup."
  type        = number
  default     = 7
}

variable "backup_frequency_unit" {
  description = "Frequency unit for the App Service backup. Possible values are `Day` or `Hour`."
  type        = string
  default     = "Day"
}

variable "backup_keep_at_least_one_backup" {
  description = "Should the service keep at least one backup, regardless of age of backup."
  type        = bool
  default     = true
}

variable "storage_account_container_uri" {
  description = "Storage account connection string to use if App Service backup is enabled."
  type        = string
  default     = null
}

variable "storage_container_name" {
  description = "The name of the storage container to keep backups"
  default     = null
}

variable "storage_account_name" {
  type = string
  default = "teststrageaccount12" 
}

variable "password_rotation_in_years" {
  description = "Number of years to add to the base timestamp to configure the password rotation timestamp. Conflicts with password_end_date and either one is specified and not the both"
  default     = 2
}

variable "mount_points" {
  description = "Storage Account mount points. Name is generated if not set and default type is `AzureFiles`. See https://www.terraform.io/docs/providers/azurerm/r/app_service.html#storage_account"
  type = list(object({
    name         = optional(string)
    type         = optional(string, "AzureFiles")
    account_name = string
    share_name   = string
    access_key   = string
    mount_path   = optional(string)
  }))
  validation {
    condition     = alltrue([for m in var.mount_points : contains(["AzureBlob", "AzureFiles"], m.type)])
    error_message = "The `type` attribute of `var.mount_points` object list must be `AzureBlob` or `AzureFiles`."
  }
  default  = []
  nullable = false
}

#---------------------------------------------------------
# App Auth Configuration
#----------------------------------------------------------
variable "auth_settings" {
  description = "Authentication settings. Issuer URL is generated thanks to the tenant ID. For active_directory block, the allowed_audiences list is filled with a value generated with the name of the App Service. See https://www.terraform.io/docs/providers/azurerm/r/app_service.html#auth_settings"
  type        = any
  default     = {}
}

variable "auth_settings_v2" {
  description = "Authentication settings V2. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app#auth_settings_v2"
  type        = any
  default     = {}
}

#---------------------------------------------------------
# App Custom Domain Configuration
#----------------------------------------------------------
variable "custom_domains" {
  description = <<EOD
Custom domains and SSL certificates of the App Service. Could declare a custom domain with SSL binding. SSL certificate could be provided from an Azure Keyvault Certificate Secret or from a file with following attributes :
```
- certificate_name:                     Name of the stored certificate.
- certificate_keyvault_certificate_id:  ID of the Azure Keyvault Certificate Secret.
```
EOD
  type = map(object({
    certificate_name                    = optional(string)
    certificate_keyvault_certificate_id = optional(string)
    certificate_thumbprint              = optional(string)
  }))
  default  = {}
  nullable = false
}

variable "certificates" {
  description = "Certificates for custom domains"
  type        = map(map(string))
  default     = {}
}

#---------------------------------------------------------
# App Insight and Logging Configuration
#----------------------------------------------------------
variable "application_insights_enabled" {
  description = "Specify the Application Insights use for this App Service"
  default     = false
}

variable "application_insights_id" {
  description = "Specify the Application Insights ID for this App Service"
  default     = null
}

variable "application_insights_name" {
  description = "Specify the name for Application Insights"
  default     = null
}

variable "application_insights_log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace to be used with Application Insights."
  type        = string
  default     = null
}

variable "application_insights_type" {
  description = "Application Insights type if need to be generated. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights#application_type"
  type        = string
  default     = "web"
}

variable "application_insights_daily_data_cap" {
  description = "Daily data volume cap (in GB) for Application Insights."
  type        = number
  default     = null
}

variable "application_insights_daily_data_cap_notifications_disabled" {
  description = "Whether disable email notifications when data volume cap is met."
  type        = bool
  default     = null
}

variable "application_insights_sampling_percentage" {
  description = "Percentage of data produced by the monitored application sampled for Application Insights telemetry."
  type        = number
  default     = null
}

variable "application_insights_retention" {
  description = "Retention period (in days) for logs. supported value is one of [30 60 90 120 180 270 365 550 730]"
  type        = number
  default     = 30
}

variable "application_insights_internet_ingestion_enabled" {
  description = "Whether ingestion support from Application Insights component over the Public Internet is enabled."
  type        = bool
  default     = true
}

variable "application_insights_internet_query_enabled" {
  description = "Whether querying support from Application Insights component over the Public Internet is enabled."
  type        = bool
  default     = true
}

variable "application_insights_ip_masking_disabled" {
  description = "Whether IP masking in logs is disabled."
  type        = bool
  default     = false
}

variable "application_insights_local_authentication_disabled" {
  description = "Whether Non-Azure AD based authentication is disabled."
  type        = bool
  default     = false
}

variable "application_insights_force_customer_storage_for_profiler" {
  description = "Whether to enforce users to create their own Storage Account for profiling in Application Insights."
  type        = bool
  default     = false
}

variable "app_insights" {
  description = "App insight name"
  type        = list(map(string))
  default     = []
}

variable "app_service_logs" {
  description = "Configuration of the App Service and App Service Slot logs. Documentation [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app#logs)"
  type = object({
    detailed_error_messages = optional(bool)
    failed_request_tracing  = optional(bool)
    application_logs = optional(object({
      file_system_level = string
      azure_blob_storage = optional(object({
        level             = string
        retention_in_days = number
        sas_url           = string
      }))
    }))
    http_logs = optional(object({
      azure_blob_storage = optional(object({
        retention_in_days = number
        sas_url           = string
      }))
      file_system = optional(object({
        retention_in_days = number
        retention_in_mb   = number
      }))
    }))
  })
  default = null
}

#---------------------------------------------------------
# App Identity Configuration
#----------------------------------------------------------
variable "identity" {
  description = "Map with identity block information."
  type = object({
    type         = string
    identity_ids = list(string)
  })
  default = {
    type         = "SystemAssigned"
    identity_ids = []
  }
}
