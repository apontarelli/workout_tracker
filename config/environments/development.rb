# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  configure_general_settings(config)
  configure_caching(config)
  configure_storage(config)
  configure_mailer(config)
  configure_active_support(config)
  configure_active_record(config)
  configure_assets(config)
  configure_miscellaneous(config)
end

private

def configure_general_settings(config)
  config.enable_reloading = true
  config.eager_load = false
  config.consider_all_requests_local = true
  config.server_timing = true
end

def configure_caching(config)
  if Rails.root.join('tmp/caching-dev.txt').exist?
    enable_caching(config)
  else
    disable_caching(config)
  end
end

def enable_caching(config)
  config.action_controller.perform_caching = true
  config.action_controller.enable_fragment_cache_logging = true
  config.cache_store = :memory_store
  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{2.days.to_i}"
  }
end

def disable_caching(config)
  config.action_controller.perform_caching = false
  config.cache_store = :null_store
end

def configure_storage(config)
  config.active_storage.service = :local
end

def configure_mailer(config)
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
end

def configure_active_support(config)
  config.active_support.deprecation = :log
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []
end

def configure_active_record(config)
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
  config.active_job.verbose_enqueue_logs = true
end

def configure_assets(config)
  config.assets.quiet = true
end

def configure_miscellaneous(config)
  configure_misc_i18n(config)
  configure_misc_view(config)
  configure_misc_action_cable(config)
  config.action_controller.raise_on_missing_callback_actions = true
end

def configure_misc_i18n(config)
  # config.i18n.raise_on_missing_translations = true
end

def configure_misc_view(config)
  # config.action_view.annotate_rendered_view_with_filenames = true
end

def configure_misc_action_cable(config)
  # config.action_cable.disable_request_forgery_protection = true
end
