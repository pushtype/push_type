module PushType
  module Fields
    module Ui
      
      def column_class
        case @opts[:colspan]
          when 2 then 'medium-6'
          when 3 then 'medium-4'
          when 3 then 'medium-3'
          else nil
        end
      end

    end
  end
end