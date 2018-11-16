class Dinero {

  diez_centavos() {
    let cantidad = parseInt($("input[id$='_diez_centavos']").val())
    if (isNaN(cantidad)) return 0
    return parseFloat((cantidad * 0.1).toFixed(2))
  }

  veinte_centavos() {
    let cantidad = parseInt($("input[id$='_veinte_centavos']").val())
    if (isNaN(cantidad)) return 0
    return parseFloat((cantidad * 0.2).toFixed(2))
  }

  cincuenta_centavos() {
    let cantidad = parseInt($("input[id$='_cincuenta_centavos']").val())
    if (isNaN(cantidad)) return 0
    return parseFloat((cantidad * 0.5).toFixed(2))
  }

  un_peso() {
    let cantidad = parseInt($("input[id$='_un_peso']").val())
    if (isNaN(cantidad)) return 0
    return parseFloat((cantidad * 1).toFixed(2))
  }

  dos_pesos() {
    let cantidad = parseInt($("input[id$='_dos_pesos']").val())
    if (isNaN(cantidad)) return 0
    return parseFloat((cantidad * 2).toFixed(2))
  }

  cinco_pesos() {
    let cantidad = parseInt($("input[id$='_cinco_pesos']").val())
    if (isNaN(cantidad)) return 0
    return parseFloat((cantidad * 5).toFixed(2))
  }

  diez_pesos() {
    let cantidad = parseInt($("input[id$='_diez_pesos']").val())
    if (isNaN(cantidad)) return 0
    return parseFloat((cantidad * 10).toFixed(2))
  }

  veinte_pesos() {
    let cantidad = parseInt($("input[id$='_veinte_pesos']").val())
    if (isNaN(cantidad)) return 0
    return parseFloat((cantidad * 20).toFixed(2))
  }

  veinte_m_pesos() {
    let cantidad = parseInt($("input[id$='_veinte_m_pesos']").val())
    if (isNaN(cantidad)) return 0
    return parseFloat((cantidad * 20).toFixed(2))
  }

  cincuenta_pesos() {
    let cantidad = parseInt($("input[id$='_cincuenta_pesos']").val())
    if (isNaN(cantidad)) return 0
    return parseFloat((cantidad * 50).toFixed(2))
  }

  cien_pesos() {
    let cantidad = parseInt($("input[id$='_cien_pesos']").val())
    if (isNaN(cantidad)) return 0
    return parseFloat((cantidad * 100).toFixed(2))
  }

  doscientos_pesos() {
    let cantidad = parseInt($("input[id$='_doscientos_pesos']").val())
    if (isNaN(cantidad)) return 0
    return parseFloat((cantidad * 200).toFixed(2))
  }

  quinientos_pesos() {
    let cantidad = parseInt($("input[id$='_quinientos_pesos']").val())
    if (isNaN(cantidad)) return 0
    return parseFloat((cantidad * 500).toFixed(2))
  }

  mil_pesos() {
    let cantidad = parseInt($("input[id$='attributes_mil_pesos']").val())
    if (isNaN(cantidad)) return 0
    return parseFloat((cantidad * 1000).toFixed(2))
  }

  dos_mil_pesos() {
    let cantidad = parseInt($("input[id$='_dos_mil_pesos']").val())
    if (isNaN(cantidad)) return 0
    return parseFloat((cantidad * 2000).toFixed(2))
  }

  monto_sistema() {
    return parseFloat($("input[id$='_monto_sistema']").val())
  }

  monto_banco() {
    return parseFloat($("#monto_banco").val())
  }

  suma() {
    return this.diez_centavos() + this.veinte_centavos() + this.cincuenta_centavos() +
      this.un_peso() + this.dos_pesos() + this.cinco_pesos() + this.diez_pesos() +
      this.veinte_pesos() + this.cincuenta_pesos() + this.cien_pesos() +
      this.doscientos_pesos() + this.quinientos_pesos() + this.mil_pesos() +
      this.veinte_m_pesos() + this.dos_mil_pesos() + this.monto_banco()
  }

  suma_sin_monto_banco() {
    return this.suma() - this.monto_banco()
  }

  suma_currency() {
    return this.currency(this.suma())
  }

  suma_sin_monto_banco_currency() {
    return this.currency(this.suma_sin_monto_banco())
  }

  currency(amount) {
    let formatter = new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
      minimumFractionDigits: 2,
    })

    return formatter.format(amount)
  }

  diferencia_monto() {
    return (this.monto_sistema() - this.suma())
  }

  diferencia_monto_currency() {
    return this.currency(Math.abs(this.monto_sistema() - this.suma()))
  }
}

function diferenciaMonto(dinero) {
  $("#diferencia_monto").html(dinero.diferencia_monto_currency())
  if (dinero.diferencia_monto() > 0) {
    update_text_label("Adeudo por pagar", "badge-success", "badge-danger")
  } else if (dinero.diferencia_monto() < 0) {
    update_text_label("Ingreso por clasificar", "badge-success", "badge-danger")
  } else if (dinero.diferencia_monto() == 0){
    update_text_label("Monto correcto", "badge-danger", "badge-success")
  }
}

function update_text_label(text, badge_remove, badge_add) {
  $("#diferencia_monto").closest("span")
    .removeClass(badge_remove)
    .addClass(badge_add)
    .closest("h4")
    .prev("label")
    .html(text)
}

function calculateAmount() {
  let dinero = new Dinero()
  diferenciaMonto(dinero)

  actualiza_monto_efectivo(dinero)
  actualiza_monto_total(dinero)
  actualiza_total_dinero(dinero)
}

function actualiza_monto_total(dinero) {
  $("#monto_total_span").html(dinero.suma_currency())
}

function actualiza_total_dinero(dinero) {
  $("input[id$='_total']").val(dinero.suma())
}

function actualiza_monto_efectivo(dinero) {
  $("input[id$='_cajero']").val(dinero.suma_sin_monto_banco())
  $("#monto_cajero_span").html(dinero.suma_sin_monto_banco_currency())
}

$(document).on("change", ".dinero", calculateAmount)
$(document).on("turbolinks:load", calculateAmount)
