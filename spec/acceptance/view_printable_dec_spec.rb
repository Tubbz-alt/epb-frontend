# frozen_string_literal: true

describe "Acceptance::PrintableDisplayEnergyCertificate", type: :feature do
  include RSpecFrontendServiceMixin

  let(:response) do
    get "/energy-performance-certificate/0000-0000-0000-0000-1111?print=true"
  end

  context "when a dec exists" do
    before do
      FetchAssessmentSummary::AssessmentStub.fetch_dec(
        assessment_id: "0000-0000-0000-0000-1111", date_of_expiry: "2030-02-21",
      )
    end

    it "shows a back link" do
      expect(response.body).to have_link "Back",
                                         href: "/energy-performance-certificate/0000-0000-0000-0000-1111"
    end

    it "shows the page title" do
      expect(
        response.body,
      ).to have_text "Display Energy Certificate - how energy efficient is this building?"
    end

    it "shows the summary box" do
      expect(response.body).to include("0000-0000-0000-0000-1111")
      expect(response.body).to include("Valid until:")
      expect(response.body).to include("21 February 2030")
      expect(response.body).to include("A")
      expect(response.body).to include("2 Lonely Street")
      expect(response.body).to include("Post-Town1")
      expect(response.body).to include("A0 0AA")
    end

    it "shows the rating section" do
      expect(response.body).to include(
        ">Energy performance of this building</h2>",
      )
      expect(response.body).to include(
        "The building’s energy performance is based on its carbon dioxide (CO2) emissions for the last year.",
      )
      expect(response.body).to include(
        "Typical energy performance for a public building is 100. This typical score gives an energy rating of D.",
      )
      expect(response.body).to include("1 | A")
    end

    it "shows the previous operational ratings section" do
      expect(response.body).to have_css "h2", text: "Previous energy ratings"
      expect(response.body).to have_css "th", text: "January 2020"
      expect(response.body).to have_css "td", text: "1 | A"
      expect(response.body).to have_css "th", text: "January 2019"
      expect(response.body).to have_css "td", text: "24 | A"
      expect(response.body).to have_css "th", text: "January 2018"
      expect(response.body).to have_css "td", text: "40 | B"
    end

    it "shows the total CO2 emissions section" do
      expect(response.body).to include("Total CO2 emissions")
      expect(response.body).to include(
        "This tells you how much carbon dioxide the building emits. It shows tonnes per year of CO2.",
      )
      expect(response.body).to have_css "th", text: "Date"
      expect(response.body).to have_css "td", text: "January 2020"
      expect(response.body).to have_css "th", text: "Electricity"
      expect(response.body).to have_css "td", text: "7"
      expect(response.body).to have_css "th", text: "Heating"
      expect(response.body).to have_css "td", text: "3"
      expect(response.body).to have_css "th", text: "Renewables"
      expect(response.body).to have_css "td", text: "0"
    end

    it "shows the technical information section" do
      expect(response.body).to have_css "h3", text: "This building’s energy use"
      expect(response.body).to have_css "td", text: "Energy use"
      expect(response.body).to have_css "th", text: "Heating"
      expect(response.body).to have_css "th", text: "Electricity"
      expect(response.body).to have_css "th",
                                        text: "Annual energy use (kWh/m2/year)"
      expect(response.body).to have_css "td", text: "11"
      expect(response.body).to have_css "td", text: "12"
      expect(response.body).to have_css "th",
                                        text: "Typical energy use (kWh/m2/year)"
      expect(response.body).to have_css "td", text: "13"
      expect(response.body).to have_css "td", text: "14"
      expect(response.body).to have_css "th", text: "Energy from renewables"
      expect(response.body).to have_css "td", text: "15%"
      expect(response.body).to have_css "td", text: "16%"
    end

    describe "viewing the assessment details section" do
      it "shows the section heading" do
        expect(response.body).to have_css "h2", text: "Assessment details"
        expect(response.body).to have_css "th", text: "Assessor name"
        expect(response.body).to have_css "td", text: "TEST NAME BOI"
        expect(response.body).to have_css "th", text: "Accreditation scheme"
        expect(response.body).to have_css "td", text: "test scheme"
        expect(response.body).to have_css "th", text: "Employer/Trading name"
        expect(response.body).to have_css "td", text: "Joe Bloggs Ltd"
        expect(response.body).to have_css "th", text: "Employer/Trading address"
        expect(response.body).to have_css "td",
                                          text: "123 My Street, My City, AB3 4CD"
        expect(response.body).to have_css "th", text: "Issue date"
        expect(response.body).to have_css "td", text: "14 May 2020"
        expect(response.body).to have_css "th", text: "Nominated date"
        expect(response.body).to have_css "td", text: "1 January 2020"
        expect(response.body).to have_css "th", text: "Related party disclosure"
        expect(response.body).to have_css "td",
                                          text:
                                            "The assessor has not indicated whether they have a relation to this property."
      end
    end

    context "with different related party disclosure codes" do
      it "shows the corresponding related party disclosure text" do
        related_party_disclosures = {
          "1": "Not related to the occupier.",
          "2": "Employed by the occupier.",
          "3": "Contractor to the occupier for EPBD services only.",
          "4": "Contractor to the occupier for non-EPBD services.",
          "5": "Indirect relation to the occupier.",
          "6": "Financial interest in the occupier and/or property.",
          "7": "Previous relation to the occupier.",
          "8":
            "The assessor has not indicated whether they have a relation to this property.",
        }

        related_party_disclosures.each do |key, disclosure|
          FetchAssessmentSummary::AssessmentStub.fetch_dec(
            assessment_id: "0000-0000-0000-0000-1111",
            date_of_expiry: "2030-02-21",
            related_party: key,
          )

          response =
            get "/energy-performance-certificate/0000-0000-0000-0000-1111?print=true"

          expect(response.body).to have_css "td", text: disclosure
        end
      end
    end
  end
end