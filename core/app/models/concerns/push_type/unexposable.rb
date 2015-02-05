module PushType
  module Unexposable
    extend ActiveSupport::Concern

    included do
      scope :exposed, -> {
        node_types = PushType.unexposed_nodes
        node_types.present? ? where(['push_type_nodes.type NOT IN (?)', node_types]) : all
      }
    end

    def exposed?
      self.class.exposed?
    end

    module ClassMethods

      def unexpose!
        PushType.config.unexposed_nodes.push(self.name.underscore.to_sym).uniq!
      end

      def exposed?
        !PushType.unexposed_nodes.include?(self.name)
      end

    end

  end
end