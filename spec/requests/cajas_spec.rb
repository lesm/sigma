require 'rails_helper'

RSpec.describe "Cajas", type: :request do
  before :each do
    sign_in_cajero
  end

  describe "GET /cajas" do
    it "works! (now write some real specs)" do
      get cajas_path
      expect(response).to have_http_status(200)
    end
  end
end
