'use strict';

var gulp = require('gulp');
var merge = require('merge-stream');
var config = require('../config');
var $ = require('gulp-load-plugins')();

gulp.task('copy', function() {
    var bower = gulp.src([
            'gulp/assets/bower_components/**/*',
            '!gulp/assets/bower_components/bootstrap/**/*'
    ]).pipe(gulp.dest(config.elements.dest));

    var vulcanized = gulp.src(config.elements.imports)
        .pipe($.rename('elements.vulcanized.html'))
        .pipe(gulp.dest(config.elements.dest));

    return merge(bower, vulcanized)
        .pipe($.size({title: 'copy'}));
});
