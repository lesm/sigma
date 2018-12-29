function actualizarImporte() {
  let importe = 0.0

  $("input[id$='_cantidad']").each(function() {
    let cantidad = parseFloat($(this).val())
    let row = $(this).closest(".row")
    let valor_unitario = parseFloat(row.find("input[id$='_valor_unitario']").val())

    if (!isNaN(cantidad) && !isNaN(valor_unitario)) {
      resultado = redondearImporte(cantidad * valor_unitario)
      row.find("input[id$='_importe']").val(resultado)
    }
  })
  actualizarTotal()
}

function redondearImporte(importe) {
  let parteDecimal = (importe+"").split(".")[1]

  if (parteDecimal == undefined || parteDecimal == "50") {
    return importe
  }

  parteDecimal = parseInt(parteDecimal)

  if(parteDecimal <= 49) {
    return redondear(importe, parteDecimal)
  } else if (parteDecimal >= 51){
    return redondear(importe, (parteDecimal - 50))
  }
}

function redondear(importe, parteDecimal){
  if(unoANueveCentavos(parteDecimal)){
    return (importe - parseFloat(".0"+parteDecimal))
  } else {
    return (importe - parseFloat("."+parteDecimal))
  }
}

function unoANueveCentavos(centavos) {
  return (centavos <= 9)
}

function actualizarTotal() {
  let suma = 0.0

  $("input[id$='_importe']").each(function() {
    if (!isNaN(parseFloat($(this).val()))) {
      suma += parseFloat($(this).val())
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
$(document).on("turbolinks:load", actualizarImporte)
