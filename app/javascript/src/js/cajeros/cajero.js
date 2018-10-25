function asignar_nombre_cajero() {
  let text_selected = $("select#cajero_contribuyente_id option:selected").text()
  let nombre = text_selected.split("-")[0].trim()
  $("input[id$='_nombre']").val(nombre)
}

$(document).on("change", "select#cajero_contribuyente_id", asignar_nombre_cajero)
