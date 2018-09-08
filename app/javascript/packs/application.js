console.log('Hello World from Webpacker')
import 'adminlte'

const images = require.context('../images', true)
const imagePath = (name) => images(name, true)
