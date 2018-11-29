import Rails from 'rails-ujs'
import Turbolinks from 'turbolinks'

const handleConfirm = function(element) {
  if (!allowAction(this)) {
    Rails.stopEverything(element)
  }
}

const allowAction = element => {
  if (element.getAttribute('data-confirm-swal') === null) {
    return true
  }

  showConfirmationDialog(element)
  return false
}

const castValue = value => {
  let booleanValues = {
    "true": true,
    "false": false
  }
  return booleanValues[value]
}

const showConfirmationDialog = element => {
  const message           = element.getAttribute('data-confirm-swal')
  const text              = element.getAttribute('data-text')
  const conCaja           = castValue(element.getAttribute('data-con-caja'))
  const sinArqueo         = castValue(element.getAttribute('data-sin-arqueo'))
  const arqueoPendiente   = castValue(element.getAttribute('data-arqueo-pendiente'))
  const cierreCajaAbierta = castValue(element.getAttribute('data-cierre-caja-abierta'))
  const cierreCajaId      = element.getAttribute('data-cierre-caja-id')

  let link = document.createElement("a")
  let title = ""
  if (sinArqueo && conCaja) {
    link.innerHTML = "Ír a crear Arqueo"
    link.href = "/arqueos/new"
    swal({
      title: "Debes crear un arqueo",
      icon: 'warning',
      content: link,
      buttons: [false, "Ok"],
    })
  } else {
    if (arqueoPendiente || cierreCajaAbierta) {
      if(arqueoPendiente) {
        title = "Tienes un arqueo pendiente"
        link.innerHTML = "Ír a crear Arqueo"
        link.href = "/arqueos/new"
      } else {
        if (cierreCajaAbierta) {
          title = "Cierre de caja abierta"
          link.innerHTML = "Ír a cierre de caja"
          link.href = `/cierre_cajas/${cierreCajaId}`
        }
      }
      swal({
        title: title,
        icon: 'warning',
        content: link,
        buttons: ["No", "Cerrar Sesión"],
      }).then(result => {
        if (result) {
          element.href = `${element.href}?quitar_referencia=false`
          confirmed(element, result)
        }
      })
    } else {
      swal({
        title: '¿Estas seguro?',
        text: message,
        icon: 'warning',
        buttons: ["No", "Sí"],
      }).then(result => {
         if (result) {
           element.href = `${element.href}?quitar_referencia=true`
         }
        confirmed(element, result)
      })
    }
  }
}

const confirmed = (element, result) => {
  if (result) {
    // User clicked confirm button
    element.removeAttribute('data-confirm-swal')
    element.click()
  }
}

Rails.delegate(document, 'a[data-confirm-swal]', 'click', handleConfirm)

Rails.start()
Turbolinks.start()
