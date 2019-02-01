require 'activerecord-import/base'
require 'activerecord-import/active_record/adapters/postgresql_adapter'
require 'csv'

namespace :import_contribuyentes do
  desc "Import contribuyentes"
  task import: :environment do
    ContribuyenteImport.call
    ContribuyentesCuentaImport.call
  end

  URL_FILE = "#{Rails.root}/lib/import_files/contribuyentes_morales.csv"

  class ContribuyenteImport
    def self.call
      contribuyentes = []
      CSV.foreach(URL_FILE, col_sep: ";", headers: true) do |row|
        contribuyente = Contribuyente.new(
          id_import: row["id"],
          nombre_o_razon_social: row["nombre_completo"],
          persona_fisica: false, rfc: row["rfc"].blank? ? nil : row["rfc"],
          import_skip: true,
          direccion_attributes: {
            calle: row["calle"].blank? ? "Conocida" : row["calle"],
            municipio: row["municipio"].blank? ? "Tlaxiaco" : row["municipio"],
            colonia: row["colonia"].blank? ? "Conocida" : row["colonia"],
            codigo_postal: row["codigo_postal"].blank? ? "69800" : row["codigo_postal"],
            localidad: row["localidad"].blank? ? "Tlaxiaco" : row["localidad"]
          }
        )
        print "."
        contribuyentes << contribuyente
      end
      Contribuyente.import(contribuyentes, recursive: true)
    end
  end

  class ContribuyentesCuentaImport
    def self.call
      contribuyentes_cuentas = []
      contribuyentes_hash = Contribuyente.pluck(:id_import, :id).to_h
      cuentas_hash        = Cuenta.pluck(:codigo, :id).to_h

      CSV.foreach(URL_FILE, col_sep: ";", headers: true) do |row|
        contribuyente_id = contribuyentes_hash[row["id"].to_i]
        row["codigos"].split(",").each do |codigo|
          cuenta_id = cuentas_hash[codigo]
          if contribuyente_id and cuenta_id
            contribuyentes_cuentas << ContribuyentesCuenta.new(
                                        contribuyente_id: contribuyente_id,
                                        cuenta_id: cuenta_id
                                      )
          end
        end
        print "."
      end
      ContribuyentesCuenta.import(contribuyentes_cuentas)
    end
  end
end
