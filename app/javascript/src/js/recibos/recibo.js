function actualizarImporte() {
  $("input[id$='_cantidad']").each(function() {
    let cantidad       = parseInt($(this).val())
    let row            = $(this).closest(".row")
    let valor_unitario = convertirAFloat(row.find("input[id$='_valor_unitario']").val())

    if (existe(cantidad) && existe(valor_unitario)) {
      row.find("input[id$='_valor_unitario']").val(valor_unitario.toFixed(1))
      importe = convertirAFloat((cantidad * valor_unitario)).toFixed(1)
      row.find("input[id$='_importe']").val(importe)
    }
  })
  actualizarTotal()
}

function actualizarTotal() {
  let suma = 0.0

  $("input[id$='_importe']").each(function() {
    let importe = $(this).val()
    if (existe(convertirAFloat(importe))) {
      suma += convertirAFloat(importe)
    }
  })

  $("input[id$='_subtotal']").val(suma.toFixed(1))
  $("input[id$='_total']").val(suma.toFixed(1))
}

function eliminarConcepto() {
  $(this).closest(".row.concepto").remove()
  actualizarImporte()
}

function existe(valor) {
  return !isNaN(valor)
}

function convertirAFloat(valor) {
  return parseFloat(valor)
}

$(document).on("click", "#eliminarConcepto", eliminarConcepto)
$(document).on("change", "input[id$='_valor_unitario']", actualizarImporte)
$(document).on("change", "input[id$='_cantidad']", actualizarImporte)
$(document).on("turbolinks:load", actualizarImporte)
