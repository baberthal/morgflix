'use strict';

var gulp            = require('gulp'),
    config          = require('../config').elements,
    $               = require('gulp-load-plugins')(),
    del             = require('del');

gulp.task('elements:styles', function() {
    return gulp.src(config.styleSrc)
        .pipe($.changed(config.base, {extension: '.css'}))
        .pipe($.autoprefixer(config.browsers))
        .pipe(gulp.dest(config.tmp))
        .pipe($.if('*.css', $.cssmin()))
        .pipe(gulp.dest(config.dest))
        .pipe($.size({title: 'Elements:Styles'}));
});

gulp.task('elements:jshint', function() {
    return gulp.src(config.jsSrc)
        .pipe($.jshint.extract())
        .pipe($.jshint())
        .pipe($.jshint.reporter('jshint-stylish'));
});

gulp.task('elements:vulcanize', function() {
    return gulp.src(config.imports)
        .pipe($.vulcanize(config.vulcanize.opts))
        .pipe($.rename('elements.html'))
        .pipe(gulp.dest(config.dest))
        .pipe($.size({title: 'elements:vulcanize'}));
});

gulp.task('elements:clean', function(cb) {
    del([config.base + '/**/*', '!' + config.base + '/elements.html'], cb);
});
