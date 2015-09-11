/* jslint node: true */
'use strict';

var gulp = require('gulp'),
    bs = require('./browser_sync'),
    sass = require('gulp-sass'),
    sourcemaps = require('gulp-sourcemaps'),
    handleErrors = require('../util/handleErrors'),
    config = require('../config').sass,
    autoprefixer = require('gulp-autoprefixer');

gulp.task('sass', function() {
    return gulp.src(config.src)
    .pipe(sourcemaps.init({ debug: true}))
    .pipe(sass(config.settings))
    .pipe(autoprefixer({ browsers: ['last 2 versions'] }))
    .on('error', handleErrors)
    .pipe(sourcemaps.write())
    .pipe(gulp.dest(config.dest))
    .pipe(bs.stream());
});
