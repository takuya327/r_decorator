require 'deco_model/view_context'
require 'rails'

module DecoModel
  class Railtie < ::Rails::Railtie
    initializer 'deco_model' do
      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.send :include, DecoModel::ViewContext::Filter
      end
      ActiveSupport.on_load(:active_record) do
        require 'deco_model/active_record/base'
      end
    end
  end
end