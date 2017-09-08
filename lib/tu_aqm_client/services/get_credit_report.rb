module TuAqmClient
  module Services
    class ResponseError < StandardError; end
    class MissingFieldsError < StandardError; end
    class CreditReportExtractionError < StandardError; end

    class GetCreditReport
      attr_accessor :user_id
      attr_accessor :password
      attr_accessor :application_receipt_date
      attr_accessor :current_date
      attr_accessor :first_name
      attr_accessor :last_name
      attr_accessor :gender
      attr_accessor :date_of_birth
      attr_accessor :civil_status
      attr_accessor :id_type
      attr_accessor :id_number
      attr_accessor :address_type
      attr_accessor :address
      attr_accessor :contact_number_type
      attr_accessor :contact_number
      attr_accessor :bureau_request_type

      def initialize(
        user_id:,
        password:,
        application_receipt_date:,
        current_date:,
        first_name:,
        last_name:,
        gender:,
        date_of_birth:,
        civil_status:,
        id_type:,
        id_number:,
        address_type:,
        address:,
        contact_number_type:,
        contact_number:,
        bureau_request_type:
      )

        @user_id = user_id
        @password = password
        @application_receipt_date = application_receipt_date
        @current_date = current_date
        @first_name = first_name
        @last_name = last_name
        @gender = gender
        @date_of_birth = date_of_birth
        @civil_status = civil_status
        @id_type = id_type
        @id_number = id_number
        @address_type = address_type
        @address = address
        @contact_number_type = contact_number_type
        @contact_number = contact_number
        @bureau_request_type = bureau_request_type
      end

      def execute
        response = TuAqmClient::Request::ExecuteXmlString.new(
          user_id: user_id,
          password: password,
          application_receipt_date: application_receipt_date,
          current_date: current_date,
          first_name: first_name,
          last_name: last_name,
          gender: gender,
          date_of_birth: date_of_birth,
          civil_status: civil_status,
          id_type: id_type,
          id_number: id_number,
          address_type: address_type,
          address: address,
          contact_number_type: contact_number_type,
          contact_number: contact_number,
          bureau_request_type: bureau_request_type,
        ).execute

        build_credit_report(response)
      end

      private

      def build_credit_report(response)
        response_hash = Hash.from_xml(response.body)
        dc_response = Hash.from_xml(response_hash["Envelope"]["Body"]["ExecuteXMLStringResponse"]["ExecuteXMLStringResult"])

        raise_response_error(dc_response)

        xmls = extract_xmls(dc_response["DCResponse"]["ContextData"]["Field"])
        raise_missing_field_error(xmls)

        extract_credit_report(xmls)
      end

      # Collects XML files. Ignores non-xmls
      def extract_xmls(array)
        array.map do |e|
          begin
            Hash.from_xml(e)
          rescue
          end
        end.compact
      end

      # Retrieve hash with key = "object"
      def extract_credit_report(xmls)
        # Extract xml with "object" tag
        object_xml = xmls.find do |xml|
          xml.keys.include? "object"
        end

        begin
          return Hash.from_xml(object_xml["object"]["Applicant"]["CreditReport"])
        rescue
          raise(
            CreditReportExtractionError,
            "Error extracting the credit report due do unexpected response"
          )
        end
      end

      def raise_missing_field_error(xmls)
        xmls.each do |xml|
          if xml["ReasonsTrail"]
            raise(
              MissingFieldsError,
              xml.to_json,
            )
          end
        end
      end

      def raise_response_error(dc_response)
        raise(
          ResponseError,
          dc_response.to_json
        ) if dc_response["DCResponse"]["Status"] == "Failed" ||
          dc_response["DCResponse"]["Status"] == "Exception"
      end
    end
  end
end
