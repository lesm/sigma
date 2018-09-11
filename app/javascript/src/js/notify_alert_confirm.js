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

const showConfirmationDialog = element => {
  const message = element.getAttribute('data-confirm-swal')
  const text = element.getAttribute('data-text')

  swal({
    title: '¿Estas seguro?',
    text: message,
    icon: 'warning',
    buttons: ["No", "Sí"],
  }).then(result => confirmed(element, result))
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
