console.log('Hello World from Webpacker')
import jQuery from 'jquery'
window.$ = jQuery
import 'adminlte'
import 'sweetalert'
import 'bootstrap'
import 'pc-bootstrap4-datetimepicker'
import 'select2'
import '../src/js/sigma'

const images = require.context('../images', true)
const imagePath = (name) => images(name, true)
