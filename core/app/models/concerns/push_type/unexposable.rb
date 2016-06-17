module PushType
  module Unexposable
    extend ActiveSupport::Concern

    included do
      scope :exposed, -> {
        unexposed_classes.present? ? where.not(type: unexposed_classes.map(&:name)) : all
      }
    end

    def exposed?
      self.class.exposed?
    end

    module ClassMethods

      def descendants(opts = {})
        if opts.has_key? :exposed
          super().select { |d| !opts[:exposed] == PushType.send(unexposure_method).include?(d.name.underscore) }
        else
          super()
        end
      end

      def unexposed_classes
        _ct.base_class.descendants(exposed: false)
      end

      def unexposure_method
        case _ct.base_class.name.demodulize
          when 'Node' then :unexposed_nodes
        end
      end

      def unexpose!
        PushType.config.send(unexposure_method).push(self.name.underscore.to_sym).uniq!
      end

      def exposed?
        !unexposed_classes.include?(self)
      end

    end

  end
end