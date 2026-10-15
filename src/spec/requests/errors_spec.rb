require 'rails_helper'

RSpec.describe "Dynamic Shared Error Page", type: :request do
  let(:error_codes) do
    {
      400 => "Bad Request",
      401 => "Unauthorized",
      403 => "Access Forbidden",
      404 => "Page Not Found",
      422 => "Change Rejected",
      500 => "Internal Server Error",
      502 => "Bad Gateway",
      503 => "Service Unavailable",
      504 => "Gateway Timeout"
    }
  end

  describe "GET error routes" do
    it "renders the shared dynamic error template for each HTTP error code" do
      error_codes.each do |code, title|
        get "/#{code}"
        expect(response.status).to eq(code)
        expect(response.body).to include("Error #{code}")
        expect(response.body).to include(title)
        expect(response.body).to include("Return to Home")
      end
    end

    it "handles arbitrary valid HTTP error codes dynamically via /errors/:code" do
      get "/errors/429"
      expect(response.status).to eq(429)
      expect(response.body).to include("Error 429")
      expect(response.body).to include("Too Many Requests")
    end

    it "defaults invalid status codes to 500" do
      get "/errors/999"
      expect(response.status).to eq(500)
      expect(response.body).to include("Error 500")
      expect(response.body).to include("Internal Server Error")
    end

    it "responds with JSON when requested" do
      get "/404", headers: { "Accept" => "application/json" }
      expect(response.status).to eq(404)
      expect(response.content_type).to include("application/json")

      json = JSON.parse(response.body)
      expect(json["status"]).to eq(404)
      expect(json["error"]).to eq("Page Not Found")
      expect(json["message"]).to be_present
    end
  end

  describe "Rails exceptions_app integration" do
    let(:exceptions_app) { Rails.application.config.exceptions_app }

    it "is configured and renders dynamically for exceptions" do
      expect(exceptions_app).to respond_to(:call)

      [404, 500].each do |code|
        env = {
          "action_dispatch.status_code" => code,
          "PATH_INFO" => "/#{code}",
          "REQUEST_METHOD" => "GET",
          Rack::RACK_INPUT => StringIO.new
        }

        status, headers, body = exceptions_app.call(env)
        expect(status).to eq(code)
        expect(headers["content-type"]).to include("text/html")

        body_content = ""
        body.each { |chunk| body_content << chunk }
        expect(body_content).to include("Error #{code}")
        expect(body_content).to include(error_codes[code])
      end
    end
  end
end
