function asignar_nombre_cajero() {
  let nombre_o_razon_social = $("input[id$='_nombre_o_razon_social']").val()
  $("input[id$='_nombre']").val(nombre_o_razon_social)
}

$(document).on("change", "input[id$='_nombre_o_razon_social']", asignar_nombre_cajero)
