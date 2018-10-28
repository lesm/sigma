require 'rails_helper'

RSpec.describe "Cuentas", type: :request do
  describe "GET /cuentas" do
    it "works! (now write some real specs)" do
      get cuentas_path
      expect(response).to have_http_status(200)
    end
  end
end
