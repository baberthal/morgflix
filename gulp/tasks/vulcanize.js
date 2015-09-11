/* jslint node: true */
'use strict';

var gulp = require('gulp');
var vulcanize = require('gulp-vulcanize');
var config = require('../config').polymer;
var handleErrors = require('../util/handleErrors');

gulp.task('vulcanize', function() {
    return gulp.src(config.src)
        .pipe(vulcanize(config.options))
        .on('error', handleErrors)
        .pipe(gulp.dest(config.dest));
});
