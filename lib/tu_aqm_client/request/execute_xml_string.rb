module TuAqmClient
  module Request
    class ExecuteXmlString < BaseRequest

      SOAP_ACTION = "http://tempuri.org/IExternalSolutionExecution/ExecuteXMLString"

      def body
        "<?xml version=\"1.0\"?><s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\"><s:Body><ExecuteXMLString xmlns=\"http://tempuri.org/\"><request>#{dc_request}</request></ExecuteXMLString></s:Body></s:Envelope>"
      end

      private

      def dc_request
        HTMLEntities.new.encode(
          "<DCRequest
              xmlns=\"http://transunion.com/dc/extsvc\">
              <Authentication type=\"OnDemand\">
                  <UserId>sb_admin02</UserId>
                  <Password>Pass@1234</Password>
              </Authentication>
              <RequestInfo>
                  <ExecutionMode>NewWithContext</ExecutionMode>
                  <SolutionSetId>69</SolutionSetId>
                  <ExecuteLatestVersion>true</ExecuteLatestVersion>
              </RequestInfo>
              <Fields>
                  <Field key=\"ApplicationReceiptDate\">22Aug2017</Field>
                  <Field key=\"Channel\">1</Field>
                  <Field key=\"CurrencyCode\">PHP</Field>
                  <Field key=\"CurrentDate\">22Aug2017</Field>
                  <Field key=\"EnquiryAccountType\">3000</Field>
                  <Field key=\"InquiryAmount\">931000</Field>
                  <Field key=\"Product\">1</Field>
                  <Field key=\"SubProduct\">1</Field>
                  <Field key=\"BCLib_BureauRequestType\">uat</Field>
                  <Field key=\"Applicants\">
                      <![CDATA[
                          <object>
                              <Applicant>
                                  <Title>1</Title>
                                  <FirstName>Ban</FirstName>
                                  <MiddleName></MiddleName>
                                  <LastName>Stormborn</LastName>
                                  <Gender>1</Gender>
                                  <DateOfBirth>07Aug1987</DateOfBirth>
                                  <PlaceOfBirth></PlaceOfBirth>
                                  <CivilStatus>S</CivilStatus>
                                  <IdType>TIN</IdType>
                                  <IdNumber>160083344</IdNumber>
                                  <IdExpireDate>01Jun2020</IdExpireDate>
                                  <Citizenship>PHL</Citizenship>
                                  <NumberOfDependants>3</NumberOfDependants>
                                  <CarOwnership />
                                  <HomeOwnership />
                                  <YearsOfResidence>10</YearsOfResidence>
                                  <MothersMaidenName></MothersMaidenName>
                                  <AddressType>R</AddressType>
                                  <AddressLine1>test test test</AddressLine1>
                                  <AddressLine2>makati city</AddressLine2>
                                  <AddressLine3></AddressLine3>
                                  <AddressLine4></AddressLine4>
                                  <PostalZipCode>1880</PostalZipCode>
                                  <Country>PHL</Country>
                                  <ContactNumberType>R</ContactNumberType>
                                  <CountryCode>63</CountryCode>
                                  <AreaCode>918</AreaCode>
                                  <PhoneNumber>7035351</PhoneNumber>
                                  <Extension></Extension>
                                  <EmailAddress></EmailAddress>
                                  <EmploymentType>E</EmploymentType>
                                  <EmploymentStatus>01</EmploymentStatus>
                                  <NatureOfBusiness>99</NatureOfBusiness>
                                  <Occupation>99</Occupation>
                                  <CompanyName>XYZ Company</CompanyName>
                                  <EmploymentTimeYears>1</EmploymentTimeYears>
                                  <EmploymentTimeMonths>11</EmploymentTimeMonths>
                                  <YearsInBusiness>0</YearsInBusiness>
                                  <GrossAnnualIncome>600000</GrossAnnualIncome>
                                  <GrossMonthlyIncome>0</GrossMonthlyIncome>
                                  <EmploymentCurrencyCode>PHP</EmploymentCurrencyCode>
                                  <PositionLevel />
                                  <PositionTitle></PositionTitle>
                                  <SourceOfFunds />
                                  <AliasFirstName></AliasFirstName>
                                  <AliasMiddleName></AliasMiddleName>
                                  <AliasLastName></AliasLastName>
                                  <AliasMothersMaidenName></AliasMothersMaidenName>
                                  <BankCode></BankCode>
                                  <CardReferenceNo></CardReferenceNo>
                                  <CarMake></CarMake>
                                  <CarModel></CarModel>
                                  <SumOfAssets></SumOfAssets>
                                  <EducationLevel />
                              </Applicant>
                          </object>
                      ]]>
                  </Field>
                 <Field key=\"Const_FolderPath\">C:LocalizationSimfiles</Field>
              </Fields>
          </DCRequest>".gsub("\n", "")
        )
      end
    end
  end
end
