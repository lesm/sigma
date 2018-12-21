require "rails_helper"

RSpec.shared_examples "datos licencia fields required" do
  it { should validate_presence_of :fecha }
  it { should validate_presence_of :serie }
  it { should validate_presence_of :folio }
  it { should validate_presence_of :years }
end
