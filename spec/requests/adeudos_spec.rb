require 'rails_helper'

RSpec.describe "Adeudos", type: :request do
  describe "GET /adeudos" do
    before :each do
      sign_in_cajero
    end
    it "works! (now write some real specs)" do
      get adeudos_path
      expect(response).to have_http_status(200)
    end
  end
end
