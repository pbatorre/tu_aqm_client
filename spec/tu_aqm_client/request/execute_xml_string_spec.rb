require "spec_helper"

module TuAqmClient
  module Request
    describe ExecuteXmlString, ".execute" do

      let(:request) do
        TuAqmClient::Request::ExecuteXmlString.new.execute
      end

      specify ".execute", vcr: {record: :once} do
        expect(request)
      end
    end
  end
end
