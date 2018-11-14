function actualizarImporte() {
  let importe = 0.0

  $("input[id$='_cantidad']").each(function() {
    let cantidad = parseInt($(this).val())
    let row = $(this).closest(".row")
    let valor_unitario = parseInt(row.find("input[id$='_valor_unitario']").val())

    if (!isNaN(cantidad) && !isNaN(valor_unitario)) {
      resultado = cantidad * valor_unitario
      row.find("input[id$='_importe']").val(resultado)
    }
  })
  actualizarTotal()
}

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
  actualizarImporte()
}

$(document).on("click", "#eliminarConcepto", eliminarConcepto)
$(document).on("change", "input[id$='_valor_unitario']", actualizarImporte)
$(document).on("change", "input[id$='_cantidad']", actualizarImporte)
