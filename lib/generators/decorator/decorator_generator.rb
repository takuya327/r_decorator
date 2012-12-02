module Rails
  module Generators
   class DecoratorGenerator < NamedBase
      source_root File.expand_path("../templates", __FILE__)
      check_class_collision :suffix => "Decorator"

      class_option :parent, :type => :string, :desc => "The parent class for the generated decorator"

      desc <<DESC
Description:
    Stubs out a decorator class in app/decorators directory.

Examples:
    `rails g decorator book`

    This creates:
        app/decorators/book_decorator.rb
DESC

      def create_decorator_file
        template 'decorator.rb', File.join('app/decorators', class_path, "#{file_name}_decorator.rb")
      end

      hook_for :test_framework

      private

      def parent_class_name
        if options[:parent]
          options[:parent]
        elsif defined?(ApplicationDecorator)
          "ApplicationDecorator"
        else
          "DecoModel::Decorator"
        end
      end
   end
  end
end
