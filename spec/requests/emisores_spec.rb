require 'rails_helper'

RSpec.describe "Emisores", type: :request do
  describe "GET /emisores" do
    it "muestra el municipio" do
      get emisores_path
      expect(response).to have_http_status(200)
    end
  end
end
