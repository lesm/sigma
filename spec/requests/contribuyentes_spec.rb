require 'rails_helper'

RSpec.describe "Contribuyentes", type: :request do
  before :each do
    sign_in_cajero
  end

  describe "GET /contribuyentes" do
    it "works! (now write some real specs)" do
      get contribuyentes_path
      expect(response).to have_http_status(200)
    end
  end
end
