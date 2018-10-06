function setCuentasIds(){
  let cuenta_ids = $("select#cuenta_ids").data("cuenta-ids")
  let cuentasSelect = $("select#cuenta_ids option")
  $(".select2-multiple").val(null).trigger('change')
  if(cuenta_ids && cuenta_ids.length){
    Object.entries(cuentasSelect).forEach(function([key, obj]){
      if (cuenta_ids.includes(obj.value))
        cuentasSelect[key].selected = true
    })
    cuentasSelect.trigger("change")
  }
}

$(document).on("turbolinks:load", setCuentasIds)
