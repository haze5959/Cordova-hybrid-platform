cordova.define('cordova/plugin_list', function(require, exports, module) {
               module.exports = [
                                 {
                                 "id": "cordova-plugin-console.console",
                                 "file": "plugins/cordova-plugin-console/www/console-via-logger.js",
                                 "pluginId": "cordova-plugin-console",
                                 "clobbers": [
                                              "console"
                                              ]
                                 },
                                 {
                                 "id": "cordova-plugin-console.logger",
                                 "file": "plugins/cordova-plugin-console/www/logger.js",
                                 "pluginId": "cordova-plugin-console",
                                 "clobbers": [
                                              "cordova.logger"
                                              ]
                                 },
                                 {
                                 "id": "cordova-plugin-inappbrowser.inappbrowser",
                                 "file": "plugins/cordova-plugin-inappbrowser/www/inappbrowser.js",
                                 "pluginId": "cordova-plugin-inappbrowser",
                                 "clobbers": [
                                              "cordova.InAppBrowser.open",
                                              "window.open"
                                              ]
                                 },
                                 {
                                 "id": "cordova-plugin-device.device",
                                 "file": "plugins/cordova-plugin-device/www/device.js",
                                 "pluginId": "cordova-plugin-device",
                                 "clobbers": [
                                              "device"
                                              ]
                                 },
                                 {
                                 "id": "cordova-plugin-pdfviewer.pdfviewer",
                                 "file": "plugins/cordova-plugin-pdfviewer/www/pdfviewer.js",
                                 "pluginId": "cordova-plugin-pdfviewer",
                                 "clobbers": [
                                              "cordova.pdfviewer.open",
                                              ]
                                 }
                                 ];
               module.exports.metadata = 
               // TOP OF METADATA
               {
               "cordova-plugin-whitelist": "1.3.2",
               "cordova-plugin-console": "1.0.6",
               "cordova-plugin-inappbrowser": "1.7.0",
               "cordova-plugin-device": "1.1.6-dev"
               };
               // BOTTOM OF METADATA
               });
