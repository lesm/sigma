require "rails_helper"

RSpec.describe CierreCajasController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/cierre_cajas").to route_to("cierre_cajas#index")
    end

    it "routes to #new" do
      expect(:get => "/cierre_cajas/new").to route_to("cierre_cajas#new")
    end

    it "routes to #show" do
      expect(:get => "/cierre_cajas/1").to route_to("cierre_cajas#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cierre_cajas").to route_to("cierre_cajas#create")
    end
  end
end
