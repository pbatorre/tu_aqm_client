module TuAqmClient
  module Services
    class ResponseError < StandardError; end
    class MissingFieldsError < StandardError; end

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
      attr_accessor :enquiry_account_type
      attr_accessor :inquiry_amount
      attr_accessor :postal_zip_code
      attr_accessor :country_code
      attr_accessor :area_code
      attr_accessor :company_name
      attr_accessor :email_address

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
        bureau_request_type:,
        enquiry_account_type:,
        inquiry_amount:,
        postal_zip_code:,
        country_code:,
        area_code:,
        company_name:,
        email_address:
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
        @enquiry_account_type = enquiry_account_type
        @inquiry_amount = inquiry_amount
        @postal_zip_code = postal_zip_code
        @country_code = country_code
        @area_code = area_code
        @company_name = company_name
        @email_address = email_address
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
          enquiry_account_type: enquiry_account_type,
          inquiry_amount: inquiry_amount,
          postal_zip_code: postal_zip_code,
          country_code: country_code,
          area_code: area_code,
          company_name: company_name,
          email_address: email_address,
        ).execute

        build_credit_report(response)
      end

      private

      def build_credit_report(response)
        response_hash = Saxerator.parser(response.body)

        execute_xml_string_result = response_hash.
          for_tag("s:Body").
          first["ExecuteXMLStringResponse"]["ExecuteXMLStringResult"]

        dc_response_parser = Saxerator.parser(execute_xml_string_result)

        raise_response_error(dc_response_parser)

        xmls = extract_xmls(dc_response_parser)
        raise_missing_field_error(xmls)

        extract_credit_report(xmls)
      end

      # Collects XML files. Ignores non-xmls
      def extract_xmls(dc_response_parser)
        dc_response = dc_response_parser.for_tag("DCResponse").
          first["ContextData"]["Field"]

        dc_response.map do |e|
          begin
            Hash.from_xml(e)
          rescue
          end
        end.compact
      end

      def extract_credit_report(xmls)
        xmls.find do |xml|
          xml.keys.include? "CreditReport"
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

      def raise_response_error(dc_response_parser)
        dc_response = dc_response_parser.for_tag("DCResponse").first

        raise(
          ResponseError,
          dc_response.to_json
        ) if dc_response["Status"] == "Failed" ||
          dc_response["Status"] == "Exception"
      end
    end
  end
end
