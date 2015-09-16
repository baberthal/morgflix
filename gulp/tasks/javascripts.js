/* jslint node: true */
'use strict';

var gulp = require('gulp'),
    concat = require('gulp-concat'),
    maps = require('gulp-sourcemaps'),
    config = require('../config').javascripts,
    handleErrors = require('../util/handleErrors'),
    notify = require('../util/custom_notify'),
    // Growl = require('node-notifier').Growl,
    coffee = require('gulp-coffee'),
    reload = require('./browser_sync');

gulp.task('js:bower', function() {
    return gulp.src(config.bower)
        .pipe(maps.init())
        .pipe(concat('bower_components.js'))
        .pipe(maps.write())
        .pipe(gulp.dest(config.dest))
        .pipe(reload({stream: true}))
        .pipe(notify.send(notify.opts({}, 'js:bower')));
});

gulp.task('js:head', function() {
    return gulp.src(config.headjs)
        .pipe(maps.init())
        .pipe(concat('head_js.js'))
        .pipe(maps.write())
        .pipe(gulp.dest(config.dest))
        .pipe(reload({stream: true}))
        .pipe(notify.send(notify.opts({}, 'js:head')));
});

gulp.task('js:standalone', function() {
    return gulp.src(config.standalone)
        .pipe(maps.init())
        .pipe(coffee(config.coffee.opts))
        .on('error', handleErrors)
        .pipe(maps.write())
        .pipe(gulp.dest(config.dest))
        .pipe(reload({stream: true}))
        .pipe(notify.send(notify.opts({}, 'js:standalone')));
});

gulp.task('js:coffee', function() {
    // var custom = notify.withReporter(function(opts, callback) {
    //     new Growl().notify(opts, callback);
    // });

    return gulp.src(config.coffee.src)
        .pipe(maps.init())
        .pipe(coffee(config.coffee.opts))
        .on('error', handleErrors)
        .pipe(maps.write())
        .pipe(gulp.dest(config.dest))
        .pipe(reload({stream: true}))
        .pipe(notify.send(notify.opts({}, 'js:coffee')));
});


gulp.task('js:all', ['js:head', 'js:bower', 'js:standalone', 'js:coffee']);
