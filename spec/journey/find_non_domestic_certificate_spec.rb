# frozen_string_literal: true

describe "Journey::FindNonDomesticCertificate", type: :feature, journey: true do
  before(:all) do
    process =
      IO.popen(
        [
          "rackup",
          "config_test.ru",
          "-q",
          "-o",
          "127.0.0.1",
          "-p",
          "9393",
          err: %i[child out],
        ],
      )
    @process_id = process.pid

    unless process.readline.include?("port=9393")
    end
  end

  after(:all) { Process.kill("KILL", @process_id) }

  it "finds a certificate by postcode" do
    visit "http://find-energy-certificate.local.gov.uk:9393"
    click_on "Start now"
    find("#label-non-domestic").click
    click_on "Continue"
    fill_in "postcode", with: "SW1A 2AA"
    click_button "Find"
    expect(page).to have_content "2 certificates and reports for SW1A 2AA"
  end

  describe "viewing in Welsh" do
    it "finds a certificate by postcode" do
      visit "http://find-energy-certificate.local.gov.uk:9393"
      click_on "Welsh (Cymraeg)"
      click_on "Dechreuwch nawr"
      find("#label-non-domestic").click
      click_on "Parhau"
      fill_in "postcode", with: "SW1A 2AA"
      click_button "Chwiliwch"
      expect(
        page,
      ).to have_content "2 o dystysgrifau ac adroddiadau ar gyfer SW1A 2AA"
    end
  end

  it "displays an error message when entering an empty postcode" do
    visit "http://find-energy-certificate.local.gov.uk:9393"
    click_on "Start now"
    find("#label-non-domestic").click
    click_on "Continue"
    fill_in "postcode", with: ""
    click_on("Find")
    expect(page).to have_content "Enter a real postcode"
  end

  it "displays an error message when entering an invalid postcode" do
    visit "http://find-energy-certificate.local.gov.uk:9393"
    click_on "Start now"
    find("#label-non-domestic").click
    click_on "Continue"
    fill_in "postcode", with: "NOT A POSTCODE"
    click_on "Find"
    expect(page).to have_content "Enter a real postcode"
  end

  it "displays the find a certificate page heading when entering a valid postcode" do
    visit "http://find-energy-certificate.local.gov.uk:9393"
    click_on "Start now"
    find("#label-non-domestic").click
    click_on "Continue"
    fill_in "postcode", with: "SW1A 2AA"
    click_on "Find"
    expect(page).to have_content "2 certificates and reports for"
  end
end
