class Timbre < ApplicationRecord
  belongs_to :comprobante

  def cadena_original
    "||#{version}|#{uuid}|#{fecha_timbrado}|#{sello_cfd}|#{no_certificado_sat}||"
  end
end
