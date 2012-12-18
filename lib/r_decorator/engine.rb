module RDecorator
  class Engine < ::Rails::Engine
    config.after_initialize do
      RDecorator::Base.descendants.each do |klass|
        klass.run_delay_decoration!
      end
    end
  end
end