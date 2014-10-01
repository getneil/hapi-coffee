var app, coffee, copy, gulp, gutil, jade, livereload, nodemon, sass, sources;

gulp = require('gulp');

jade = require('gulp-jade');

gutil = require('gulp-util');

sass = require('gulp-sass');

coffee = require('gulp-coffee');

nodemon = require('gulp-nodemon');

copy = require("gulp-copy");

livereload = require('gulp-livereload');

app = null;

sources = {
  jade: "src/assets/templates/*.jade",
  views: "src/views/**/*.jade",
  coffee: "src/**/*.coffee",
  sass: "src/**/*.scss",
  overwatch: "src/**/*.{js,html,css}"
};

gulp.task("jade", function(event) {
  return gulp.src([sources.jade], {
    base: "./src"
  }).pipe(jade({
    pretty: true
  })).pipe(gulp.dest("./app"));
});

gulp.task('coffee', function(event) {
  return gulp.src([sources.coffee], {
    base: "./src"
  }).pipe(coffee()).pipe(gulp.dest("./app"));
});

gulp.task("sass", function(event) {
  return gulp.src([sources.sass], {
    base: "./src"
  }).pipe(sass({
    style: "compressed"
  })).pipe(gulp.dest("./app"));
});

gulp.task("copy", function() {
  return gulp.src(sources.views, {
    base: "./src"
  }).pipe(gulp.dest("./app"));
});

gulp.task("watch", function() {
  livereload.listen();
  gulp.watch(sources.jade, ["jade"]);
  gulp.watch(sources.sass, ["sass"]);
  gulp.watch(sources.coffee, ["coffee"]);
  gulp.watch(sources.views, ["copy"]);
});

gulp.task("develop", function() {
  return nodemon({
    script: "app/app.js",
    ext: "jade html js",
    ignore: ["./app/assets/**"]
  }).on("restart", function() {
    return console.log("RESTARTED!");
  });
});

gulp.task("default", ["jade", "coffee", "sass", "copy", "develop", "watch"]);
