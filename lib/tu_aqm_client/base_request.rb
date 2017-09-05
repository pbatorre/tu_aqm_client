module TuAqmClient
  class BaseRequest
    ENDPOINT = "https://localhost:8444/DCAQM/TU.IDS.ExternalServices/SolutionExecution/ExternalSolutionExecution.svc"
    HEADER = {'Content-type' => 'text/xml; charset=utf-8'}

    def execute
      response = HTTParty.post(ENDPOINT, {
        verify: false,
        headers: HEADER.merge('SOAPAction' => self.class::SOAP_ACTION),
        body: body.gsub("\n", ""),
      })

      binding.pry
    end
  end
end
