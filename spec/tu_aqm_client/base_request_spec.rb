require "spec_helper"

module TuAqmClient
  describe BaseRequest do

    describe "#request_args" do
      it "removes any keys with nil values" do
        request = described_class.new(username: "Ok")
        expect(request.request_args).to eq(username: "Ok")
      end
    end

    describe ".execute" do
      context "attributes are invalid" do
        it "raises ValidationError" do
          params = {
            username: "username",
            password: "password",
          }

          request = described_class.new(params)

          expect { request.execute }.
            to raise_error(ArgumentError, "Endpoint can't be blank")
        end

      end

      it "makes a request with the correct action" do
        fake_request_class = Class.new(BaseRequest)
        fake_request_class::SOAP_ACTION = :fake_action

        params = {
          endpoint: "endpoint",
          username: "username",
          password: "password",
        }

        response = double

        expect(SoapClient).to receive(:request).
          with(:fake_action, hash_including(params)).
          and_return(response)

        expect(fake_request_class.execute(params)).to eq response
      end
    end

  end
end
