'use strict';

var gulp            = require('gulp'),
    config          = require('../config').elements,
    $               = require('gulp-load-plugins')(),
    del             = require('del'),
    notify          = require('../util/custom_notify').send;

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
        .pipe(notify(function(file) {
            if (file.jshint.success) {
                return false;
            }

            var errors = file.jshint.results.map(function(data) {
                if (data.error) {
                    return '(' + data.error.line + ':' +
                        data.error.character + ')' + data.error.reason;
                }
            }).join('\n');
            return file.relative + ' (' + file.jshint.results.length + 'errors)\n' + errors;
        }));
        // .pipe($.jshint.reporter('jshint-stylish'));
});

gulp.task('elements:vulcanize', ['elements:jshint'], function() {
    return gulp.src(config.imports)
        .pipe($.vulcanize(config.vulcanize.opts))
        .pipe($.rename('elements.html'))
        .pipe(gulp.dest(config.dest))
        .pipe($.size({title: 'elements:vulcanize'}));
});

gulp.task('elements:clean', function(cb) {
    del([config.base + '/**/*', '!' + config.base + '/elements.html'], cb);
});
