# frozen_string_literal: true

module UseCase
  class FetchDecSummary < UseCase::Base
    def execute(assessment_id)
      response = @gateway.fetch_dec_summary(assessment_id)

      raise_errors_if_exists(response) do |error_code|
        raise Errors::AssessmentNotFound if error_code == "NOT_FOUND"
        raise Errors::AssessmentNotFound if error_code == "GONE"
        raise Errors::AssessmentNotFound if error_code == "NOT_A_DEC"
      end

      response
    end
  end
end
