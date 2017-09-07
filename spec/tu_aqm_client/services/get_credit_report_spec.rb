require "spec_helper"

module TuAqmClient
  module Services
    describe GetCreditReport, ".execute" do
      let(:user_id) { ENV["TU_AQM_USERID"] }
      let(:password) { ENV["TU_AQM_PASSWORD"] }
      let(:application_receipt_date) { "22Aug2017" }
      let(:current_date) { "22Aug2017" }
      let(:first_name) { "Daenerys" }
      let(:last_name) { "Stomborn" }
      let(:gender) { "1" }
      let(:date_of_birth) { "07Aug1987" }
      let(:civil_status) { "S" }
      let(:id_type) { "TIN" }
      let(:id_number) { "160083344" }
      let(:address_type) { "R" }
      let(:address) { "Address" }
      let(:contact_number_type) { "R" }
      let(:contact_number) { "09986732889" }

      let(:credit_report) do
        TuAqmClient::Services::GetCreditReport.new(
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
      end

      let(:expected_credit_report) do
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
      end

      it "executes", vcr: {record: :once} do
        expect(credit_report).to eq expected_credit_report
      end

      it "throws a MissingFieldError", vcr: {record: :once} do
        expect { credit_report }.to raise_error TuAqmClient::Services::MissingFieldsError
      end
    end
  end
end
