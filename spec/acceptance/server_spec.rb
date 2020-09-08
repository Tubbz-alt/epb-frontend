# frozen_string_literal: true

describe "Acceptance::Server" do
  include RSpecFrontendServiceMixin

  describe ".get /index" do
    let(:response) { get "/" }

    it "returns status 200" do
      expect(response.status).to eq(200)
    end
    it "includes the index page title" do
      expect(response.body).to include(
        "<title>Energy performance of buildings register - Select your service</title>",
      )
    end
    it "displays the index page heading" do
      expect(response.body).to include(
        "Services related to Energy Performance Certificate (EPC)",
      )
    end
  end

  describe ".get /find-an-assessor" do
    let(:response) { get "/find-an-assessor" }

    it "returns status 200" do
      expect(response.status).to eq(200)
    end
    it "includes the find-an-assessor page title" do
      expect(response.body).to include(
        " <title>Energy performance of buildings register - Getting a new energy certificate</title>",
      )
    end
    it "displays the find-an-assessor page heading" do
      expect(response.body).to include("Getting a new energy certificate")
    end
  end

  describe ".get /healthcheck" do
    let(:response) { get "/healthcheck" }

    it "returns status 200" do
      expect(response.status).to eq(200)
    end
  end

  describe ".get /schemes" do
    let(:response) { get "/schemes" }

    it "displays the schemes page title" do
      expect(response.body).to include(
        "Contact an energy assessor accreditation scheme",
      )
    end
  end

  describe ".get a non-existent page" do
    let(:response) { get "/this-page-does-not-exist" }

    it "returns status 404" do
      expect(response.status).to eq(404)
    end
  end
end
