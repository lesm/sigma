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

  suma() {
    return this.diez_centavos() + this.veinte_centavos() + this.cincuenta_centavos() +
      this.un_peso() + this.dos_pesos() + this.cinco_pesos() + this.diez_pesos() +
      this.veinte_pesos() + this.cincuenta_pesos() + this.cien_pesos() +
      this.doscientos_pesos() + this.quinientos_pesos() + this.mil_pesos() +
      this.veinte_m_pesos() + this.dos_mil_pesos()
  }

  suma_vista() {
    return this.currency(this.suma())
  }

  currency(amount) {
    let formatter = new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
      minimumFractionDigits: 2,
    })

    return formatter.format(amount)
  }
}

function calculateAmount() {
  let dinero = new Dinero()
  $("#suma_monto").html(dinero.suma_vista())
  $("input[id$='_total']").val(dinero.suma())
  $("input[id$='_cajero']").val(dinero.suma())
}

$(document).on("change", ".dinero", calculateAmount)
