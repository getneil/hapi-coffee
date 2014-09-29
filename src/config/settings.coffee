path = require "path"
rootPath = path.normalize __dirname+"/app"

module.exports =
	root: rootPath
	port: parseInt(process.env.PORT,10) or 3000
	hapi:
		options:
			views:
				path:"./app/views"
				engines:
					html: require "jade"