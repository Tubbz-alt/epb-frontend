# frozen_string_literal: true

describe 'Acceptance::Certificate' do
  include RSpecFrontendServiceMixin

  context 'when the assessment exists' do
    before { FetchCertificate::Stub.fetch('123-456') }

    let(:response) { get '/energy-performance-certificate/123-456' }

    it 'returns status 200' do
      expect(response.status).to eq(200)
    end

    it 'shows the EPC title' do
      expect(response.body).to include('Energy Performance Certificate')
    end

    it 'shows the address summary' do
      expect(response.body).to include('2 Marsham Street')
      expect(response.body).to include('London')
      expect(response.body).to include('SW1B 2BB')
    end

    it 'shows the certificate number' do
      expect(response.body).to include('123-456')
    end

    it 'shows the date of assessment' do
      expect(response.body).to include('05 January 2020')
    end

    it 'shows the registered date of the certificate' do
      expect(response.body).to include('02 January 2020')
    end

    it 'shows the date of expiry' do
      expect(response.body).to include('05 01 2030')
    end

    it 'shows the type of assessment' do
      expect(response.body).to include('RdSAP')
    end

    it 'shows the total floor area' do
      expect(response.body).to include('150')
    end

    it 'shows the type of dwelling' do
      expect(response.body).to include('Top floor flat')
    end

    it 'shows the SVG with energy ratings' do
      expect(response.body).to include('<svg width="615" height="400"')
    end

    it 'shows the assessors full name' do
      expect(response.body).to include('Test Boi')
    end

    it 'shows the assessors accreditation scheme' do
      expect(response.body).to include('Quidos')
    end

    it 'shows the assessors accreditation number' do
      expect(response.body).to include('TESTASSESSOR')
    end

    it 'shows the assessors telephone number' do
      expect(response.body).to include('12345678901')
    end

    it 'shows the assessors email address' do
      expect(response.body).to include('test.boi@quidos.com')
    end

    it 'does not shows the warning to landlords that it cannot be rented out' do
      expect(response.body).to_not include('You may not be able to let this property')
    end

    context 'and rating is poor (f)' do
      before { FetchCertificate::Stub.fetch('123-654', '25', 'f') }

      let(:response) { get '/energy-performance-certificate/123-654' }
      it 'shows a warning text' do
        expect(response.body).to include('You may not be able to let this property')
      end
    end
  end

  context 'when the assessment doesnt exist' do
    before { FetchCertificate::NoAssessmentStub.fetch('123-456') }

    let(:response) { get '/energy-performance-certificate/123-456' }

    it 'returns status 404' do
      expect(response.status).to eq(404)
    end

    it 'shows the error page' do
      expect(response.body).to include(
        '<h1 class="govuk-heading-xl">Page not found</h1>'
      )
    end
  end
end
