function actualizar_total() {
  let suma = 0.0

  $("input[id$='_importe']").each(function() {
    if (!isNaN(parseInt($(this).val()))) {
      suma += parseInt($(this).val())
    }
  })

  $("input[id$='_subtotal']").val(suma)
  $("input[id$='_total']").val(suma)
}

$(document).on("change", "input[id$='_importe']", actualizar_total)
