# TU AQM Client

Gem for connecting to Transunion's AQM System for retrieving credit reports.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tu_aqm_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tu_aqm_client

## Usage

### Set the env variables

```
TU_AQM_ENDPOINT="https://tu_aqm_endpoint.svc"
```

### To retrieve a credit report:

```
TuAqmClient::get_credit_report(
  user_id: "user_id",
  password: "password",
  application_receipt_date: "21Sep2017",
  current_date: "21Sep2017",
  first_name: "Willie",
  last_name: "Diaz",
  gender: "2",
  date_of_birth: "29Dec1980",
  civil_status: "M",
  id_type: "TIN",
  id_number: "764492040",
  address_type: "R",
  address: "02 8TH CROSSING LOURDES PHILIPPINES",
  contact_number_type: "R",
  country_code: "63",
  area_code: "0",
  contact_number: "1111111",
  bureau_request_type: "uat",
  enquiry_account_type: "3000",
  inquiry_amount: "900000",
  postal_zip_code: "0000",
  company_name: "None",
  email_address: "wdiaze7@fastcompany.com",
)
```

### Notes
1. `user_id` and `password` are given by Transunion
2. `country_code` is required and is always "63"
3. `address` only accepts alphanumeric values
4. `contact_number` is "0000000" if not available
5. `bureau_request_type` is either "prod" or "uat"
6. `inquiry_amount` is "0" (zero) if not available
7. `postal_zip_code` is "0000" (four zeroes) if not available
8. `company_name` is "None" (four zeroes) if not available

`TuAqmClient::get_credit_report` will then return the credit report as shown in sample_credit_report.md

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
