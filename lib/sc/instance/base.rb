module SC
  module Instance

    class Base
      attr_reader :instance_id

      def initialize(options = {})
        @instance_id = options[:instance_id]
        @origin      = options[:origin]
      end

    end

  end
end