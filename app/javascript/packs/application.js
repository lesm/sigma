console.log('Hello World from Webpacker')
import 'adminlte'
import 'sweetalert'
import 'bootstrap'
import '../src/js/notify_alert_confirm'

const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

function resizeContentWrapperHeight(){
  $(document).trigger("resize");
}

$(document).on("turbolinks:load", resizeContentWrapperHeight)
