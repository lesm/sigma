require "rails_helper"

RSpec.describe CierreCajasController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/cierre_cajas").to route_to("cierre_cajas#index")
    end

    it "routes to #show" do
      expect(:get => "/cierre_cajas/1").to route_to("cierre_cajas#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cierre_cajas").to route_to("cierre_cajas#create")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cierre_cajas/1").to route_to("cierre_cajas#update", :id => "1")
    end

    it "routes to #cerrar via POST" do
      expect(:post => "cierre_cajas/1/cerrar").to route_to("cierre_cajas#cerrar", :id => "1")
    end

  end
end
