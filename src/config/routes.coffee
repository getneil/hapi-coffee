directory = require 'require-directory'
controller = directory module, '../controllers'
module.exports = [
  {
    method: 'GET'
    path: '/'
    config: controller.index.index
  }
  {
    method: 'GET'
    path: '/css/{path*}'
    config: controller.assets.css
  }
]
