function ready() {
  resizeContentWrapperHeight()
  startSelect2()
  startSelect2Multiple()
  startDateTimePicker()
}

function resizeContentWrapperHeight() {
  $(document).trigger("resize");
}

function startSelect2() {
  $(".select2").select2({
    width: '100%'
  })
}

function startSelect2Multiple() {
  $(".select2-multiple").select2({
    width: '100%',
    multiple: true,
    text: "Selecciona al menos cuenta"
  })
}

function startDateTimePicker() {
  $("input[id$='fecha_emision']").datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD HH:mm a'
  })

  $("input[id$='_fecha']").datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD'
  })

  // DatosAgua
  $("input[id$='_fecha_corte']").datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD'
  })

  $("input[id$='_mes_pago']").datetimepicker({
    locale: 'es',
    format: 'YYYY-MM'
  })

  // Datos licencia comercial
  $("input[id$='_fecha_refrendo']").datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD'
  })
}

$(document).on("turbolinks:load", ready)
