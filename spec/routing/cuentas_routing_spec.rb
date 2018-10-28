require "rails_helper"

RSpec.describe CuentasController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/cuentas").to route_to("cuentas#index")
    end

    it "routes to #new" do
      expect(:get => "/cuentas/new").to route_to("cuentas#new")
    end

    it "routes to #show" do
      expect(:get => "/cuentas/1").to route_to("cuentas#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cuentas/1/edit").to route_to("cuentas#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/cuentas").to route_to("cuentas#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cuentas/1").to route_to("cuentas#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cuentas/1").to route_to("cuentas#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cuentas/1").to route_to("cuentas#destroy", :id => "1")
    end
  end
end
