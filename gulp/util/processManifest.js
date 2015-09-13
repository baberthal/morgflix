'use strict';

var path = require('path');

module.exports = function(manifestJson, item, prefixDir) {
    var ret = [];
    manifestJson[item].forEach(function(entry) {
        ret.push(path.join(prefixDir, entry, '**/*'));
    });
    return ret;
};
