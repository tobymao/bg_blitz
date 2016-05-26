require './spec/spec_helper'

describe BGBlitz do
  let(:app) { BGBlitz.freeze.app }

  def auth_header
    user = ENV['AUTH_USER']
    pass = ENV['AUTH_PASS']
    { 'HTTP_AUTHORIZATION' => 'Basic ' + Base64::encode64("#{user}:#{pass}") }
  end

  describe 'get requests' do
    %w[/ /podcasts /videos /blog /about /contact /rss.xml].each do |path|
      it "#{path} should return 200" do
        get path
        expect(last_response).to be_ok
      end
    end
  end

  describe 'admin' do
    paths = %w[admin/items admin/posts]

    paths.each do |path|
      it "#{path} should return 200 with auth" do
        get path, {}, auth_header
        expect(last_response).to be_ok
      end
    end

    paths.each do |path|
      it "#{path} should return 401 without auth" do
        get path
        expect(last_response.status).to eq 401
      end
    end
  end

end
