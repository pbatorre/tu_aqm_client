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
      body = params[:request]
      request_params = params
      request_params.delete(:request)

      savon_client = ::Savon.client(request_params)
      savon_client.call(
        action,
        message: {
          request: body,
        }
      )

    rescue Savon::SOAPFault, Savon::HTTPError => e
      binding.pry
      raise ServerError.translate_fault(e)
    end
  end
end
