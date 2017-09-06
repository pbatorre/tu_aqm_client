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
TU_AQM_USERID="username_given_by_tu"
TU_AQM_PASSWORD="password_given_by_tu"
```

### To retrieve a credit report:

```
TuAqmClient::get_credit_report(
  user_id: "user_id",
  password: "password",
  application_receipt_date: "22Aug2017",
  current_date: "22Aug2017",
  first_name: "Daenerys",
  last_name: "Stormborn",
  gender: "1",
  date_of_birth: "07Aug1987",
  civil_status: "S",
  id_type: "TIN",
  id_number: "160083344",
  address_type: "R",
  address: "#1 Castle Street, DragonStone, Westeros",
  contact_number_type: "R",
  contact_number: "09986732889",
)
```
Take note that `user_id` and `password` are given by Transunion.

`TuAqmClient::get_credit_report` will then return the credit report as shown below:

```ruby
{"CreditReport"=>
  {"Header"=>
    {"SegmentTag"=>"TUEF",
     "Version11"=>"11",
     "MemberReferenceNumber"=>"0000000000000000000000025",
     "UserId"=>"BB03300101",
     "SubjectReturnCode"=>"0",
     "EnquiryControlNumber"=>"001457261",
     "DateProcessed"=>"31082017",
     "TimeProcessed"=>"182553"},
   "NA"=>
    {"NameSegment"=>
      {"SegmentTagLength"=>"03",
       "SegmentTag"=>"N01",
       "FirstNameLength"=>"08",
       "FirstName"=>"DAENERYS",
       "LastNameLength"=>"09",
       "LastName"=>"STORMBORN",
       "CivilStatusLength"=>"01",
       "CivilStatus"=>"S",
       "DOBLength"=>"08",
       "DOB"=>"07081987",
       "GenderLength"=>"01",
       "Gender"=>"1",
       "NationalityLength"=>"03",
       "Nationality"=>"PHL"}},
   "ID"=>
    {"IDSegment"=>
      {"SegmentTagLength"=>"03",
       "SegmentTag"=>"I01",
       "IDNumberLength"=>"09",
       "IDNumber"=>"160083344",
       "IDTypeLength"=>"03",
       "IDType"=>"TIN"}},
   "PA"=>
    {"PrimaryAddressSegment"=>
      {"SegmentTagLength"=>"03",
       "SegmentTag"=>"A01",
       "AddressLine1FieldLength"=>"26",
       "AddressLine1"=>"TEST TEST TEST MAKATI CITY",
       "ResidentialAddress"=>"Y",
       "OfficialAddressFieldLength"=>"01",
       "OfficialAddress"=>"N",
       "BillingAddress"=>"N",
       "AddressOfOtherType"=>"N",
       "AddressOfUnknownType"=>"N",
       "ReportedViaAct"=>"N",
       "FileSinceDate"=>"31082017",
       "LastReportedDate"=>"31082017"}},
   "PH"=>
    {"ContactNumberSegment"=>
      {"SegmentTagLength"=>"03",
       "SegmentTag"=>"P01",
       "ContactNumberFieldLength"=>"07",
       "ContactNumber"=>"7035351",
       "FormatFieldLength"=>"01",
       "Format"=>"F",
       "NumberTypeFieldLength"=>"01",
       "NumberType"=>"R",
       "ReportedViaAcct"=>"N",
       "FileSinceDate"=>"31082017",
       "LastReportedDate"=>"31082017",
       "MultipleContributor"=>"N"}},
   "EM"=>
    {"EmploymentSegment"=>
      {"SegmentTagLength"=>"03",
       "SegmentTag"=>"M01",
       "CompanyNameLength"=>"11",
       "CompanyName"=>"XYZ COMPANY",
       "NatureOfBusinessLength"=>"02",
       "NatureOfBusiness"=>"99",
       "EmploymentTypeLength"=>"01",
       "EmploymentType"=>"E",
       "OccupationLength"=>"02",
       "Occupation"=>"99",
       "EmploymentYearsLength"=>"01",
       "EmploymentYears"=>"1",
       "EmploymentMonthsLength"=>"02",
       "EmploymentMonths"=>"11",
       "CurrencyCodeLength"=>"03",
       "CurrencyCode"=>"PHP",
       "FileSinceDateFieldLength"=>"08",
       "FileSinceDate"=>"31082017",
       "LastReportedDate"=>"31082017"}},
   "SM"=>
    {"SummarySegment"=>
      {"SegmentTagLength"=>"03",
       "SegmentTag"=>"S01",
       "OpenAccountLength"=>"01",
       "OpenAccount"=>"0",
       "ClosedAccountLength"=>"01",
       "ClosedAccount"=>"0",
       "AliasNameAlertLength"=>"01",
       "AliasNameAlert"=>"0",
       "EnquiryAlertLength"=>"01",
       "EnquiryAlert"=>"0"}},
   "SC"=>
    {"ScoreSegment"=>
      {"SegmentTagLength"=>"03",
       "SegmentTag"=>"S01",
       "ScoreTypeLength"=>"04",
       "ScoreType"=>"GR01",
       "ScoreLength"=>"02",
       "Score"=>"-1",
       "SegmentLength"=>"01",
       "Segment"=>"1",
       "PredictedProbabilityLength"=>"02",
       "PredictedProbability"=>"-1",
       "RiskGradeLength"=>"02",
       "RiskGrade"=>"NA"}}}}
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
