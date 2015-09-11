/* jslint node: true */
'use strict';

var _ = require('lodash');
var browserify = require('browserify');
var bs = require('./browser_sync');
var bundleLogger = require('../util/bundleLogger');
var config = require('../config').browserify;
var gulp = require('gulp');
var handleErrors = require('../util/handleErrors');
var source = require('vinyl-source-stream');
var watchify = require('watchify');

var browserifyTask = function(callback, devMode) {
    var bundleQueue = config.bundleConfigs.length;
    var browserifyThis = function(bundleConfig) {
        if (devMode) {
            _.extend(bundleConfig, watchify.args, { debug: true });
            bundleConfig = _.omit(bundleConfig, ['external', 'require']);
        }

        var b = browserify(bundleConfig);

        var reportFinished = function() {
            bundleLogger.end(bundleConfig.outputName);

            if (bundleQueue) {
                bundleQueue--;
                if (bundleQueue === 0) {
                    callback();
                }
            }
        };

        var bundle = function() {
            bundleLogger.start(bundleConfig.outputName);

            return b
                .bundle()
                .on('error', handleErrors)
                .pipe(source(bundleConfig.outputName))
                .pipe(gulp.dest(bundleConfig.dest))
                .on('end', reportFinished)
                .pipe(bs.stream());
        };

        if (devMode) {
            b = watchify(b);
            b.on('update', bundle);
            bundleLogger.watch(bundleConfig.outputName);
        } else {
            if(bundleConfig.require) { b.require(bundleConfig.require); }
            if(bundleConfig.external) { b.external(bundleConfig.external); }
        }

        return bundle();
    };

    config.bundleConfigs.forEach(browserifyThis);
};

gulp.task('browserify', browserifyTask);

module.exports = browserifyTask;
