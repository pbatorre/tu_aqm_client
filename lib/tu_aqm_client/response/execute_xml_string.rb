module TuAqmClient
  module Response
    class ExecuteXmlString < BaseResponse
      attr_accessor :body

      def initialize(body)
        @body = body
      end
    end
  end
end
