gulp = require 'gulp'
jade = require 'gulp-jade'
gutil  = require 'gulp-util'
sass = require 'gulp-sass'
coffee = require 'gulp-coffee'
nodemon = require 'gulp-nodemon'
app = null
sources =
	jade: "src/**/*.jade"
	coffee: "src/**/*.coffee"
	sass: "src/**/*.scss"
	overwatch: "src/**/*.{js,html,css}"




gulp.task "jade", (event) ->
	gulp.src [sources.jade],
		base:"./src"
	.pipe(jade(pretty: true))
	.pipe gulp.dest("./app")

gulp.task 'coffee', (event) ->
	gulp.src [sources.coffee],
		base:"./src"
	.pipe(coffee())
	.pipe gulp.dest("./app")

gulp.task "sass", (event) ->
	gulp.src [sources.sass],
		base:"./src"
	.pipe(sass(style: "compressed"))
	.pipe gulp.dest("./app")

gulp.task "watch", ->
	gulp.watch sources.jade, ["jade"]
	gulp.watch sources.sass, ["sass"]
	gulp.watch sources.coffee, ["coffee"]
	return

gulp.task "develop", ->
	nodemon 
		script:"app/app.js"
		ext:"html js"
		ignore:["./app/assets/**","./app/views/**"]
	.on "restart", ->
		console.log "RESTARTED!"

gulp.task "default", [
	"jade"
	"coffee"
	"sass"
	"develop"
	"watch"
]