class Comprobante
  class CreaTimbreDesdeRespuestaFm < TareaProcesoTimbrado

    def crear
      Timbre.create(attributes_timbre)
      comprobante.timbre.present?
    end

    private

    def attributes_timbre
      {
        version: timbre_fm.version,
        no_certificado_sat: timbre_fm.no_certificado_sat,
        no_certificado: timbre_fm.no_certificado,
        fecha_timbrado: timbre_fm.fecha_timbrado,
        uuid: timbre_fm.uuid,
        sello_sat: timbre_fm.sello_sat,
        sello_cfd: timbre_fm.sello_cfd,
        fecha_comprobante: timbre_fm.fecha_comprobante,
        serie: timbre_fm.serie,
        rfc_provedor_certificacion: timbre_fm.rfc_provedor_certificacion,
        folio: timbre_fm.folio,
        comprobante_id: comprobante.id
      }
    end

    def timbre_fm
      respuesta_fm.timbre
    end
  end
end
