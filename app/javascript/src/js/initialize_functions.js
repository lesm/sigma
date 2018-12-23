function ready() {
  resizeContentWrapperHeight()
  startSelect2()
  startSelect2Multiple()
  startDateTimePicker()
  startSelect2WithLink()
  hideSelect2WithLink()
  startFocusSearch()
}

function startFocusSearch() {
  $("#search").focus()
  $("#search").select()
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

  $(".select2-multiple.with-link").select2({
    width: '100%',
    escapeMarkup: function (markup) { return markup; },
    language: {
      noResults() {
        return `<button type='button' id='btnCerrarSelect2' data-toggle='modal' data-target='#cuenta_nueva' class='btn btn-sm btn-primary'>
                  Relacionar cuenta
                </button>`
      }
    }
  })
}

function startSelect2WithLink() {
  $(".select2.with-link").select2({
    width: '100%',
    escapeMarkup: function (markup) { return markup; },
    language: {
      noResults() {
        return `<button type='button' id='btnCerrarSelect2' data-toggle='modal' data-target='#contribuyente_nuevo' class='btn btn-sm btn-primary'>
                  Agregar contribuyente
                </button>`
      }
    }
  })
}

function hideSelect2WithLink() {
  $(document).on("click", "#btnCerrarSelect2", function() {
    $(".with-link").select2("close")
    startSelect2Multiple()
    asignarCuentasSeleccionadas()
  })
}

function asignarCuentasSeleccionadas() {
  $("#cuentas_seleccionadas").val($("#cuenta_ids").val())
}

function startDateTimePicker() {
  $(".fecha").datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD HH:mm a'
  })

  $(".fecha-reporte").datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD'
  })

  $("input[id$='fecha_emision']").datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD HH:mm a'
  })

  $("input[id$='_fecha'].fecha-comun").datetimepicker({
    locale: 'es',
    format: 'YYYY-MM-DD'
  })

  $("input[id$='_fecha'].fecha-predial").datetimepicker({
    locale: 'es',
    format: "YYYY",
    viewMode: 'years',
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
