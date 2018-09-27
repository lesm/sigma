console.log('Hello World from Webpacker')
import jQuery from 'jquery'
window.$ = jQuery
import 'adminlte'
import 'sweetalert'
import 'bootstrap'
import 'select2'
import '../src/js/notify_alert_confirm'
import '../src/js/arqueos/Dinero'
import '../src/js/cajeros/cajero'

const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

function ready() {
  resizeContentWrapperHeight()
  startSelect2()
}

function resizeContentWrapperHeight() {
  $(document).trigger("resize");
}

function startSelect2() {
  $(".select2").select2({
    width: '100%'
  })
}

$(document).on("turbolinks:load", ready)
