require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ContribuyentesHelper. For example:
#
# describe ContribuyentesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ContribuyentesHelper, type: :helper do
   describe ContribuyentesHelper do
     describe "#estados_para_select" do
       it "debe ser de 32 elementos" do
         expect(helper.estados_para_select.size).to eq 32
       end
     end
   end
end
