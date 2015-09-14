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
    fonts: {
        src: [
            bowerFiles + '/font-awesome/fonts/**/*.{eot,ttf,woff,woff2,otf}',
            bowerFiles + '/material-design-icons/iconfont/**/*.{eot,ttf,woff,woff2}'
        ],
        dest: pubDest + '/fonts'
    },
    javascripts: {
        headjs: jsManifest.headjs,
        bower: jsManifest.bowerComponents,
        dest: pubDest + '/javascripts',
        standalone: sources + '/javascripts/standalone/**/*.coffee',
        coffee: {
            src: [
                sources + '/javascripts/application.coffee',
                sources + 'javascripts/**/*.coffee',
                '!' + sources + '/javascripts/standalone/**/*.coffee'
            ]
        },
        coffeeOpts: {
            bare: true
        }
    },
    elements: {
        tmp: '.tmp/elements',
        base: sources + '/elements',
        src: sources + '/elements/**/*.html',
        imports: sources + '/elements/elements.html',
        styleSrc: sources + '/elements/**/*.css',
        jsSrc: [
            sources + '/elements/**/*.js',
            sources + '/elements/**/*.html'
        ],
        browsers: autoprefixerBrowsers,
        dest: pubDest + '/elements',
        vulcanize: {
            src: sources + '/elements/elements.vulcanized.html',
            dest: sources + '/elements',
            opts: {
                stripComments: true,
                inlineCss: true,
                inlineScripts: true
            }
        }
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
            includePaths: [
                bootstrapFiles + '/scss',
                bowerFiles + '/font-awesome/scss'
            ]
        }
    },
    images: {
        src: sources + '/images/**',
        dest: pubDest + '/images'
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
    }
};
