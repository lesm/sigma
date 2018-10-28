function asignar_formato() {
  let codigo = $(this).val()
  let formato = $(this).data("formato")[codigo]

  $("input[id$='_formato']").val(formato)
}

$(document).on("change", "select[id$='_codigo']", asignar_formato)
