require "rails_helper"

RSpec.describe ReciboStepsController, type: :routing do
  describe "routing" do
    it "routes to #show step :set_cuenta" do
      expect(get: "/recibo_steps/set_cuenta").to route_to("recibo_steps#show", id: "set_cuenta")
    end

    it "routes to #show step :set_conceptos" do
      expect(get: "/recibo_steps/set_conceptos").to route_to("recibo_steps#show", id: "set_conceptos")
    end

    it "routes to #asignar_cuentas step :set_cuenta" do
      expect(get: "/recibo_steps/asignar_cuentas").to route_to("recibo_steps#asignar_cuentas")
    end
  end
end
