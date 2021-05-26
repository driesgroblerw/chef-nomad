#
# Cookbook:: nomad
# Library:: NomadCookbook
#
# Copyright:: 2015-2018, Nathan Williams <nath.e.will@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require_relative 'helpers'

module NomadCookbook
  module Config
    OPTIONS ||= {
      # General Options
      addresses: NomadCookbook::Helpers.conf_keys_include_opts(
        %w(http rpc serf)
      ),
      advertise: NomadCookbook::Helpers.conf_keys_include_opts(
        %w(http rpc serf)
      ),
      bind_addr: { kind_of: String },
      datacenter: { kind_of: String },
      data_dir: { kind_of: String },
      disable_anonymous_signature: { kind_of: [TrueClass, FalseClass] },
      disable_update_check: { kind_of: [TrueClass, FalseClass] },
      enable_debug: { kind_of: [TrueClass, FalseClass] },
      enable_syslog: { kind_of: [TrueClass, FalseClass] },
      http_api_response_headers: { kind_of: Hash },
      leave_on_interrupt: { kind_of: [TrueClass, FalseClass] },
      leave_on_terminate: { kind_of: [TrueClass, FalseClass] },
      limits: NomadCookbook::Helpers.conf_keys_include_opts(
        %w(https_handshake_timeout
           http_max_conns_per_client
           rpc_handshake_timeout
           rpc_max_conns_per_client)
      ),
      log_level: { kind_of: String, equal_to: %w(WARN INFO DEBUG) },
      log_json: { kind_of: [TrueClass, FalseClass] },
      log_file: { kind_of: [String] },
      log_rotate_bytes: { kind_of: Integer },
      log_rotate_duration: { kind_of: String },
      log_rotate_max_files: { kind_of: Integer },
      plugin_dir: { kind_of: String },
      ports: NomadCookbook::Helpers.conf_keys_include_opts(%w(http rpc serf)),
      region: { kind_of: String },
      syslog_facility: { kind_of: String },
      # Sub-configuration
      acl: { kind_of: Hash },
      audit: { kind_of: Hash },
      client: { kind_of: Hash },
      consul: { kind_of: Hash },
      plugin: { kind_of: Hash },
      sentinel: { kind_of: Hash },
      server: { kind_of: Hash },
      telemetry: { kind_of: Hash },
      tls: { kind_of: Hash },
      vault: { kind_of: Hash },
    }.freeze
  end

  module ACLConfig
    OPTIONS ||= {
      enabled: { kind_of: [TrueClass, FalseClass] },
      token_ttl: {
        kind_of: String,
        callbacks: {
          'is a valid time-string' => lambda do |spec|
            spec.match(/^\d+(s|m|h)/)
          end,
        },
      },
      policy_ttl: {
        kind_of: String,
        callbacks: {
          'is a valid time-string' => lambda do |spec|
            spec.match(/^\d+(s|m|h)/)
          end,
        },
      },
      replication_token: { kind_of: String },
    }.freeze
  end

  module AuditConfig
    OPTIONS ||= {
      enabled: { kind_of: [TrueClass, FalseClass] },
      sink: { kind_of: Hash },
      filter: { kind_of: Array },
    }.freeze
  end

  module ClientConfig
    OPTIONS ||= {
      alloc_dir: { kind_of: String },
      chroot_env: { kind_of: Hash },
      enabled: { kind_of: [TrueClass, FalseClass] },
      max_kill_timeout: {
        kind_of: String,
        callbacks: {
          'is a valid time-string' => lambda do |spec|
            spec.match(/^\d+(s|m|h)/)
          end,
        },
      },
      disable_remote_exec: { kind_of: [TrueClass, FalseClass] },
      no_host_uuid: { kind_of: [TrueClass, FalseClass] },
      meta: { kind_of: Hash },
      network_interface: { kind_of: String },
      network_speed: { kind_of: Integer },
      cpu_total_compute: { kind_of: Integer },
      memory_total_mb: { kind_of: Integer },
      reservable_cores: { kind_of: String },
      node_class: { kind_of: String },
      options: NomadCookbook::Helpers.conf_keys_include_opts(
        %w(driver.whitelist
           driver.blacklist
           env.blacklist
           user.blacklist
           user.checked_drivers
           fingerprint.whitelist
           fingerprint.blacklist
           fingerprint.network.disallow_link_local)
      ),
      reserved: NomadCookbook::Helpers.conf_keys_include_opts(
        %w(cpu memory disk reserved_ports cores)
      ),
      servers: { kind_of: Array },
      server_join: NomadCookbook::Helpers.conf_keys_include_opts(
        %w(retry_join retry_interval retry_max start_join)
      ),
      state_dir: { kind_of: String },
      gc_interval: {
        kind_of: String,
        callbacks: {
          'is a valid time-string' => lambda do |spec|
            spec.match(/^\d+(s|m|h)/)
          end,
        },
      },
      gc_disk_usage_threshold: { kind_of: Integer },
      gc_inode_usage_threshold: { kind_of: Integer },
      gc_max_allocs: { kind_of: Integer },
      gc_parallel_destroys: { kind_of: Integer },
      cni_path: { kind_of: String },
      cni_config_dir: { kind_of: String },
      bridge_network_name: { kind_of: String },
      bridge_network_subnet: { kind_of: String },
      template: NomadCookbook::Helpers.conf_keys_include_opts(
        %w(function_denylist function_blacklist disable_file_sandbox)
      ),
      host_volume: { kind_of: Hash },
      host_network: { kind_of: Hash },
      bind_wildcard_default_host_network: { kind_of: [TrueClass, FalseClass] },
      cgroup_parent: { kind_of: String }
    }.freeze
  end

  module ConsulConfig
    OPTIONS ||= {
      address: { kind_of: String },
      allow_unauthenticated: { kind_of: [TrueClass, FalseClass] },
      auth: { kind_of: String },
      auto_advertise: { kind_of: [TrueClass, FalseClass] },
      ca_file: { kind_of: String },
      cert_file: { kind_of: String },
      checks_use_advertise: { kind_of: [TrueClass, FalseClass] },
      client_auto_join: { kind_of: [TrueClass, FalseClass] },
      client_service_name: { kind_of: String },
      key_file: { kind_of: String },
      server_service_name: { kind_of: String },
      server_http_check_name: { kind_of: String },
      server_serf_check_name: { kind_of: String },
      server_rpc_check_name: { kind_of: String },
      server_auto_join: { kind_of: [TrueClass, FalseClass] },
      share_ssl: { kind_of: [TrueClass, FalseClass] },
      ssl: { kind_of: [TrueClass, FalseClass] },
      tags: { kind_of: Array },
      token: { kind_of: String },
      verify_ssl: { kind_of: [TrueClass, FalseClass] },
    }.freeze
  end

  module PluginConfig
    OPTIONS ||= {
      args: { kind_of: Array },
      config: { kind_of: Array },
    }.freeze
  end

  module SentinelConfig
    OPTIONS ||= {
      import: NomadCookbook::Helpers.conf_keys_include_opts(%w(path args)),
    }.freeze
  end

  module ServerConfig
    OPTIONS ||= {
      authoritative_region: { kind_of: String },
      bootstrap_expect: {
        kind_of: Integer,
        callbacks: {
          'is a positive integer' => ->(spec) { spec.abs == spec },
        },
      },
      data_dir: { kind_of: String },
      enabled: { kind_of: [TrueClass, FalseClass] },
      enabled_schedulers: { kind_of: Array },
      encrypt: { kind_of: String },
      node_gc_threshold: {
        kind_of: String,
        callbacks: {
          'is a valid time expression' => lambda do |spec|
            spec.match(/^\d+(ns|us|µs|ms|s|m|h)$/)
          end,
        },
      },
      job_gc_interval: {
        kind_of: String,
        callbacks: {
          'is a valid time expression' => lambda do |spec|
            spec.match(/^\d+(ns|us|µs|ms|s|m|h)$/)
          end,
        },
      },
      job_gc_threshold: {
        kind_of: String,
        callbacks: {
          'is a valid time expression' => lambda do |spec|
            spec.match(/^\d+(ns|us|µs|ms|s|m|h)$/)
          end,
        },
      },
      eval_gc_threshold: {
        kind_of: String,
        callbacks: {
          'is a valid time expression' => lambda do |spec|
            spec.match(/^\d+(ns|us|µs|ms|s|m|h)$/)
          end,
        },
      },
      deployment_gc_threshold: {
        kind_of: String,
        callbacks: {
          'is a valid time expression' => lambda do |spec|
            spec.match(/^\d+(ns|us|µs|ms|s|m|h)$/)
          end,
        },
      },
      csi_plugin_gc_threshold: {
        kind_of: String,
        callbacks: {
          'is a valid time expression' => lambda do |spec|
            spec.match(/^\d+(ns|us|µs|ms|s|m|h)$/)
          end,
        },
      },
      default_scheduler_config: { kind_of: Hash },
      enable_event_broker: { kind_of: [TrueClass, FalseClass] },
      event_buffer_size: { kind_of: Integer },
      license_path: { kind_of: String },
      search: { kind_of: Hash },
      heartbeat_grace: {
        kind_of: String,
        callbacks: {
          'is a valid time expression' => lambda do |spec|
            spec.match(/^\d+(ns|us|µs|ms|s|m|h)$/)
          end,
        },
      },
      min_heartbeat_ttl: {
        kind_of: String,
        callbacks: {
          'is a valid time expression' => lambda do |spec|
            spec.match(/^\d+(ns|us|µs|ms|s|m|h)$/)
          end,
        },
      },
      max_heartbeats_per_second: { kind_of: Integer },
      non_voting_server: { kind_of: [TrueClass, FalseClass] },
      num_schedulers: {
        kind_of: Integer,
        callbacks: {
          'is a positive integer' => ->(spec) { spec.abs == spec },
        },
      },
      protocol_version: { kind_of: String },
      raft_protocol: { kind_of: Integer },
      raft_multiplier: { kind_of: Integer },
      redundancy_zone: { kind_of: String },
      rejoin_after_leave: { kind_of: [TrueClass, FalseClass] },
      retry_join: { kind_of: Array },
      retry_interval: { kind_of: String },
      retry_max: { kind_of: Integer },
      server_join: NomadCookbook::Helpers.conf_keys_include_opts(
        %w(retry_join retry_interval retry_max start_join)
      ),
      start_join: { kind_of: Array },
      upgrade_version: { kind_of: String },
    }.freeze
  end

  module TelemetryConfig
    OPTIONS ||= {
      disable_hostname: { kind_of: [TrueClass, FalseClass] },
      collection_interval: {
        kind_of: String,
        callbacks: {
          'is a valid time expression' => lambda do |spec|
            spec.match(/^\d+(ns|us|µs|ms|s|m|h)$/)
          end,
        },
      },
      use_node_name: { kind_of: [TrueClass, FalseClass] },
      publish_allocation_metrics: { kind_of: [TrueClass, FalseClass] },
      publish_node_metrics: { kind_of: [TrueClass, FalseClass] },
      filter_default: { kind_of: [TrueClass, FalseClass] },
      prefix_filter: { kind_of: Array },
      disable_dispatched_job_summary_metrics: { kind_of: [TrueClass, FalseClass] },
      statsd_address: { kind_of: String },
      statsite_address: { kind_of: String },
      datadog_address: { kind_of: String },
      datadog_tags: { kind_of: Array },
      prometheus_metrics: { kind_of: [TrueClass, FalseClass] },
      circonus_api_token: { kind_of: String },
      circonus_api_app: { kind_of: String },
      circonus_api_url: { kind_of: String },
      circonus_submission_interval: {
        kind_of: String,
        callbacks: {
          'is a valid time expression' => lambda do |spec|
            spec.match(/^\d+(ns|us|µs|ms|s|m|h)$/)
          end,
        },
      },
      circonus_submission_url: { kind_of: String },
      circonus_check_id: { kind_of: String },
      circonus_check_force_metric_activation: {
        kind_of: [TrueClass, FalseClass],
      },
      circonus_check_instance_id: { kind_of: String },
      circonus_check_search_tag: { kind_of: String },
      circonus_check_display_name: { kind_of: String },
      circonus_check_tags: { kind_of: String },
      circonus_broker_id: { kind_of: String },
      circonus_broker_select_tag: { kind_of: String },
    }.freeze
  end

  module TLSConfig
    OPTIONS ||= {
      ca_file: { kind_of: String },
      cert_file: { kind_of: String },
      key_file: { kind_of: String },
      http: { kind_of: [TrueClass, FalseClass] },
      rpc: { kind_of: [TrueClass, FalseClass] },
      rpc_upgrade_mode: { kind_of: [TrueClass, FalseClass] },
      tls_cipher_suites: { kind_of: String },
      tls_min_version: { kind_of: String },
      tls_prefer_server_cipher_suites: { kind_of: String },
      verify_https_client: { kind_of: [TrueClass, FalseClass] },
      verify_server_hostname: { kind_of: [TrueClass, FalseClass] },
    }.freeze
  end

  module VaultConfig
    OPTIONS ||= {
      address: { kind_of: String },
      allow_unauthenticated: { kind_of: [TrueClass, FalseClass] },
      enabled: { kind_of: [TrueClass, FalseClass] },
      create_from_role: { kind_of: String },
      task_token_ttl: { kind_of: String },
      ca_file: { kind_of: String },
      ca_path: { kind_of: String },
      cert_file: { kind_of: String },
      key_file: { kind_of: String },
      namespace: { kind_of: String },
      tls_server_name: { kind_of: String },
      tls_skip_verify: { kind_of: [TrueClass, FalseClass] },
      token: { kind_of: String },
    }.freeze
  end
end
