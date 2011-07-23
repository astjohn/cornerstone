module Cornerstone
  class Engine < Rails::Engine
    engine_name "cornerstone"
    isolate_namespace Cornerstone

    config.generators do |g|
      g.template_engine :erb
      g.test_framework  :rspec
    end
  end
end

