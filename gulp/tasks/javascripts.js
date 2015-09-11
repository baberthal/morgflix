/* jslint node: true */
'use strict';

var gulp = require('gulp'),
    concat = require('gulp-concat'),
    maps = require('gulp-sourcemaps'),
    config = require('../config').javascripts;

gulp.task('js:concat', function() {
    return gulp.src(config.src)
        .pipe(maps.init())
        .pipe(concat('bower_components.js'))
        .pipe(maps.write())
        .pipe(gulp.dest(config.dest));
});

gulp.task('js:bower', function() {
    return gulp.src(config.headjs)
        .pipe(maps.init())
        .pipe(concat('head_js.js'))
        .pipe(maps.write())
        .pipe(gulp.dest(config.dest));
});

gulp.task('js:all', ['js:concat', 'js:bower']);
