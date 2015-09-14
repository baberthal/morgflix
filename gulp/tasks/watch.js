/* jslint node: true */
'use strict';

var gulp = require('gulp');
var config = require('../config');

gulp.task('watch', ['js:all', 'sass'], function(cb) {
    gulp.watch([config.sass.src, config.bowerFiles + '**/*.scss'], ['sass']);
    gulp.watch(config.images.src, ['images']);
    gulp.watch(config.iconFont.src, ['iconFont']);
    gulp.watch(config.bowerFiles + '**/*', ['copy']);
    gulp.watch(config.javascripts.standalone, ['js:standalone']);
    gulp.watch(config.javascripts.coffee.src, ['js:coffee']);
    gulp.watch(config.javascripts.bower, ['js:bower']);
    gulp.watch(config.elements.imports, ['elements:vulcanize']);
    cb();
});
