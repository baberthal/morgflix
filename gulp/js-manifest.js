/* jslint node: true */
'use strict';

var bowerFiles = './gulp/assets/bower_components';

module.exports = {
    bowerComponents: [
        bowerFiles + '/jquery/dist/jquery.js',
        bowerFiles + '/bootstrap/dist/js/bootstrap.js'
    ],
    headjs: [
        bowerFiles + '/webcomponentsjs/webcomponents-lite.js',
    ]
};
