gulp = require 'gulp'
jade = require 'gulp-jade'
gutil  = require 'gulp-util'
sass = require 'gulp-sass'
coffee = require 'gulp-coffee'
nodemon = require 'gulp-nodemon'
copy = require "gulp-copy"
livereload = require 'gulp-livereload'

app = null
sources =
	jade: "src/assets/templates/*.jade"
	views: "src/views/**/*.jade"
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

gulp.task "copy",->
	gulp.src sources.views,
		base:"./src"
	.pipe gulp.dest("./app")

gulp.task "watch", ->
	livereload.listen()
	gulp.watch sources.jade, ["jade"]
	gulp.watch sources.sass, ["sass"]
	gulp.watch sources.coffee, ["coffee"]
	gulp.watch sources.views, ["copy"]
	return

gulp.task "develop", ->
	nodemon 
		script:"app/app.js"
		ext:"jade html js"
		ignore:["./app/assets/**"]
	.on "restart", ->
		console.log "RESTARTED!"

gulp.task "default", [
	"jade"
	"coffee"
	"sass"
	"copy"
	"develop"
	"watch"
]