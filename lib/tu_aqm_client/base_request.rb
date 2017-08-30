module TuAqmClient
  class BaseRequest

    include Virtus.model
    include ActiveModel::Validations

    attribute :endpoint, String
    attribute :username, String
    attribute :password, String

    validates(
      :endpoint,
      :username,
      :password,
      presence: true,
    )

    def self.execute(attributes)
      self.new(attributes).execute
    end

    def execute
      fail ArgumentError, errors.full_messages.join("; ") if invalid?
      soap_action = self.class.const_get("SOAP_ACTION")
      fail ArgumentError, "define SOAP_ACTION" unless soap_action

      SoapClient.request(soap_action, request_args)
    end

    def request_args
      attributes.reject { |key, value| value.nil? }
    end

  end
end
