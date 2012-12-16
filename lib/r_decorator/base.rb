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
        klass.class_eval <<-STR
          def decorated(options={}) 
            @_decorator ||= #{self.name}.new(self, options)
          end
          alias_method :deco, :decorated
        STR
        decorating_classes << klass
      end
      klass
    end
    
    def self.target_to_class(target, ignore_missing = false)
      case target
      when String, Symbol
        if ignore_missing
          klass = target.to_s.camelize.safe_constantize
          return nil if klass == nil
        else
          klass = target.to_s.camelize.constantize
        end
      else
        klass = target
      end
      raise "Invalid target for decoration(#{self}): #{klass}" unless klass.is_a?(Class)
      klass
    end
    
  end
  
end