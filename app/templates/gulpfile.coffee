gulp        = require 'gulp'
coffee      = require 'gulp-coffee'
gutil       = require 'gulp-util'
sketch      = require 'gulp-sketch'
browserSync = require('browser-sync').create()
path        = require 'path'

config =
    src: 'src'
    build: 'build'

config.coffeeSource = path.join config.src, '**', '*.coffee'
config.sketchSource = path.join config.src, '**', '*.sketch'
config.indexSource = path.join config.src, 'index.html'
config.framerSource = path.join config.src, 'framer', '**', '*.*'
config.libSource = path.join config.src, 'lib', '**', '*.*'
config.imageSource = path.join config.src, 'images', '**', '*.{png, jpg, svg}'

gulp.task 'build', ['copy', 'coffee', 'sketch']
gulp.task 'default', ['build', 'watch']

gulp.task 'watch', ->

    browserSync.init
        server:
            baseDir: config.build
        injectChanges: false,
        files: [path.join config.build, '**', '*.*']
        notify: false

    gulp.watch(config.coffeeSource, ['coffee']).on 'change', browserSync.reload
    gulp.watch(config.sketchSource, ['sketch']).on 'change', browserSync.reload

gulp.task 'coffee', ->
    gulp.src config.coffeeSource
        .pipe coffee bare: true
        .on 'error', gutil.log
        .pipe gulp.dest config.build

gulp.task 'sketch', ->
    gulp.src config.sketchSource
        .pipe sketch {
            export: 'slices'
            format: 'png'
            saveForWeb: true
            scales: 1.0
            trimmed: false
        }
        .pipe gulp.dest 'build/images'

gulp.task 'copy', ->
    gulp.src config.indexSource
        .pipe gulp.dest config.build
    gulp.src config.framerSource
        .pipe gulp.dest path.join config.build, 'framer'
    gulp.src config.libSource
        .pipe gulp.dest path.join config.build, 'lib'
    gulp.src config.imageSource
        .pipe gulp.dest path.join config.build, 'images'
