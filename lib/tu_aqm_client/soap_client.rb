module TuAqmClient
  class SoapClient

    SAVON_CLIENT_PARAMS = [
      :endpoint,
      :namespace,
      :log,
      :logger,
      :username,
      :password,
    ]

    def self.request(action, params)
      request_params = params

      savon_client = ::Savon.client(params)
      savon_client.call(
        action,
        message: {
          request: request_params,
        }
      )

    rescue Savon::SOAPFault, Savon::HTTPError => e
      raise ServerError.translate_fault(e)
    end
  end
end
