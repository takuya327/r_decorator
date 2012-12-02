require 'deco_model/helpers'

module DecoModel
  class Decorator
    include DecoModel::Helpers
    attr_reader :origin
    
    def initialize( obj, context = nil )
      @origin = obj
      @context = context
    end
      
    def decorate
      self
    end
    alias_method :deco, :decorate
    
    def decorated?
      true
    end
    
    def method_missing(method, *args, &block)
      begin
        if origin.attribute_names.include?(method.to_s)
          attribute_with_format( method )
        else
          origin.send(method, *args, &block)
        end
      rescue NoMethodError, NameError
        DecoModel::ViewContext.current.send(method, *args, &block)
      end
    end
    
    protected
    
    def context
      @context ||= DecoModel.ViewContext.current
    end
    
  end
  
end