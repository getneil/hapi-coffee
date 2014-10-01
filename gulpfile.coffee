gulp       = require 'gulp'
jade       = require 'gulp-jade'
gutil      = require 'gulp-util'
sass       = require 'gulp-sass'
coffee     = require 'gulp-coffee'
nodemon    = require 'gulp-nodemon'
copy       = require "gulp-copy"
livereload = require 'gulp-livereload'
inject     = require 'gulp-inject'

app = null
sources =
	jade: "src/assets/templates/*.jade"
	views: "src/views/**/*.jade"
	coffee: "src/**/*.coffee"
	sass: "src/**/*.scss"
	overwatch: "src/**/*.{css,js,html}"
	cssToInject: [
		'./app/assets/styles/*.css'
		'./app/assets/libs/foundation/**/*.css'
	]
	jsToInject: [
		'./app/assets/libs/angular/**/*.min.js'
		'./app/assets/libs/angular-route/**/*.min.js'		
		'./app/assets/libs/angular-resource/**/*.min.js'		
	]

gulp.task "jade", (event) ->
	gulp.src [sources.jade],
		base:"./src"
	.pipe(jade(pretty: true))
	.pipe gulp.dest("./app")
	.pipe livereload()

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
	.pipe livereload()

gulp.task "copy",->
	gulp.src sources.views,
		base:"./src"
	.pipe gulp.dest("./app")
	.pipe livereload()

gulp.task 'cssinject', ->
	gulp.src ['app/views/layout/styles.jade'],
		base: './app'
	.pipe(inject(gulp.src(sources.cssToInject),
		read: false
		starttag: '//- inject:css'
		endtag: '//- endinject'
	))
	.pipe gulp.dest './app'

gulp.task 'jsinject', ->
	gulp.src ['app/views/layout/scripts.jade'],
		base: './app'
	.pipe(inject(gulp.src(sources.jsToInject),
		read: false
		starttag: '//- inject:js'
		endtag: '//- endinject'
	))
	.pipe gulp.dest './app'

gulp.task "watch", ->
	gulp.watch sources.jade, ["jade"]
	gulp.watch sources.sass, ["sass"]
	gulp.watch sources.coffee, ["coffee"]
	gulp.watch sources.views, ["copy"]
	gulp.watch sources.jsToInject, ['jsinject']
	gulp.watch sources.cssToInject, ['cssinject']
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
	# "cssinject"
	"jsinject"
	"develop"
	"watch"
]