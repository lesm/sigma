json.extract! contribuyente, :id, :nombre, :primer_apellido, :segundo_apellido, :persona_fisica, :email, :rfc, :created_at, :updated_at
json.url contribuyente_url(contribuyente, format: :json)
