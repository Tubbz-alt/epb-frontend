# frozen_string_literal: true

class Container
  def initialize
    internal_api_client =
      Auth::HttpClient.new ENV['EPB_AUTH_CLIENT_ID'],
                           ENV['EPB_AUTH_CLIENT_SECRET'],
                           ENV['EPB_AUTH_SERVER'],
                           ENV['EPB_API_URL'],
                           OAuth2::Client

    assessors_gateway = Gateway::AssessorsGateway.new(internal_api_client)
    certificates_gateway = Gateway::CertificatesGateway.new(internal_api_client)
    find_assessor_by_postcode_use_case =
      UseCase::FindAssessorByPostcode.new(assessors_gateway)
    find_assessor_by_name_use_case =
      UseCase::FindAssessorByName.new(assessors_gateway)
    find_certificate_by_postcode_use_case =
      UseCase::FindCertificateByPostcode.new(certificates_gateway)
    find_certificate_by_id_use_case =
      UseCase::FindCertificateById.new(certificates_gateway)
    fetch_assessment_use_case =
      RemoteUseCase::FetchAssessment.new(internal_api_client)
    find_certificate_by_street_name_and_town_use_case =
      UseCase::FindCertificateByStreetNameAndTown.new(certificates_gateway)

    @objects = {
      internal_api_client: internal_api_client,
      find_assessor_by_postcode_use_case: find_assessor_by_postcode_use_case,
      find_assessor_by_name_use_case: find_assessor_by_name_use_case,
      fetch_assessment_use_case: fetch_assessment_use_case,
      find_certificate_by_postcode_use_case:
        find_certificate_by_postcode_use_case,
      find_certificate_by_id_use_case: find_certificate_by_id_use_case,
      find_certificate_by_street_name_and_town_use_case:
        find_certificate_by_street_name_and_town_use_case
    }
  end

  def get_object(key)
    @objects[key]
  end
end
