require "rails_helper"

RSpec.describe AdministradoresController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/administradores/new").to route_to("administradores#new")
    end

    it "routes to #edit" do
      expect(get: "/administradores/1/edit").to route_to("administradores#edit", id: "1")
    end

    it "routes to #show" do
      expect(get: "/administradores/1").to route_to("administradores#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/administradores").to route_to("administradores#create")
    end

    it "routes to #update" do
      expect(put: "/administradores/1").to route_to("administradores#update", id: "1")
    end
  end
end
