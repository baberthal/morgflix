'use strict';

var gulp = require('gulp');
var merge = require('merge-stream');
var config = require('../config');
var $ = require('gulp-load-plugins')();

gulp.task('copy', function() {
    var fonts = gulp.src(config.fonts.src)
        .pipe(gulp.dest(config.fonts.dest));

    return merge(fonts)
        .pipe($.size({title: 'copy'}));
});
