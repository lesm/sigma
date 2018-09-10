console.log('Hello World from Webpacker')
import Rails from 'rails-ujs'
import Turbolinks from 'turbolinks'
import 'adminlte'

Rails.start()
Turbolinks.start()

const images = require.context('../images', true)
const imagePath = (name) => images(name, true)
