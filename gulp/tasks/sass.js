/* jslint node: true */
'use strict';

var gulp = require('gulp'),
    sass = require('gulp-sass'),
    sourcemaps = require('gulp-sourcemaps'),
    handleErrors = require('../util/handleErrors'),
    notify = require('../util/custom_notify'),
    config = require('../config').sass,
    autoprefixer = require('gulp-autoprefixer');

gulp.task('sass', function() {
    return gulp.src(config.src)
    .pipe(sourcemaps.init({debug: true}))
    .pipe(sass(config.settings))
    .on('error', handleErrors)
    .pipe(autoprefixer({ browsers: config.browsers }))
    .on('error', handleErrors)
    .pipe(sourcemaps.write())
    .pipe(gulp.dest(config.dest))
    .pipe(notify.send(notify.opts({}, 'sass')));
    // .pipe(bs.reload({stream: true}));
});
