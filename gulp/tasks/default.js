/* jslint node: true */
'use strict';

var gulp = require('gulp');
gulp.task('default', ['images','js:all', 'iconFont', 'sass', 'watch']);
