module RDecorator
  class Engine < ::Rails::Engine
    config.after_initialize do
      Dir["#{Rails.root}/app/decorators/**/*.rb"].each {|f| require_dependency f}
    end
  end
end