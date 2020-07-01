# frozen_string_literal: true

describe "Acceptance::Non Domestic Certificate" do
  include RSpecFrontendServiceMixin

  describe ".get /find-a-non-domestic-certificate" do
    context "when search page rendered" do
      let(:response) { get "/find-a-non-domestic-certificate" }

      it "returns status 200" do
        expect(response.status).to eq(200)
      end

      it "displays the find a certificate page heading" do
        expect(response.body).to include(
          "Find an energy certificate or report for a non-domestic property",
        )
      end
    end
  end
end