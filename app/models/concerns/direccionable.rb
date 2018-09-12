require 'active_support/concern'

module Direccionable
  extend ActiveSupport::Concern

  included do
    has_one :direccion, as: :direccionable, dependent: :destroy
    accepts_nested_attributes_for :direccion, allow_destroy: true
  end
end
