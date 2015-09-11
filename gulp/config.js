/* jslint node: true */
'use strict';

var sources = './gulp/assets',
    pubDest = './public/assets',
    bowerFiles = './gulp/assets/bower_components',
    bootstrapFiles = './gulp/assets/bower_components/bootstrap',
    jsManifest = require('./js-manifest');

var autoprefixerBrowsers =  [
    'ie >= 10',
    'ie_mob >= 10',
    'ff >= 30',
    'chrome >= 34',
    'safari >= 7',
    'opera >= 23',
    'ios >= 7',
    'android >= 4.4',
    'bb >= 10'
];

module.exports = {
    dest: pubDest,
    bowerFiles: bowerFiles,
    src: sources,
    browserSync: {
        proxy: 'localhost:3000',
        files: ['./app/views/**']
    },
    javascripts: {
        headjs: jsManifest.headjs,
        src: jsManifest.bowerComponents,
        dest: pubDest + '/javascripts'
    },
    sass: {
        src: sources + '/stylesheets/**/*.scss',
        bower: bowerFiles + '/**/*.scss',
        base: sources,
        dest: pubDest + '/stylesheets',
        browsers: autoprefixerBrowsers,
        settings: {
            indentedSyntax: false,
            imagePath: '/assets/images',
            includePaths: [bootstrapFiles + '/scss']
        }
    },
    images: {
        src: sources + "/images/**",
        dest: pubDest + "/images"
    },
    iconFont: {
        name: 'Smart Home Icons',
        src: sources + '/icons/*.svg',
        dest: pubDest + '/fonts',
        fontPath: '/assets/fonts',
        sass: {
            dest: sources + '/stylesheets/base',
            template: './gulp/tasks/iconFont/template.sass',
            outputName: '_iconFont.sass',
            className: 'icon'
        },
        options: {
            fontName: 'my-icon-font',
            appendCodepoints: true,
            normalize: false
        }
    },
    browserify: {
        bundleConfigs: [{
            entries: sources + '/javascripts/application.coffee',
            dest: pubDest + '/javascripts',
            outputName: 'application.js',
            extensions: ['.js', '.coffee']
        }]
    }
};
