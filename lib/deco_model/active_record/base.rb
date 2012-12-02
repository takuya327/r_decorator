class ActiveRecord::Base
  
  def decorate( options = {} )
    @_decorater ||= begin
      decorator_class = DecoModel::Factory.instance.decorator_for( self.class )
      decorator_class ? decorator_class.new( self, options ) : self
    end
  end
  alias_method :deco, :decorate
  
  def decorated?
    false
  end

end
