# frozen_string_literal: true

module FetchCertificate
  class Stub
    def self.fetch(
      assessment_id,
      current_rating = 90,
      current_band = "b",
      recommended_improvements = false,
      current_carbon_emission = 2.4,
      potential_carbon_emission = 1.4,
      impact_of_loft_insulation = 79,
      impact_of_cavity_insulation = 67,
      impact_of_solid_wall_insulation = 69,
      related_party_disclosure_text = nil,
      related_party_disclosure_number = 1,
      property_summary = nil,
      type_of_assessment = "RdSAP",
      energy_performance_rating_improvement = 76,
      green_deal_plan = nil
    )
      property_summary ||= generate_property_summary
      green_deal_plan ||= generate_green_deal_plan

      if assessment_id == "1111-1111-1111-1111-1112"
        body = {
          "data": {
            "dateOfAssessment": "2020-05-04",
            "dateRegistered": "2020-05-04",
            "dwellingType": "Dwelling-Type0",
            "typeOfAssessment": "RdSAP",
            "totalFloorArea": 0.0,
            "assessmentId": "1111-1111-1111-1111-1112",
            "currentEnergyEfficiencyRating": 50,
            "potentialEnergyEfficiencyRating": 50,
            "currentCarbonEmission": 4.4,
            "potentialCarbonEmission": 3.4,
            "postcode": "A0 0AA",
            "dateOfExpiry": "2030-05-04",
            "addressLine1": "1 Some Street",
            "addressLine2": "",
            "addressLine3": "",
            "addressLine4": "",
            "town": "Post-Town1",
            estimatedCostForThreeYears: 689.83,
            potentialSavingForThreeYears: 174.83,
            "heatDemand": {
              "currentSpaceHeatingDemand": 30.0,
              "currentWaterHeatingDemand": 60.0,
              "impactOfLoftInsulation": -8,
              "impactOfCavityInsulation": -12,
              "impactOfSolidWallInsulation": -16,
            },
            "currentEnergyEfficiencyBand": "e",
            "potentialEnergyEfficiencyBand": "e",
            "relatedPartyDisclosureText": "Financial interest in the property",
            "relatedPartyDisclosureNumber": nil,
            "propertySummary": [],
            "recommendedImprovements": [
              {
                "sequence": 0,
                "improvementCode": "",
                "improvementTitle": "Fix the boiler",
                "improvementDescription":
                  "An informative description of how to fix the boiler",
                "indicativeCost": "",
                "typicalSaving": "0.0",
                "improvementCategory": "6",
                "improvementType": "Z3",
                "energyPerformanceRatingImprovement":
                  energy_performance_rating_improvement,
                "environmentalImpactRatingImprovement": 50,
                "greenDealCategoryCode": "1",
              },
              {
                "sequence": 1,
                "improvementCode": "1",
                "improvementTitle": "",
                "improvementDescription": "",
                "indicativeCost": "",
                "typicalSaving": "0.1",
                "improvementCategory": "2",
                "improvementType": "Z2",
                "energyPerformanceRatingImprovement": 60,
                "environmentalImpactRatingImprovement": 64,
                "greenDealCategoryCode": "3",
              },
            ],
            "assessor": {
              "firstName": "Kevin",
              "lastName": "Keenoy",
              "registeredBy": { "name": "Quidos", "schemeId": 6 },
              "schemeAssessorId": "3",
              "dateOfBirth": "1994-01-01",
              "contactDetails": {
                "email": "kevin.keenoy@epb-assessors.com",
                "telephoneNumber": "04150859",
              },
              "searchResultsComparisonPostcode": "TQ11 0EG",
              "qualifications": {
                "domesticSap": "INACTIVE",
                "domesticRdSap": "ACTIVE",
                "nonDomesticSp3": "ACTIVE",
                "nonDomesticCc4": "ACTIVE",
                "nonDomesticDec": "INACTIVE",
                "nonDomesticNos3": "ACTIVE",
                "nonDomesticNos4": "ACTIVE",
                "nonDomesticNos5": "INACTIVE",
              },
            },
          },
          "meta": {},
        }
      else
        recommended_improvements =
          if recommended_improvements
            [
              {
                sequence: 3,
                indicativeCost: "£200 - £500",
                typicalSaving: 100.00,
                improvementCode: "1",
                improvementCategory: "string",
                improvementType: "string",
                energyPerformanceRatingImprovement: 96,
                environmentalImpactRatingImprovement: "string",
                greenDealCategoryCode: "string",
              },
              {
                sequence: 1,
                indicativeCost: "£500 - £1000",
                typicalSaving: 900.00,
                improvementCode: "2",
                improvementCategory: "string",
                improvementType: "string",
                energyPerformanceRatingImprovement: 60,
                environmentalImpactRatingImprovement: "string",
                greenDealCategoryCode: "string",
              },
              {
                sequence: 2,
                indicativeCost: "£300 - £400",
                typicalSaving: 9000.00,
                improvementCode: "8",
                improvementCategory: "string",
                improvementType: "string",
                energyPerformanceRatingImprovement: 76,
                environmentalImpactRatingImprovement: "string",
                greenDealCategoryCode: "string",
              },
            ]
          else
            []
          end

        body = {
          data: {
            assessor: {
              firstName: "Test",
              lastName: "Boi",
              registeredBy: { name: "Elmhurst Energy", schemeId: 1 },
              schemeAssessorId: "TESTASSESSOR",
              dateOfBirth: "2019-12-04",
              contactDetails: {
                telephoneNumber: "12345678901", email: "test.boi@quidos.com"
              },
              searchResultsComparisonPostcode: "SW1A 2AA",
              qualifications: { domesticRdSap: "ACTIVE" },
            },
            assessmentId: assessment_id,
            dateRegistered: "2020-01-05",
            dateOfExpiry: "2030-01-05",
            dateOfAssessment: "2020-01-02",
            dwellingType: "Top floor flat",
            typeOfAssessment: type_of_assessment,
            totalFloorArea: 150,
            currentEnergyEfficiencyRating: current_rating,
            currentEnergyEfficiencyBand: current_band,
            currentCarbonEmission: current_carbon_emission,
            potentialCarbonEmission: potential_carbon_emission,
            potentialEnergyEfficiencyRating: 99,
            potentialEnergyEfficiencyBand: "a",
            postcode: "SW1B 2BB",
            addressLine1: "Flat 33",
            addressLine2: "2 Marsham Street",
            addressLine3: "",
            addressLine4: "",
            town: "London",
            estimatedCostForThreeYears: 689.83,
            potentialSavingForThreeYears: 174.83,
            heatDemand: {
              currentSpaceHeatingDemand: 222,
              currentWaterHeatingDemand: 321,
              impactOfLoftInsulation: impact_of_loft_insulation,
              impactOfCavityInsulation: impact_of_cavity_insulation,
              impactOfSolidWallInsulation: impact_of_solid_wall_insulation,
            },
            recommendedImprovements: recommended_improvements,
            relatedPartyDisclosureText: related_party_disclosure_text,
            relatedPartyDisclosureNumber: related_party_disclosure_number,
            propertySummary: property_summary,
            greenDealPlan: green_deal_plan,
          },
        }
      end

      WebMock.stub_request(
        :get,
        "http://test-api.gov.uk/api/assessments/#{assessment_id}",
      )
        .to_return(status: 200, body: body.to_json)
    end

    def self.generate_green_deal_plan
      {
        greenDealPlanId: "ABC123456DEF",
        startDate: "2020-01-30",
        endDate: "2030-02-28",
        providerDetails: {
          name: "The Bank",
          telephone: "0800 0000000",
          email: "lender@example.com",
        },
        interest: { rate: 12.3, fixed: true },
        chargeUplift: { amount: 1.25, date: "2025-03-29" },
        ccaRegulated: true,
        structureChanged: false,
        measuresRemoved: false,
        measures: [
          {
            sequence: 0,
            measureType: "Loft insulation",
            product: "WarmHome lagging stuff (TM)",
            repaidDate: "2025-03-29",
          },
        ],
        charges: [
          {
            sequence: 0,
            startDate: "2020-03-29",
            endDate: "2030-03-29",
            dailyCharge: "0.34",
          },
        ],
        savings: [
          {
            sequence: 0,
            fuelCode: "LPG",
            fuelSaving: 0,
            standingChargeFraction: -0.3,
          },
        ],
      }
    end

    def self.generate_property_summary
      [
        { name: "wall", description: "Many walls", energyEfficiencyRating: 2 },
        {
          name: "secondary_heating",
          description: "Heating the house",
          energyEfficiencyRating: 5,
        },
        {
          name: "main_heating",
          description: "Room heaters, electric",
          energyEfficiencyRating: 3,
        },
      ]
    end
  end
end
