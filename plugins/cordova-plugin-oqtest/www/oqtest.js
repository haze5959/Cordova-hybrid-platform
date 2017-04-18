cordova.define("cordova-plugin-oqtest.echo", function(require, exports, module) {

    window.echo = function(str, callback) {
        cordova.exec(callback, function(err) {
            callback('Nothing to echo.');
        }, "oqtest", "echo", [str]);
    };

               module.exports = window.echo;
});

