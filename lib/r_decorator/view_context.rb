module RDecorator
  module ViewContext
    class << self
      def current
        Thread.current[:view_context]
      end

      def current=(view_context)
        Thread.current[:view_context] = view_context
      end
    end

    module Filter
      extend ActiveSupport::Concern

      included do
        before_filter do |controller|
          RDecorator::ViewContext.current = controller.view_context
        end
      end
    end
  end
end