cordova.define("cordova-plugin-pdfviewer.pdfviewer", function(require, exports, module) {
               
       function openPDF(str, callback) {
       cordova.exec(callback, function(err) {
                    callback('Nothing to echo.');
                    }, "PDFViewer", "showPDF", [str]);
       };
       
       module.exports = openPDF;
               
});
