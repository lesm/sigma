require "rails_helper"

RSpec.describe IngresoPorClasificaresController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/ingreso_por_clasificares").to route_to("ingreso_por_clasificares#index")
    end
  end
end
