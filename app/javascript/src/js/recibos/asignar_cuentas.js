$(document).on("select2:close", "#cuenta_form_contribuyente_id", function (e) {
  if ($('option:selected', this).text().length) {
    $.ajax("/recibo_steps/asignar_cuentas", {
      type: "GET",
      dataType: "script",
      data: {
        contribuyente_id: $(this).val()
      },
      error: function(jqXHR, textStatus, errorThrown) {
        console.log("Ajax error #{textStatus}")
      },
      success: function(data, textStatus, jqXHR) {
        console.log("Is working ...")
      }
    })
  }
})
