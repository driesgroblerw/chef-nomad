resource_name :nomad_config
provides :nomad_config

property :config_name, String, name_property: true, identity: true
NomadCookbook::Config::OPTIONS.each do |opt, conf|
  property opt, conf.delete(:kind_of), **conf
end

unified_mode true

%i(create delete).each do |actn|
  action actn do
    directory NomadCookbook::Helpers::CONFIG_ROOT do
      not_if { new_resource.action == :delete }
    end

    file ::File.join(NomadCookbook::Helpers::CONFIG_ROOT,
                     "#{new_resource.config_name}.json") do
      content(
        JSON.pretty_generate(
          NomadCookbook::Helpers
          .property_hash(new_resource, NomadCookbook::Config::OPTIONS),
        quirks_mode: true)
      )
      action actn
    end
  end
end
