# frozen_string_literal: true

class FindAssessorByPostcodeNoNearAssessorsStub
  def self.search_by_postcode(postcode)
    WebMock.stub_request(
      :get,
      "http://test-api.gov.uk/api/assessors?postcode=#{postcode}"
    )
      .to_return(
      status: 200, body: { "results": [], "searchPostcode": 'BF1 3AA' }.to_json
    )
  end
end