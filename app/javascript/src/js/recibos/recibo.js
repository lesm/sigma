function actualizarTotal() {
  let suma = 0.0

  $("input[id$='_importe']").each(function() {
    if (!isNaN(parseInt($(this).val()))) {
      suma += parseInt($(this).val())
    }
  })

  $("input[id$='_subtotal']").val(suma)
  $("input[id$='_total']").val(suma)
}

function eliminarConcepto() {
  $(this).closest(".row.concepto").remove()
  actualizarTotal()
}

$(document).on("click", "#eliminarConcepto", eliminarConcepto)
$(document).on("change", "input[id$='_importe']", actualizarTotal)
