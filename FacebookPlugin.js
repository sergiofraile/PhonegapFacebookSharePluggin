/**
 * @constructor
 */
var Facebook = function(){};


Facebook.prototype.available = function(callback) {
    cordova.exec(callback, null, "FacebookPlugin", "available", []);
};

/**
 * Post on facebook wall
 * @param {Function} success callback
 * @param {Function} failure callback
 * @param {String} failure.error reason for failure
 * @param {String} text message to send
 * @param {Object} options (optional)
 * @param {String} options.urlAttach URL to embed in share
 * @param {String} options.imageAttach Image URL to embed in share
 * @param {Number} response.response - 1 on success, 0 on failure
 * @example
 *     window.plugins.facebook.shareFacebookWall(
 *         function () { console.log("facebook success"); }, 
 *         function (error) { console.log("facebook failure: " + error); }, 
 *         "Text, Image, URL", 
 *         {
 *             urlAttach:"http://m.youtube.com/#/watch?v=obx2VOtx0qU", 
 *             imageAttach:"http://i.ytimg.com/vi/obx2VOtx0qU/hqdefault.jpg?w=320&h=192&sigh=QD3HYoJj9dtiytpCSXhkaq1oG8M"
 *         }
 * );
 */
Facebook.prototype.shareFacebookWall = function(success, failure, text, options){
    options = options || {};
    options.text = text;
    cordova.exec(success, failure, "FacebookPlugin", "shareFacebookWall", [options]);
};

cordova.addConstructor(function() {					   
/* shim to work in 1.5 and 1.6  */
	if (!window.Cordova) {
		window.Cordova = cordova;
	};


	if(!window.plugins) window.plugins = {};
		window.plugins.facebook = new Facebook();
});

