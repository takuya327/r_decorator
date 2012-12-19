module RDecorator
  class Base
    attr_reader :origin, :options
    
    def initialize(obj, options={})
      @origin = obj
      @context = options.delete(:context)
      @options = options
    end
      
    def method_missing(method, *args, &block)
      begin
        origin.__send__(method, *args, &block)
      rescue NoMethodError, NameError
        context.__send__(method, *args, &block)
      end
    end
    
    def respond_to?(*args)
      super || origin.respond_to?(*args) || context.respond_to?(*args)
    end
    
    def self.decorate_for(*args)
      args.map{|target| decorate!(target, self) }
    end
    
    def self.inherited(klass)
      # TODO: skipping auto decoration if the subclass has defined so.
      target = klass.name.sub(/Decorator$/,"")
      klass.__send__( :decorate!, target, true )
    end
    
    def self.redecoate!
      decorating_classes.each do |klass|
        decorate_class!(klass)
      end
    end
    
    def self.decorating_classes
      @_classes ||= []
    end
    
    private
    
    def context
      @context ||= RDecorator::ViewContext.current
    end
    
    def self.decorate!(target, ignore_missing = false)
      klass = target_to_class(target,ignore_missing)
      return nil unless klass
      
      unless decorating_classes.include?(klass)
        decorate_class!(klass)
        decorating_classes << klass
      end
      klass
    end
    
    def self.decorate_class!(klass)
      unless klass.method_defined?(:decorated)
        klass.class_eval <<-STR
          def decorated(options={}) 
            @_decorator ||= #{self.name}.new(self, options)
          end
          alias_method :deco, :decorated
        STR
      end
    end
    
    def self.target_to_class(target, ignore_missing = false)
      case target
      when String, Symbol
        begin
          target = target.to_s.camelize
          klass = target.constantize
        rescue NameError
        end
      else
        klass = target
      end
      
      unless klass.is_a?(Class)
        raise "Invalid target for decoration(#{self}): #{klass}" unless ignore_missing
        klass = nil
      end
      klass
    end
    
  end
  
end