# -*- encoding: utf-8 -*-
# stub: data-confirm-modal 1.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "data-confirm-modal"
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Marcello Barnaba"]
  s.date = "2016-06-22"
  s.description = "This gem overrides Rails' UJS behaviour to open up a Bootstrap Modal instead of the browser's built in confirm() dialog"
  s.email = ["vjt@openssl.it"]
  s.homepage = "http://github.com/ifad/data-confirm-modal"
  s.rubygems_version = "2.5.1"
  s.summary = "Use bootstrap modals with Rails' UJS data-confirm"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, [">= 3.0"])
    else
      s.add_dependency(%q<railties>, [">= 3.0"])
    end
  else
    s.add_dependency(%q<railties>, [">= 3.0"])
  end
end
