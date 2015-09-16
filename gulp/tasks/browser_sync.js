'use strict';

var gulp = require('gulp'),
    browserSync = require('browser-sync').create(),
    config = require('../config');

gulp.task('browser-sync', ['js:all', 'sass'], function() {
    browserSync.init({
        proxy: 'localhost:3000',
        port: 9000,
        files: [
            './public/assets/**/*.{js,css}',
            './app/views/**/*.html.haml'
        ]
    });

    gulp.watch([config.sass.src, config.bowerFiles + '**/*.scss'], ['sass']);
    gulp.watch(config.images.src, ['images']);
    gulp.watch(config.iconFont.src, ['iconFont']);
    gulp.watch(config.bowerFiles + '**/*', ['copy']);
    gulp.watch(config.javascripts.standalone, ['js:standalone']);
    gulp.watch(config.javascripts.coffee.src, ['js:coffee']);
    gulp.watch(config.javascripts.bower, ['js:bower']);
    gulp.watch(config.elements.imports, ['elements:vulcanize']);
});

module.exports = browserSync.reload;
