module DecoModel
  module Helpers
    protected

    def value_with_format( value, key, options = {} )
      
      if origin.class.respond_to?(:i18n_scope)
        defaults = origin.class.lookup_ancestors.map do |klass|
           :"#{origin.class.i18n_scope}.format.models.#{klass.model_name.i18n_key}.#{key}"
        end
      else
        defaults = []
      end
      
      defaults << :"activerecord.format.models.#{origin.class.model_name.i18n_key}.#{key}"
      defaults << :"activerecord.format.#{key}"
      defaults << value.to_s
      
      k = defaults.shift

      options = {
        :default => defaults,
        :value => value
      }.merge( options )
      I18n.t( k, options )
    end
    
    def attribute_with_format( attribute, options = {} )
      value = (options[:value] ||= origin.send( attribute ))
      
      options = {
        :model => origin.class.model_name.human,
        :attribute => origin.class.human_attribute_name(attribute)
      }.merge( options )
      
      value_with_format( value, attribute, options )
    end
    
  end
  
end
