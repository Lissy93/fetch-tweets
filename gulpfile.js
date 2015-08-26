
/* Require the node modules */
var gulp    = require('gulp');
var uglify  = require('gulp-uglify');
var coffee  = require('gulp-coffee');
var lint    = require('gulp-coffeelint');
var del     = require('del');
var footer  = require('gulp-footer');
var size    = require('gulp-size');

/* Delete the files currently in lib directory */
gulp.task('clean', function (cb) {
    del(['./lib/**/*.js'], cb);
});

/* Lint, compile and minify CoffeeScript */
gulp.task('coffee-script',  function(){
    return gulp.src('./src/**/*.coffee')
        .pipe(lint())
        .pipe(lint.reporter())
        .pipe(coffee())
        .pipe(uglify())
        .pipe(footer(''))
        .pipe(size())
        .pipe(gulp.dest('lib'))
});


/* Defualt gulp task, deletes old files and compiles new files */
gulp.task('default', ['clean', 'coffee-script']);