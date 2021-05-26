resource_name :nomad_telemetry_config
provides :nomad_telemetry_config

property :telemetry_name, String, name_property: true, identity: true
NomadCookbook::TelemetryConfig::OPTIONS.each do |opt, conf|
  property opt, conf.delete(:kind_of), **conf
end

unified_mode true

%i(create delete).each do |actn|
  action actn do
    directory NomadCookbook::Helpers::CONFIG_ROOT do
      not_if { new_resource.action == :delete }
    end

    file ::File.join(NomadCookbook::Helpers::CONFIG_ROOT,
                     "#{new_resource.telemetry_name}.telemetry.json") do
      content(JSON.pretty_generate(
                {
                  telemetry: NomadCookbook::Helpers
                               .property_hash(new_resource,
                                              NomadCookbook::TelemetryConfig::OPTIONS),
                }, quirks_mode: true)
             )
      action actn
    end
  end
end
