/* jslint node: true */
'use strict';

var gulp = require('gulp');
gulp.task('default', ['images','js:all', 'elements:vulcanize', 'iconFont', 'sass', 'browser-sync']);
