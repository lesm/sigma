class GenerarPdf < ApplicationController
  include WickedPdf::PdfHelper

  def generar(comprobante)
    crear_pdf(comprobante)
  end

  private

  def crear_pdf(comprobante)
    @recibo = comprobante
    WickedPdf.new.pdf_from_string(
      render_to_string("pdfs/comprobantes/recibo.pdf.haml", layout: 'pdfs/pdf.pdf.haml'),
      page_size: "Letter",
      viewport_size: "1280x1024",
      margin: { top: "65", bottom: "90" },
      header: {
        content: render_to_string(
          'pdfs/comprobantes/header.pdf.haml',
          layout: 'pdfs/pdf.pdf.haml'
        )
      },
      footer: {
        content: render_to_string(
          'pdfs/comprobantes/footer.pdf.haml',
          layout: 'pdfs/pdf.pdf.haml'
        )
      }
    )
  end
end
