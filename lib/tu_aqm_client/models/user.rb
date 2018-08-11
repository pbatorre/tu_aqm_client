module TuAqmClient
  module Models
    class User
      include ActiveModel::Validations

      validates :id_number, :id_type, presence: true
      validates :id_expiration_date, presence: true, if: :has_expiration?

      def has_expiration?
        ['DL', 'PP', 'PRC'].include? id_type
      end

      def initialize(params = {})
        params = params.merge({
          address_type: 'R',
          area_code: '0',
          country_code: '63',
          postal_zip_code: '0000',
          company_name: 'Information Not Available',
          contact_number_type: 'R',
          contact_number: '9999999',
          employment_type: 'S',
          employment_status: '11',
          id_expiration_date: Date.today,
        })

        @first_name = params[:first_name]
        @last_name = params[:last_name]
        @gender = map_gender(params[:gender])
        @date_of_birth = DateFormatter::format(params[:date_of_birth])
        @civil_status = map_civil_status(params[:civil_status])
        @id_type = params[:id_type]
        @id_number = format_id_number(params[:id_type], params[:id_number])
        @id_expiration_date = params[:id_expiration_date]
        @address_type = params[:address_type]
        @address_1, @address_2, @address_3, @address_4 = split_full_address(params[:address])
        @contact_number_type = params[:contact_number_type]
        @contact_number = params[:contact_number]
        @postal_zip_code = params[:postal_zip_code]
        @country_code = params[:country_code]
        @area_code = params[:area_code]
        @company_name = params[:company_name]
        @email_address = params[:email_address]
        @employment_type = params[:employment_type]
        @employment_status = params[:employment_status]
      end

      def as_param
        JSON.parse(self.to_json, symbolize_names: true)
      end

      def map_civil_status(civil_status)
        case  civil_status
        when 'married' then 'M'
        when 'single' then 'S'
        else  'U'
        end
      end

      def map_gender(gender)
        case gender
        when 'f' then 1
        when 'm' then 2
        else 3
        end
      end

      def format_id_number(id_type, id_number)
        id_number = id_number.gsub(/\W/, '')

        case id_type
        when 'TIN' then id_number[0..8]
        else id_number
        end
      end

      private

      def split_full_address(address)
        address.gsub(/[^0-9a-z ]/i, '').chars.each_slice(40).map(&:join)
      end

    end
  end
end
