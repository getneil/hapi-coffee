module.exports = (server)->
	goodOptions =
		subscribers:
			console:[
				"ops"
				"request"
				"log"
				"error"
			]
