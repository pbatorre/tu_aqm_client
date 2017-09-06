module TuAqmClient
  module Services
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
        contact_number:
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
        ).execute

        build_credit_report(response)
      end

      private

      def build_credit_report(response)
        response_hash = Hash.from_xml(response.body)
        dc_response = Hash.from_xml(response_hash["Envelope"]["Body"]["ExecuteXMLStringResponse"]["ExecuteXMLStringResult"])
        object_response = Hash.from_xml(dc_response["DCResponse"]["ContextData"]["Field"].last)

        Hash.from_xml(object_response["object"]["Applicant"]["CreditReport"])
      end
    end
  end
end
