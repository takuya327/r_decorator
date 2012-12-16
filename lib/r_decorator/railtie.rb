require 'r_decorator/view_context'
require 'rails'

module RDecorator
  class Railtie < ::Rails::Railtie
    initializer 'r_decorator' do
      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.send :include, RDecorator::ViewContext::Filter
      end
    end
  end
end