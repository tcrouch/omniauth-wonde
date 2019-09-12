# frozen_string_literal: true

RSpec.describe OmniAuth::Strategies::Wonde do
  subject do
    described_class
      .new(app, "appid", "secret", options)
      .tap do |strategy|
        allow(strategy).to receive(:request) { request }
      end
  end
  let(:request) do
    double "Request",
      params: {},
      cookies: {},
      env: {},
      scheme: "https",
      url: "example.com"
  end
  let(:app) { -> { [200, {}, ["Hello World"]] } }
  let(:options) { {} }

  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end

  it "ignores state" do
    expect(subject.options.provider_ignores_state)
      .to eq(true)
  end

  describe "#client_options" do
    it "has correct site" do
      expect(subject.client.site)
        .to eq("https://edu.wonde.com")
    end

    it "has correct authorize_url" do
      expect(subject.client.authorize_url)
        .to eq("https://edu.wonde.com/oauth/authorize")
    end

    it "has correct token_url" do
      expect(subject.client.token_url)
        .to eq("https://api.wonde.com/oauth/token")
    end
  end

  describe "#callback_url" do
    context "with redirect_uri option" do
      let(:options) { { redirect_uri: "https://example.com" } }

      it "returns redirect_uri" do
        expect(subject.callback_url)
          .to eq("https://example.com")
      end
    end
  end

  describe "#authorize_options" do
    describe "redirect_uri" do
      context "when not given" do
        let(:options) { {} }

        it "defaults to nil" do
          expect(subject.authorize_params.redirect_uri)
            .to eq(nil)
        end
      end

      context "when given" do
        let(:options) { { redirect_uri: "https://example.com" } }

        it "sets the redirect_uri" do
          expect(subject.authorize_params.redirect_uri)
            .to eq("https://example.com")
        end
      end
    end
  end
end
