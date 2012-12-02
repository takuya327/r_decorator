require 'singleton'

module DecoModel
  
  class Factory
    include Singleton
    
    def initialize
      @@decorators = {}
    end

    def decorator_for(model_class)
      return @@decorators[model_class] if @@decorators.has_key? model_class

      decorator = begin
        klass = nil
        ancestor_models = model_class.ancestors.select{|ancestor| ancestor < ActiveRecord::Base }
        ancestor_models.each do |model|
          klass = "#{model.model_name}Decorator".safe_constantize
          break if klass
        end
        klass
      end || (defined?(ApplicationDecorator) ? ApplicationDecorator : nil)

      @@decorators[model_class] = decorator
    end
    
  end
  
end