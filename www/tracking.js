var IOSAppTracking = {
    requestPermission: function(successCallback) {
        cordova.exec(successCallback, null, 'IOSAppTracking', 'requestPermission', []);
    },
    canRequestTracking: function(successCallback) {
        cordova.exec(successCallback, null, 'IOSAppTracking', 'canRequestTracking', []);
    },
    trackingAvailable: function(successCallback) {
        cordova.exec(successCallback, null, 'IOSAppTracking', 'trackingAvailable', []);
    },
}

module.exports = IOSAppTracking;