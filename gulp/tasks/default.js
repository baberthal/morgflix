/* jslint node: true */
'use strict';

var gulp = require('gulp');
gulp.task('default', ['images','js:all', 'copy', 'iconFont', 'sass', 'watch']);
