module RSpec::Rails::RDecoratorExampleGroup
  extend ActiveSupport::Concern
  include RSpec::Rails::RailsExampleGroup
  include ActionView::TestCase::Behavior

  included do
    metadata[:type] = :decorator

    before do
      RDecorator::ViewContext.current = controller.view_context
    end
  end
end

RSpec::configure do |c|
  c.include RSpec::Rails::RDecoratorExampleGroup, :type => :decorator, :example_group => {
    :file_path => c.escaped_path(%w[spec decorators])
  }
end