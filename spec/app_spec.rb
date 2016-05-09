require './spec/spec_helper'

describe App do
  let(:app) { App.freeze.app }

  describe 'get requests' do
    %w[/ /podcasts /videos /blog].each do |path|
      it 'should return 200' do
        get path
        expect(last_response).to be_ok
      end
    end
  end

end
