$(document).ready(function(){
// 	window.onerror=function(msg, url, line){
// 		jboxError("鍙戠敓鑴氭湰閿欒锛歕n"+url + ":\nline:" + line + "\n" + msg);
// 		return true;
// 	};
});
$(document).ready(function(){
	/* $(document).bind('contextmenu',function(e){
		return false;
	}); */
});
//灏嗚〃鍗曟墍鏈夋暟鎹」搴忓垪鍖栨垚json瀵硅薄 濡傛灉鏌愪釜鏁版嵁椤瑰寘鍚涓� 浣跨敤,鍒嗗壊
jQuery.fn.serializeJson=function(){
	   var serializeObj={};
	   var array=this.serializeArray();
	   var str=this.serialize();
	   $(array).each(function(){
		   if(serializeObj[this.name]){
			   if($.isArray(serializeObj[this.name])){
				   serializeObj[this.name].push(this.value);
			   }else{
				   var temp = serializeObj[this.name]+","+this.value;
				   serializeObj[this.name]=temp;  
			   }
		   }else{
			   serializeObj[this.name]=this.value;
		   }
	   });
	    return serializeObj;
	  };
/* 鑾峰彇涓婁笅鏂囪矾寰�*/
function rootPath(){
	var path = window.location.pathname;
	return path.substring(0, path.substr(1).indexOf('/')+1);
}
//add missing native JS stuff if needed
//add this script for IE8 compatibility
if (!String.prototype.trim) {
    String.prototype.trim = function () {
        return this.replace(/^\s+|\s+$/g, '');
    };
}
if (typeof console == 'undefined') {
    (function() {
        var methods = ['log', 'info', 'warn', 'error', 'debug', 'group', 'groupCollapsed', 'groupEnd', 'dir', 'time', 'timeEnd', 'trace'];
        window.console = new Object();
        for (var i in methods) {
            window.console[methods[i]] = function(){};
        }
    })();
}
if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function (searchElement /*, fromIndex */) {
        "use strict";
        if (this == null) {
            throw new TypeError();
        }
        var t = Object(this);
        var len = t.length >>> 0;

        if (len === 0) {
            return -1;
        }
        var n = 0;
        if (arguments.length > 1) {
            n = Number(arguments[1]);
            if (n != n) { // shortcut for verifying if it's NaN
                n = 0;
            } else if (n != 0 && n != Infinity && n != -Infinity) {
                n = (n > 0 || -1) * Math.floor(Math.abs(n));
            }
        }
        if (n >= len) {
            return -1;
        }
        var k = n >= 0 ? n : Math.max(len - Math.abs(n), 0);
        for (; k < len; k++) {
            if (k in t && t[k] === searchElement) {
                return k;
            }
        }
        return -1;
    }
}
if (!Object.keys) {
    Object.keys = (function () {
        'use strict';
        var hasOwnProperty = Object.prototype.hasOwnProperty,
            hasDontEnumBug = !({toString: null}).propertyIsEnumerable('toString'),
            dontEnums = [
                'toString',
                'toLocaleString',
                'valueOf',
                'hasOwnProperty',
                'isPrototypeOf',
                'propertyIsEnumerable',
                'constructor'
            ],
            dontEnumsLength = dontEnums.length;

        return function (obj) {
            if (typeof obj !== 'object' && (typeof obj !== 'function' || obj === null)) {
                throw new TypeError('Object.keys called on non-object');
            }

            var result = [], prop, i;

            for (prop in obj) {
                if (hasOwnProperty.call(obj, prop)) {
                    result.push(prop);
                }
            }

            if (hasDontEnumBug) {
                for (i = 0; i < dontEnumsLength; i++) {
                    if (hasOwnProperty.call(obj, dontEnums[i])) {
                        result.push(dontEnums[i]);
                    }
                }
            }
            return result;
        };
    }());
}
