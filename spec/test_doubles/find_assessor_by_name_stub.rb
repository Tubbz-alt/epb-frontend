# frozen_string_literal: true

class FindAssessorByNameStub
  def self.search(name)
    WebMock.stub_request(
      :get,
      "http://test-api.gov.uk/api/assessors?name=#{name}"
    )
      .with(
      headers: {
        Accept: '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        Authorization: 'Bearer abc',
        'User-Agent' => 'Faraday v1.0.0'
      }
    )
      .to_return(
      status: 200,
      body: {
        "results": [
          {
            "firstName": 'Juan',
            "lastName": 'Uno',
            "contactDetails": {
              "telephoneNumber": 'string', "email": 'user@example.com'
            },
            "searchResultsComparisonPostcode": 'SW1A 1AA',
            "registeredBy": { "schemeId": '432', "name": 'EPBs 4 U' }
          },
          {
            "firstName": 'Doux',
            "lastName": 'Twose',
            "contactDetails": {
              "telephoneNumber": '07921 021 368', "email": 'user@example.com'
            },
            "searchResultsComparisonPostcode": 'SW1A 1AA',
            "registeredBy": { "schemeId": '432', "name": 'EPBs 4 U' }
          },
          {
            "firstName": 'Tri',
            "lastName": 'Triple',
            "contactDetails": {
              "telephoneNumber": 'string', "email": 'user@example.com'
            },
            "searchResultsComparisonPostcode": 'SW1A 1AA',
            "registeredBy": { "schemeId": '432', "name": 'EPBs 4 U' }
          }
        ],
        "searchName": name
      }.to_json
    )
  end
end
