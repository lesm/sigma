require 'rails_helper'

RSpec.describe "Recibos", type: :request do
  before :each do
    sign_in_cajero
  end

  describe "GET /recibos" do
    it "works! (now write some real specs)" do
      get recibos_path
      expect(response).to have_http_status(200)
    end
  end
end
