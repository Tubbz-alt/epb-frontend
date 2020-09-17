# frozen_string_literal: true

describe "Acceptance::AirConditioningInspectionReport", type: :feature do
  include RSpecFrontendServiceMixin

  let(:response) { get "/energy-certificate/0000-0000-0000-0000-9999" }

  context "when an ac report exists" do
    before do
      FetchAssessmentSummary::AssessmentStub.fetch_ac_report(
        assessment_id: "0000-0000-0000-0000-9999",
      )
    end

    it "shows the page title" do
      expect(response.body).to have_css "h1",
                                        text: "Air conditioning inspection report"
    end

    it "shows the summary section" do
      expect(response.body).to have_css "span", text: "The Bank Plc"
      expect(response.body).to have_css "span",
                                        text: "49-51 Northumberland Street"
      expect(response.body).to have_css "span", text: "NE1 7AF"
      expect(response.body).to have_css "label", text: "Certificate number"
      expect(response.body).to have_css "span", text: "0000-0000-0000-0000-9999"
      expect(response.body).to have_css "label", text: "Valid until"
      expect(response.body).to have_css "span", text: "6 February 2025"
      expect(response.body).to have_text "Print this certificate"
    end

    it "can show the Administrative information section" do
      expect(response.body).to have_css "h2", text: "Administrative information"
      expect(response.body).to have_css "dt", text: "Assessor name"
      expect(response.body).to have_css "dd", text: "TEST NAME BOI"
      expect(response.body).to have_css "dt", text: "Assessor number"
      expect(response.body).to have_css "dd", text: "SPEC000000"
      expect(response.body).to have_css "dt", text: "Accreditation scheme"
      expect(response.body).to have_css "dd", text: "Quidos"
      expect(response.body).to have_css "dt",
                                        text: "Accreditation scheme telephone"
      expect(response.body).to have_css "dd", text: "01225 667 570"
      expect(response.body).to have_css "dt", text: "Accreditation scheme email"
      expect(response.body).to have_css "dd", text: "info@quidos.co.uk"
      expect(response.body).to have_css "dt", text: "Employer/Trading name"
      expect(response.body).to have_css "dd", text: "Joe Bloggs Ltd"
      expect(response.body).to have_css "dt", text: "Employer/Trading address"
      expect(response.body).to have_css "dd",
                                        text: "123 My Street, My City, AB3 4CD"
    end

    it "can show the Executive summary section" do
      expect(response.body).to have_css "h2", text: "Executive summary"
      expect(response.body).to have_css "pre", text: "My\nSummary\t\tInspected"
    end

    it "can show the key recommendations section" do
      expect(response.body).to have_css "h2", text: "Key recommendations"
      expect(response.body).to have_css "h3", text: "Efficiency"
      expect(response.body).to have_css "p",
                                        text: "A way to improve your efficiency"
      expect(response.body).to have_css "p",
                                        text: "A second way to improve efficiency"
      expect(response.body).to have_css "h3", text: "Maintenance"
      expect(response.body).to have_css "p", text: "Text2"
      expect(response.body).to have_css "h3", text: "Control"
      expect(response.body).to have_css "p", text: "Text4"
      expect(response.body).to have_css "h3", text: "Management"
      expect(response.body).to have_css "p", text: "Text6"
    end

    it "can show the sub systems section" do
      expect(response.body).to have_css "h2", text: "Sub systems inspected"
      expect(response.body).to have_css "h3",
                                        text: "VOL001/SYS001 R410A Inverter Split Systems to Sales Area"
      expect(response.body).to have_css "dt", text: "Volume definitions"
      expect(response.body).to have_css "dd", text: "VOL001 The Shop"
      expect(response.body).to have_css "dt", text: "Description"
      expect(response.body).to have_css "dd",
                                        text:
                                          "This sub system comprised of; 4Nr 10kW R410A Mitsubishi Heavy Industries inverter driven split AC condensers."
      expect(response.body).to have_css "dt",
                                        text: "Effective rated cooling output"
      expect(response.body).to have_css "dd", text: "40 kW"
      expect(response.body).to have_css "dt", text: "Area served"
      expect(response.body).to have_css "dd", text: "Sales Area"
      expect(response.body).to have_css "dt", text: "Inspection date"
      expect(response.body).to have_css "dd", text: "20 May 2019"
      expect(response.body).to have_css "dt", text: "Cooling plant count"
      expect(response.body).to have_css "dd", text: "4"
      expect(response.body).to have_css "dt", text: "AHU count"
      expect(response.body).to have_css "dd", text: "0"
      expect(response.body).to have_css "dt", text: "Terminal units count"
      expect(response.body).to have_css "dd", text: "4"
      expect(response.body).to have_css "dt", text: "Sub system controls count"
      expect(response.body).to have_css "dd", text: "5"
    end

    it "can show the pre inspection section" do
      expect(response.body).to have_css "h2",
                                        text: "Pre inspection records requested"
      expect(response.body).to have_css "h3", text: "Essential records"
      expect(response.body).to have_css "h3", text: "Desirable records"
      expect(response.body).to have_css "h3", text: "Optional records"
    end

    it "can show the air handling systems" do
      expect(response.body).to have_css "h2", text: "Air handling systems"
      expect(response.body).to have_css "h3", text: "Air handling system 1"
      expect(response.body).to have_css "dt", text: "Component"
      expect(response.body).to have_css "dd", text: "VENT1 Heat recovery"
      expect(response.body).to have_css "dt", text: "Unit"
      expect(response.body).to have_css "dd", text: "123"
      expect(response.body).to have_css "dt", text: "Areas or systems served"
      expect(response.body).to have_css "dd", text: "Corridor"
      expect(response.body).to have_css "dt", text: "Discrepancies noted"
      expect(response.body).to have_css "dd", text: "None"
      expect(response.body).to have_css "dt", text: "Year installed"
      expect(response.body).to have_css "dd", text: "2016"
      expect(response.body).to have_css "dt", text: "Location of plant"
      expect(response.body).to have_css "dd", text: "Above corridor ceiling"
      expect(response.body).to have_css "dt", text: "Manufacturer"
      expect(response.body).to have_css "dd", text: "NUAIRE"
      expect(response.body).to have_css "dt",
                                        text: "Systems served from cooling plant"
      expect(response.body).to have_css "dd", text: "Corridor"
      expect(response.body).to have_css "h4",
                                        text: "CS6.1, CS6.2, CS6.3: Filters"
      expect(response.body).to have_css "h5",
                                        text: "Are air intake and filter conditions acceptable?"
      expect(response.body).to have_css "h5",
                                        text:
                                          "Have filters been changed according to current industry guidance?"
      expect(response.body).to have_css "h5",
                                        text:
                                          "Is the filter differential pressure gauge, where fitted, working?"
      expect(response.body).to have_css "p",
                                        text:
                                          "Originally changed on an annual basis but now upgraded to six monthly."
      expect(response.body).to have_css "p",
                                        text:
                                          "The assessor made the following notes and recommendations:"
      expect(response.body).to have_css "li",
                                        text: "Change this more frequently"
    end

    it "can show the terminal units" do
      expect(response.body).to have_css "h2", text: "Terminal units"
      expect(response.body).to have_css "h3",
                                        text:
                                          "VOL1/SYS1: Indoor wall type split which is part of a multi system with 5 indoor units."
    end

    it "can show the system controls" do
      expect(response.body).to have_css "h2", text: "System controls"
      expect(response.body).to have_css "h3",
                                        text:
                                          "Control for VOL001/SYS001 R410A Inverter Split Systems to Sales Area"
    end

    it "can show the related certificate" do
      expect(response.body).to have_css "h2", text: "Related certificate"
      expect(response.body).to have_css "a",
                                        text: "associated air conditioning inspection certificate"
    end

    context "when there are no subsystems" do
      before do
        FetchAssessmentSummary::AssessmentStub.fetch_ac_report(
          assessment_id: "0000-0000-0000-0000-9999", sub_systems: [],
        )
      end

      it "does not show the Sub systems inspected section" do
        expect(response.body).not_to have_css "h2",
                                              text: "Sub systems inspected"
      end
    end

    it "can show the cooling plant section" do
      expect(response.body).to have_css "h2", text: "Cooling plants"
      expect(response.body).to have_css "h3", text: "Cooling plant"
      expect(response.body).to have_css "dt", text: "Unit Identifier"
      expect(response.body).to have_css "dd",
                                        text: "VOL001/SYS001 R410A Inverter Split Systems to Sales Are"
      expect(response.body).to have_css "dt", text: "Component Identifier"
      expect(response.body).to have_css "dd",
                                        text: "VOL001/SYS001/CP1 Sampled R410A Inverter Split Area (1)"

      expect(response.body).to have_css "h4", text: "Equipment"

      expect(response.body).to have_css "dt",
                                        text: "Rated Cooling Capacity (kW)"
      expect(response.body).to have_css "dd", text: "10"
      expect(response.body).to have_css "dt", text: "Description (type/details)"
      expect(response.body).to have_css "dd", text: "Single Split"
      expect(response.body).to have_css "dt", text: "Location of Cooling Plant"
      expect(response.body).to have_css "dd", text: "Externally on roof"
      expect(response.body).to have_css "dt", text: "Manufacturer"
      expect(response.body).to have_css "dd", text: "Mitsubishi"
      expect(response.body).to have_css "dt", text: "Model/Reference"
      expect(response.body).to have_css "dd", text: "FDC100VN"
      expect(response.body).to have_css "dt",
                                        text: "Rated Cooling Capacity (kW)"
      expect(response.body).to have_css "dd", text: "3"
      expect(response.body).to have_css "dt", text: "Serial Number"
      expect(response.body).to have_css "dd", text: "not visible"
      expect(response.body).to have_css "dt", text: "Refrigerant Type"
      expect(response.body).to have_css "dd", text: "R410A"
      expect(response.body).to have_css "dt", text: "Year Plant Installed"
      expect(response.body).to have_css "dd", text: "2014"
      expect(response.body).to have_css "dt", text: "Areas/Systems Served"
      expect(response.body).to have_css "dd", text: "Sales Area"

      expect(response.body).to have_css "h5",
                                        text:
                                          "Note below any discrepancy between information provided by client and on site information collected, or any information of additional relevance to the cooling plant/system:"
      expect(response.body).to have_css "p", text: "Something more random"

      expect(response.body).to have_css "h4", text: "Approved sections"
      expect(response.body).to have_css "h5",
                                        text:
                                          "Is the insulation on circulation pipe work well fitted and in good order?"
      expect(response.body).to have_css "p",
                                        text: "The condenser was considered suitably located."

      expect(response.body).to have_css "dt",
                                        text: "Installed Cooling Capacity (kW)"
      expect(response.body).to have_css "dd", text: "10.0"
      expect(response.body).to have_css "dt",
                                        text: "Occupant Density (m2/person)"
      expect(response.body).to have_css "dd", text: "8.93"
      expect(response.body).to have_css "dt",
                                        text: "Total Floor Area served by this plant(m2)"
      expect(response.body).to have_css "dd", text: "357"
      expect(response.body).to have_css "dt",
                                        text: "Total Occupants served by this plant"
      expect(response.body).to have_css "dd", text: "40"
      expect(response.body).to have_css "dt",
                                        text: "Maximum Instantaneous Heat Gain (W/m2)"
      expect(response.body).to have_css "dd", text: "140.0"
      expect(response.body).to have_css "dt",
                                        text: "The Installed Size is Deemed"
      expect(response.body).to have_css "dd", text: "Less than expected"

      expect(response.body).to have_css "p",
                                        text: "Floor area was measured whilst on site."

      expect(response.body).to have_css "dt", text: "Pre Compressor(°C)"
      expect(response.body).to have_css "dd", text: "22"
      expect(response.body).to have_css "dt", text: "Post Compressor(°C)"
      expect(response.body).to have_css "dd", text: "7"
      expect(response.body).to have_css "dt", text: "Ambient(°C)"
      expect(response.body).to have_css "dd", text: "13"
      expect(response.body).to have_css "dt", text: "The Temperature is Deemed"
      expect(response.body).to have_css "dd", text: "As expected"

      expect(response.body).to have_css "h5",
                                        text: "Are there any signs of a refrigerant leak?"
      expect(response.body).to have_css "p",
                                        text:
                                          "There were no visible signs of a leak observed during the inspection."

      expect(response.body).to have_css "dt",
                                        text:
                                          "Assess the refrigeration compressor(s) and the method of refrigeration capacity control"
      expect(response.body).to have_css "dd",
                                        text: "The capacity control is inverter."

      expect(response.body).to have_css "dt", text: "Refrigerant Type"
      expect(response.body).to have_css "dd", text: "R410A"

      expect(response.body).to have_css "h5",
                                        text: "Montreal/ODS/F-Gas controlled?"
      expect(response.body).to have_css "p",
                                        text:
                                          "There were no visible signs of a leak observed during the inspection."

      expect(response.body).to have_css "p",
                                        text:
                                          "Maintenance contract advised as being in place and would appear satisfactory due to unit condition."
      expect(response.body).to have_css "p",
                                        text: "Yes system appears in good order for age."

      expect(response.body).to have_css "h5",
                                        text:
                                          "Is the refrigeration plant connected to a BEMS that can provide out of range alarms?"
      expect(response.body).to have_css "p",
                                        text: "The system is linked to a Central Controller."
      expect(response.body).to have_css "h5",
                                        text:
                                          "Are there any records of air conditioning plant usage or sub-metered energy consumption with expected hours of use per year for the plant?"
      expect(response.body).to have_css "p", text: "No details available."
      expect(response.body).to have_css "h5",
                                        text:
                                          "Is metering installed to enable monitoring of energy consumption of refrigeration plant?"
      expect(response.body).to have_css "p",
                                        text: "Recorded meter reading: 987654321"
      expect(response.body).to have_css "h5",
                                        text: "Is the energy consumption or hours of use excessive?"
      expect(response.body).to have_css "p",
                                        text:
                                          "There were no records of air conditioning plant usage or sub-metered energy consumption with expected hours of use per year for the plant or systems located on site."

      expect(response.body).to have_css "h5",
                                        text:
                                          "Is the water flow through cooling towers or evaporative coolers even and efficient, and there is no loss of water?"
      expect(response.body).to have_css "p",
                                        text: "N/A no cooling towers installed to this system"
      expect(response.body).to have_css "h5",
                                        text:
                                          "Is there a management regime in place to ensure that water is regularly checked and treated to ensure that there is no Legionella risk?"
      expect(response.body).to have_css "p",
                                        text: "N/A no cooling towers installed to this site"

      expect(response.body).to have_css "h5",
                                        text:
                                          "Is there separate equipment installed for humidity control?"
      expect(response.body).to have_css "p",
                                        text: "N/A no humidity control installed to this system"
    end
  end

  context "CEPC 6.0 AC report" do
    before do
      FetchAssessmentSummary::AssessmentStub.fetch_ac_report(
          assessment_id: "0000-0000-0000-0000-9999",
          pre_inspection_checklist: {
              pcs: {
                  essential: {
                      listOfSystems: false,
                      temperatureControlMethod: false,
                      operationControlMethod: false,
                  },
                  desirable: {
                      previousReports: false,
                      maintenanceRecords: false,
                      calibrationRecords: false,
                      consumptionRecords: false,
                  },
                  optional: {
                      coolingLoadEstimate: false, complaintRecords: false
                  },
              },
              sccs: {
                  essential: {
                      listOfSystems: true,
                      coolingCapacities: true,
                      controlZones: true,
                      temperatureControls: true,
                      operationControls: true,
                      schematics: false,
                  },
                  desirable: {
                      previousReports: true,
                      refrigerationMaintenance: false,
                      deliverySystemMaintenance: true,
                      controlSystemMaintenance: true,
                      consumptionRecords: true,
                      commissioningResults: true,
                  },
                  optional: {
                      coolingLoadEstimate: true,
                      complaintRecords: true,
                      bmsCapability: true,
                      monitoringCapability: true,
                  },
              },
          }
          )
    end

    it "can show the cooling plant section" do
      expect(response.body).to have_css "h2", text: "Pre inspection records requested"
    end
  end
end
