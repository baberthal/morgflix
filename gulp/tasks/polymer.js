/* jslint node: true */
'use strict';

var gulp = require('gulp');
var $ = require('gulp-load-plugins')();
var del = require('del');
var config = require('../config').polymer;

var browserSync = require('browser-sync');
var reload = browserSync.reload;

var merge = require('merge-stream');
var path = require('path');
var fs = require('fs');
var glob = require('glob');
var historyApiFallback = require('connect-history-api-fallback');
var packageJson = require('../../package.json');
var crypto = require('crypto');
var polybuild = require('polybuild');

var exec = require('child_process').exec;

var styleTask = function (stylesPath, srcs) {
  return gulp.src(srcs.map(function(src) {
      return path.join(config.src, stylesPath, src);
    }))
    .pipe($.changed(stylesPath, {extension: '.css'}))
    .pipe($.autoprefixer(config.autoprefixerBrowsers))
    .pipe(gulp.dest(config.tmp + stylesPath))
    .pipe($.cssmin())
    .pipe(gulp.dest(config.dest + stylesPath))
    .pipe($.size({title: stylesPath}));
};

gulp.task('polymer:elements', function() {
    return styleTask('elements', ['**/*.css']);
});

gulp.task('polymer:jshint', function() {
    return gulp.src(config.jshint)
      .pipe(reload({stream: true, once: true}))
      .pipe($.jshint.extract())
      .pipe($.jshint())
      .pipe($.jshint.reporter('jshint-stylish'))
      .pipe($.if(!browserSync.active, $.jshint.reporter('fail')));
});

gulp.task('polymer:copy', function() {
  var app = gulp.src(config.app, { dot: true }).pipe(gulp.dest(config.dest));

  var bower = gulp.src(config.bower.src).pipe(gulp.dest(config.bower.dest));

  var elements =
    gulp.src(config.elements.src).pipe(gulp.dest(config.elements.dest));

  var sw = config.sw;

  var swBootstrap = gulp.src(sw.bootstrap.src)
    .pipe(gulp.dest(sw.bootstrap.dest));

  var swToolbox = gulp.src(sw.toolbox.src)
    .pipe(gulp.dest(sw.toolbox.dest));

  var vulcanized = gulp.src(config.vulcanized.src)
    .pipe($.rename(config.vulcanized.outputName))
    .pipe(gulp.dest(config.vulcanized.dest));

  return merge(app, bower, elements, vulcanized, swBootstrap, swToolbox)
    .pipe($.size({title: 'copy'}));
});

gulp.task('polymer:fonts', function () {
  return gulp.src(config.fonts.src)
    .pipe(gulp.dest(config.fonts.dest))
    .pipe($.size({title: 'fonts'}));
});

// Scan your HTML for assets & optimize them
gulp.task('polymer:html', function () {
  var assets = $.useref.assets({searchPath: ['.tmp', 'app', 'dist']});

  return gulp.src(['app/**/*.html', '!app/{elements,test}/**/*.html'])
    // Replace path for vulcanized assets
    .pipe($.if('*.html', $.replace('elements/elements.html', 'elements/elements.vulcanized.html')))
    .pipe(assets)
    // Concatenate and minify JavaScript
    .pipe($.if('*.js', $.uglify({preserveComments: 'some'})))
    // Concatenate and minify styles
    // In case you are still using useref build blocks
    .pipe($.if('*.css', $.cssmin()))
    .pipe(assets.restore())
    .pipe($.useref())
    // Minify any HTML
    .pipe($.if('*.html', $.minifyHtml({
      quotes: true,
      empty: true,
      spare: true
    })))
    // Output files
    .pipe(gulp.dest('dist'))
    .pipe($.size({title: 'html'}));
});

// Polybuild will take care of inlining HTML imports,
// scripts and CSS for you.
gulp.task('polymer:vulcanize', function () {
  return gulp.src('dist/index.html')
    .pipe(polybuild({maximumCrush: true}))
    .pipe(gulp.dest(config.dest));
});

gulp.task('rename-index', function () {
  gulp.src(config.dest + '/index.build.html')
    .pipe($.rename('index.html'))
    .pipe(gulp.dest(config.dest));
  return del([config.dest + '/index.build.html']);
});

// Generate config data for the <sw-precache-cache> element.
// This include a list of files that should be precached, as well as a (hopefully unique) cache
// id that ensure that multiple PSK projects don't share the same Cache Storage.
// This task does not run by default, but if you are interested in using service worker caching
// in your project, please enable it within the 'default' task.
// See https://github.com/PolymerElements/polymer-starter-kit#enable-service-worker-support
// for more context.
gulp.task('polymer:cache-config', function (callback) {
  var dir = config.dest;
  var conf = {
    cacheId: packageJson.name || path.basename(__dirname),
    disabled: false
  };

  glob('{elements,scripts,styles}/**/*.*', {cwd: dir}, function(error, files) {
    if (error) {
      callback(error);
    } else {
      files.push('index.html', './', 'bower_components/webcomponentsjs/webcomponents-lite.min.js');
      conf.precache = files;

      var md5 = crypto.createHash('md5');
      md5.update(JSON.stringify(conf.precache));
      conf.precacheFingerprint = md5.digest('hex');

      var configPath = path.join(dir, 'cache-config.json');
      fs.writeFile(configPath, JSON.stringify(conf), callback);
    }
  });
});

// Clean output directory
gulp.task('polymer:clean', function (cb) {
  del([config.tmp, config.dest], cb);
});

gulp.task('polymer:rails', function() {
  exec('zeus server -b 0.0.0.0');
});

// Watch files for changes & reload
gulp.task('polymer:serve', ['polymer:rails', 'polymer:elements'], function () {
  browserSync({
    port: 5000,
    notify: false,
    logPrefix: 'PSK',
    snippetOptions: {
      rule: {
        match: '<span id="browser-sync-binding"></span>',
        fn: function (snippet) {
          return snippet;
        }
      }
    },
    // Run as an https by uncommenting 'https: true'
    // Note: this uses an unsigned certificate which on first access
    //       will present a certificate warning in the browser.
    // https: true,
    server: {
      baseDir: ['.tmp', 'app'],
      middleware: [ historyApiFallback() ],
      routes: {
        '/bower_components': 'bower_components'
      }
    }
  });

  gulp.watch([config.src + '/**/*.html'], reload);
  gulp.watch([config.src + '/elements/**/*.css'], ['polymer:elements', reload]);
  gulp.watch([config.src + '/{scripts,elements}/**/{*.js,*.html}'], ['polymer:jshint']);
});
