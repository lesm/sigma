console.log('Hello World from Webpacker')
import jQuery from 'jquery'
window.$ = jQuery
import 'adminlte'
import 'sweetalert'
import 'bootstrap'
import 'pc-bootstrap4-datetimepicker'
import 'select2'
import '../src/js/initialize_functions'
import '../src/js/notify_alert_confirm'
import '../src/js/arqueos/Dinero'
import '../src/js/cajeros/cajero'
import '../src/js/recibos/datos_concepto'
import '../src/js/recibos/recibo'

const images = require.context('../images', true)
const imagePath = (name) => images(name, true)
