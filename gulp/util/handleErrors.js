/* jslint node: true */
'use strict';

var custom = require('./custom_notify'),
    notify = custom.send,
    opts = custom.opts;

module.exports = function() {
    var args = Array.prototype.slice.call(arguments);

    notify.onError(opts({
        title: 'Compile Error',
        message: '<%= error.message %>',
        icon: './gulp/util/images/gulp-error.png'
    })).apply(this, args);

    this.emit('end');
};
