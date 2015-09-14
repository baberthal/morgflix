'use strict';

var notify = require('gulp-notify'),
    Growl = require('node-notifier').Growl,
    _ = require('lodash');


module.exports = {
    send: notify.withReporter(function(opts, callback) {
        new Growl({
            name: 'Gulp',
            host: 'localhost',
            port: 23053
        }).notify(opts, callback);
    }),

    opts: function(opts, task) {
        task = task || 'Gulp';
        var defaults = {
            title: 'gulp ' + task,
            message: 'gulp ' + task + ' was successful',
            sticky: false,
            onLast: true,
            wait: false,
            icon: './gulp/util/images/gulp.png'
        };

        return _.extend({}, defaults, opts);
    }
};
