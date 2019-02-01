require 'activerecord-import/base'
require 'activerecord-import/active_record/adapters/postgresql_adapter'
require 'csv'

namespace :import_contribuyentes do
  desc "Import contribuyentes"
  task import: :environment do
    ContribuyenteImport.new.call
    ContribuyentesCuentaImport.new.call
  end

  URL_FILE = "#{Rails.root}/lib/import_files/contribuyentes.csv"

  module ImportMethod
    def import
      CSV.foreach(URL_FILE, col_sep: ";", headers: true) do |row|
        yield row
        print "."
      end
    end
  end

  class ContribuyenteImport
    include ImportMethod

    def call
      contribuyentes = []
      import do |row|
        contribuyentes << Contribuyente.new(set_attr(row))
      end
      Contribuyente.import(contribuyentes, recursive: true)
    end

    private

    def set_attr row
      (row["tipo_contribuyente"] == "M") ? attr_moral(row) : attr_fisica(row)
    end

    def attr_fisica row
      { 
        nombre_o_razon_social: row["nombre"],
        primer_apellido: row["ape_pat"],
        segundo_apellido: row["ape_mat"],
        persona_fisica: true,
      }.merge(common_attributes(row))
    end

    def attr_moral row
      {
        nombre_o_razon_social: row["nombre_completo"],
        persona_fisica: false,
      }.merge(common_attributes(row)) 
    end

    def common_attributes row
      {
        id_import: row["id"],
        rfc: row["rfc"].blank? ? nil : row["rfc"],
        import_skip: true,
        direccion_attributes: {
          calle: row["calle"].blank? ? "Conocida" : row["calle"],
          municipio: row["municipio"].blank? ? "Tlaxiaco" : row["municipio"],
          colonia: row["colonia"].blank? ? "Conocida" : row["colonia"],
          codigo_postal: row["codigo_postal"].blank? ? "69800" : row["codigo_postal"],
          localidad: row["localidad"].blank? ? "Tlaxiaco" : row["localidad"]
        }
      }  
    end
  end

  class ContribuyentesCuentaImport
    include ImportMethod

    def call
      contribuyentes_cuentas = []
      contribuyentes_hash    = Contribuyente.pluck(:id_import, :id).to_h
      cuentas_hash           = Cuenta.pluck(:codigo, :id).to_h

      import do |row|
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
      end
      ContribuyentesCuenta.import(contribuyentes_cuentas)
    end
  end
end
