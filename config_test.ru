# frozen_string_literal: true

require "net/http"
require "zeitwerk"
require "webmock"

loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}/lib/")
loader.push_dir("#{__dir__}/spec/test_doubles/")
loader.setup

WebMock.enable!

OauthStub.token
FindAssessor::ByPostcode::Stub.search_by_postcode(
  "SW1A 2AA",
  "nonDomesticSp3,nonDomesticCc4,nonDomesticDec,nonDomesticNos3,nonDomesticNos4,nonDomesticNos5",
)
FindAssessor::ByPostcode::Stub.search_by_postcode("SW1A 2AA")
FindAssessor::ByName::Stub.search_by_name("Supercommon Name")
FindAssessor::ByName::Stub.search_by_name("Somewhatcommon Name", true)
FindCertificate::Stub.search_by_postcode("SW1A 2AA")
FindCertificate::Stub.search_by_postcode("SW1A 2AA", "CEPC")
FindCertificate::Stub.search_by_id("4567-6789-4567-6789-4567")
FindCertificate::Stub.search_by_street_name_and_town(
  "1 Makeup Street",
  "Beauty Town",
)
FindCertificate::Stub.search_by_street_name_and_town(
  "1 Commercial Street",
  "Industry Town",
  %w[DEC DEC-RR CEPC CEPC-RR AC-REPORT AC-CERT],
  "CEPC",
)

FindCertificate::NoCertificatesStub.search_by_street_name_and_town(
  "Madeup Street",
  "Madeup Town",
)
FetchCertificate::Stub.fetch("4567-6789-4567-6789-4567")
FetchCertificate::Stub.fetch("0000-0000-0000-0000-0001")

FetchCertificate::Stub.fetch(
  "1234-5678-9101-1122-1234",
  "25",
  "f",
  true,
  7.8254,
  6.5123,
  nil,
  nil,
  nil,
  nil,
  1,
  [
    { name: "Walls", description: "Its a wall", energyEfficiencyRating: 2 },
    {
      name: "secondary_heating",
      description: "Heating the house",
      energyEfficiencyRating: 5,
    },
    {
      name: "MainHeating",
      description: "Room heaters, electric",
      energyEfficiencyRating: 3,
    },
  ],
)
FetchCertificate::NonDomesticStub.fetch assessment_id:
                                          "1234-5678-9101-1123-1234"

FetchCertificate::NonDomesticStub.fetch assessment_id:
                                          "1234-5678-1234-5678-1234"
FetchAssessmentSummary::AssessmentStub.fetch "1234-5678-1234-5678-1234", "b"
FetchCertificate::RecommendationReportStub.fetch assessment_id:
                                                   "4192-1535-8427-8844-6702",
                                                 linked_to_cepc:
                                                   "1234-5678-1234-5678-1234"

FetchCertificate::NonDomesticStub.fetch assessment_id:
                                          "1111-0000-0000-0000-0000"
FetchAssessmentSummary::AssessmentStub.fetch "1111-0000-0000-0000-0000",
                                             "b",
                                             "1111-0000-0000-0000-0000"
FetchCertificate::RecommendationReportStub.fetch assessment_id:
                                                   "1111-0000-0000-0000-0001",
                                                 linked_to_cepc:
                                                   "1111-0000-0000-0000-0000"

FetchCertificate::RecommendationReportStub.fetch assessment_id:
                                                   "0000-0000-0000-0000-0007"

FetchCertificate::RecommendationReportStub.fetch assessment_id:
                                                   "0000-0000-0000-0000-0008",
                                                 date_of_expiry: "2020-06-06"

ENV["EPB_AUTH_CLIENT_ID"] = "test.id"
ENV["EPB_AUTH_CLIENT_SECRET"] = "test.client.secret"
ENV["EPB_AUTH_SERVER"] = "http://test-auth-server.gov.uk"
ENV["EPB_API_URL"] = "http://test-api.gov.uk"

run FrontendService.new
