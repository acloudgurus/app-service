locals {

  default_tags = var.default_tags_enabled ? {
    ProductCode   = var.product_code
    ProjectCode   = var.project_code
    BusinessUnit  = var.business_unit
    Environment   = var.environment
    contact       = var.contact
  } : {}

  default_site_config = {
    always_on               = "false"
    scm_minimum_tls_version = "1.2"
  }

  site_config              = merge(local.default_site_config, var.site_config)

  default_app_settings_with_new_app_insight = var.application_insights_enabled && var.application_insights_id == null ? {
    APPLICATION_INSIGHTS_IKEY             = try(azurerm_application_insights.app_insights[0].instrumentation_key, "")
    APPINSIGHTS_INSTRUMENTATIONKEY        = try(azurerm_application_insights.app_insights[0].instrumentation_key, "")
    APPLICATIONINSIGHTS_CONNECTION_STRING = try(azurerm_application_insights.app_insights[0].connection_string, "")
  } : {}

  app_insights = try(data.azurerm_application_insights.app_insights[0], {})

  default_app_settings_with_exsistant_app_insight = var.application_insights_enabled && var.application_insights_id != null ? {
    APPLICATION_INSIGHTS_IKEY             = try(local.app_insights.instrumentation_key, "9bc33d0d-e841-4c71-9dc4-99561127737a")
    APPINSIGHTS_INSTRUMENTATIONKEY        = try(local.app_insights.instrumentation_key, "9bc33d0d-e841-4c71-9dc4-99561127737a")
    APPLICATIONINSIGHTS_CONNECTION_STRING = try(local.app_insights.connection_string, "InstrumentationKey=9bc33d0d-e841-4c71-9dc4-99561127737a;IngestionEndpoint=https://eastus-8.in.applicationinsights.azure.com/;LiveEndpoint=https://eastus.livediagnostics.monitor.azure.com/;ApplicationId=e85e58cc-866f-4e79-b2dc-6c2a2aee61ce")
  } : {}

  default_app_settings = coalesce(local.default_app_settings_with_new_app_insight, local.default_app_settings_with_exsistant_app_insight)
  app_settings = merge(local.default_app_settings, var.app_settings)
  default_ip_restrictions_headers = {
    x_azure_fdid      = null
    x_fd_health_probe = null
    x_forwarded_for   = null
    x_forwarded_host  = null
  }

  ip_restriction_headers = var.ip_restriction_headers != null ? [merge(local.default_ip_restrictions_headers, var.ip_restriction_headers)] : []

  cidrs = [for cidr in var.authorized_ips : {
    name                      = "ip_restriction_cidr_${join("", [1, index(var.authorized_ips, cidr)])}"
    ip_address                = cidr
    virtual_network_subnet_id = null
    service_tag               = null
    subnet_id                 = null
    priority                  = join("", [1, index(var.authorized_ips, cidr)])
    action                    = "Allow"
    headers                   = local.ip_restriction_headers
  }]

  subnets = [for subnet in var.authorized_subnet_ids : {
    name                      = "ip_restriction_subnet_${join("", [1, index(var.authorized_subnet_ids, subnet)])}"
    ip_address                = null
    virtual_network_subnet_id = subnet
    service_tag               = null
    subnet_id                 = subnet
    priority                  = join("", [1, index(var.authorized_subnet_ids, subnet)])
    action                    = "Allow"
    headers                   = local.ip_restriction_headers
  }]

  service_tags = [for service_tag in var.authorized_service_tags : {
    name                      = "service_tag_restriction_${join("", [1, index(var.authorized_service_tags, service_tag)])}"
    ip_address                = null
    virtual_network_subnet_id = null
    service_tag               = service_tag
    subnet_id                 = null
    priority                  = join("", [1, index(var.authorized_service_tags, service_tag)])
    action                    = "Allow"
    headers                   = local.ip_restriction_headers
  }]

  scm_ip_restriction_headers = var.scm_ip_restriction_headers != null ? [merge(local.default_ip_restrictions_headers, var.scm_ip_restriction_headers)] : []

  scm_cidrs = [for cidr in var.scm_authorized_ips : {
    name                      = "scm_ip_restriction_cidr_${join("", [1, index(var.scm_authorized_ips, cidr)])}"
    ip_address                = cidr
    virtual_network_subnet_id = null
    service_tag               = null
    subnet_id                 = null
    priority                  = join("", [1, index(var.scm_authorized_ips, cidr)])
    action                    = "Allow"
    headers                   = local.scm_ip_restriction_headers
  }]

  scm_subnets = [for subnet in var.scm_authorized_subnet_ids : {
    name                      = "scm_ip_restriction_subnet_${join("", [1, index(var.scm_authorized_subnet_ids, subnet)])}"
    ip_address                = null
    virtual_network_subnet_id = subnet
    service_tag               = null
    subnet_id                 = subnet
    priority                  = join("", [1, index(var.scm_authorized_subnet_ids, subnet)])
    action                    = "Allow"
    headers                   = local.scm_ip_restriction_headers
  }]

  scm_service_tags = [for service_tag in var.scm_authorized_service_tags : {
    name                      = "scm_service_tag_restriction_${join("", [1, index(var.scm_authorized_service_tags, service_tag)])}"
    ip_address                = null
    virtual_network_subnet_id = null
    service_tag               = service_tag
    subnet_id                 = null
    priority                  = join("", [1, index(var.scm_authorized_service_tags, service_tag)])
    action                    = "Allow"
    headers                   = local.scm_ip_restriction_headers
  }]

  auth_settings = merge(
    {
      enabled                        = false
      issuer                         = format("https://sts.windows.net/%s/", data.azurerm_client_config.main.tenant_id)
      token_store_enabled            = false
      unauthenticated_client_action  = "RedirectToLoginPage"
      default_provider               = "AzureActiveDirectory"
      allowed_external_redirect_urls = []
      active_directory               = null
    },
  var.auth_settings)

  auth_settings_active_directory = merge(
    {
      client_id         = null
      client_secret     = null
      allowed_audiences = []
    },
  local.auth_settings.active_directory == null ? local.auth_settings_ad_default : var.auth_settings.active_directory)

  auth_settings_ad_default = {
    client_id         = null
    client_secret     = null
    allowed_audiences = []
  }

  auth_settings_v2 = merge({
    auth_enabled = false
  }, var.auth_settings_v2)

  auth_settings_v2_login_default = {
    token_store_enabled               = false
    token_refresh_extension_time      = 72
    preserve_url_fragments_for_logins = false
    cookie_expiration_convention      = "FixedTime"
    cookie_expiration_time            = "08:00:00"
    validate_nonce                    = true
    nonce_expiration_time             = "00:05:00"
  }

  auth_settings_v2_login = try(var.auth_settings_v2.login, local.auth_settings_v2_login_default)

  backup_name = coalesce(var.backup_custom_name, "DefaultBackup")
  storage_account_container_uri = var.backup_enabled ? format("https://${data.azurerm_storage_account.storeacc.0.name}.blob.core.windows.net/${azurerm_storage_container.storcont.0.name}%s", data.azurerm_storage_account_blob_container_sas.main.0.sas) : ""


}
