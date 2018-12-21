class DatosConcepto < ApplicationRecord
  belongs_to :concepto

  before_save :remove_blanks_from_years

  private

  def remove_blanks_from_years
    self.years = years.reject(&:blank?)
  end
end
