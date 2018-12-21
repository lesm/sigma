require "rails_helper"

RSpec.describe ReportesController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/reportes/new").to route_to("reportes#new")
    end

    it "routes to #cajero" do
      expect(post: "/reportes/cajero").to route_to("reportes#cajero")
    end

    it "routes to #cuenta" do
      expect(post: "/reportes/cuenta").to route_to("reportes#cuenta")
    end

    it "routes to #cuenta" do
      expect(post: "/reportes/cuentas").to route_to("reportes#cuentas")
    end
  end
end
