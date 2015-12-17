browserify  = require 'browserify'
source      = require 'vinyl-source-stream'
buffer      = require 'vinyl-buffer'
size        = require 'gulp-size'
sourcemaps  = require 'gulp-sourcemaps'
prettyTime  = require 'pretty-hrtime'
watchify    = require 'watchify'
chalk       = require 'chalk'
uglify      = require 'gulp-uglify'
gulp        = require 'gulp'
coffee      = require 'gulp-coffee'
gutil       = require 'gulp-util'
sketch      = require 'gulp-sketch'
browserSync = require('browser-sync').create()
path        = require 'path'

process.env.NODE_ENV ?= 'development'
production   = process.env.NODE_ENV is 'production'

srcFolder = './src'
distFolder = './build'

config =
    scripts:
        source: './src/app.coffee'
        extensions: ['.coffee']
        transforms: ['coffee-reactify']
        destination: distFolder
        filename: 'app.js'
    copyFiles: ['index.html', 'framer', 'images', 'data', 'sketch']

setCopyTask = (folder) ->
    gulp.task folder, ->
        if path.extname folder
            gulp.src srcFolder + "/#{folder}"
                .pipe gulp.dest distFolder
        else
            gulp.src srcFolder + "/#{folder}/**/*"
                .pipe gulp.dest distFolder + "/#{folder}"

config.copyFiles.forEach (file) ->
    setCopyTask file

gulp.task 'build', config.copyFiles.concat 'scripts'
gulp.task 'default', ['build'], -> gulp.start 'watch'

handleError = (err) ->
    gutil.log err
    gutil.beep()
    @emit 'end'

buildScripts = (scriptConfig) ->
    bundle = browserify
        entries: [scriptConfig.source]
        extensions: scriptConfig.extensions
        debug: not production

    scriptConfig.transforms.forEach (t) -> bundle.transform t


    build = bundle.bundle()
        .on 'error', handleError
        # convert node stream to vinyl stream
        .pipe source scriptConfig.filename
        # vinyl stream to buffer for size plug-in using
        # and also this is a more perfomant way
        .pipe buffer()
        .pipe sourcemaps.init loadMaps: true

    if production
        build = build.pipe uglify()
        build.pipe size showFiles: true, gzip: true

    build
        .pipe sourcemaps.write '.'
        .pipe gulp.dest scriptConfig.destination

watchScripts = (scriptConfig) ->
    bundle = watchify browserify
        entries: [scriptConfig.source]
        extensions: scriptConfig.extensions
        debug: not production
        cache: {}
        packageCache: {}
        fullPaths: true

    scriptConfig.transforms.forEach (t) -> bundle.transform t

    bundle.on 'update', ->
        gutil.log "Starting '#{chalk.cyan 'rebundle'}'..."
        start = process.hrtime()
        build = bundle.bundle()
            .on 'error', handleError
            .pipe source scriptConfig.filename
            .pipe buffer()
            .pipe sourcemaps.init loadMaps: true

        if production
            build = build.pipe uglify()
            build.pipe size showFiles: true, gzip: true

        build
            .pipe sourcemaps.write '.'
            .pipe gulp.dest scriptConfig.destination
            .on 'finish', ->
                gutil.log "Finished '#{chalk.cyan 'rebundle'}' after #{chalk.magenta prettyTime process.hrtime start}"
                bundle.emit 'finish'
    .emit 'update'

    bundle

gulp.task 'watch', ->

    browserSync.init
        server:
            baseDir: distFolder
        injectChanges: false,
        notify: false

    config.copyFiles.forEach (file) ->
        watchGlob = srcFolder + "/#{file}"
        watchGlob += '/**/*' if !path.extname(file)
        gulp.watch(watchGlob, [file]).on 'change', browserSync.reload

    watchScripts(config.scripts).on 'finish', browserSync.reload

gulp.task 'scripts', ->
    buildScripts config.scripts