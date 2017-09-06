require "spec_helper"

RSpec.describe TuAqmClient do
  it "has a version number" do
    expect(TuAqmClient::VERSION).not_to be nil
  end

  describe ".get_credit_report" do
    specify do
      expect(TuAqmClient::Services::GetCreditReport).
        to receive_message_chain(:new, :execute).and_return({})

      TuAqmClient.get_credit_report(double)
    end
  end
end
