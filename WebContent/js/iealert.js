/*
 * IE Alert! jQuery plugin
 * Version 2.1
 * Author: David Nemes | @nmsdvid
 * http://nmsdvid.com/iealert/
 */

(function ($) {
    function initialize($obj, support, title, text, upgradeTitle, upgradeLink, overlayClose, closeBtn) {
    
    
        var panel = "<div class='ie-l-t-c'></div>"
            + "<div class='ie-t'></div>"
            + "<div class='ie-r-t-c'></div>"
            + "<div class='ie-l'></div>"
            + "<div class='ie-c'>"
            + "<span class='ie-span'>" + title + "</span>"
            + "<p class='ie-p'>" + text + "</span>"
            + "<div class='ie-u'>"
            //+ "<div class='ie-u-l'></div>"
            //+ "<a href='" + upgradeLink + "' target='_blank'>"
            //+ "<div class='ie-u-c'>"
            //+ "<span class='ie-u-s'>" + upgradeTitle + "</span>"
            //+ "</div>"
            //+ "</a>"
            //+ "<div class='ie-u-r'></div>"
            + "</div>"
            + "</div>"
            + "<div class='ie-r'></div>"
            + "<div class='ie-l-b-c'></div>"
            + "<div class='ie-b'></div>"
            + "<div class='ie-r-b-c'></div>";

        var overlay = $("<div id='ie-alert-overlay'></div>");
        var iepanel = $("<div id='ie-alert-panel'>" + panel + "</div>");

        var docHeight = $(document).height();

        overlay.css("height", docHeight);

        function active() {
            $obj.prepend(iepanel);
            $obj.prepend(overlay);

            var cHeight = $('.ie-c').css('height');
            $('.ie-l').css('height', cHeight);
            $('.ie-r').css('height', cHeight);
            var uWidth = $('.ie-u-c').width();
            $('.ie-u').css('margin-left', -(uWidth / 2 + 14));
            var iePanel = $('#ie-alert-panel');
            var ieOverlay = $('#ie-alert-overlay');
            var ieBtn = $(".ie-r-t-c");

            if (closeBtn === false) {
                ieBtn.css('background-position', '-145px -58px');
                ieBtn.click(function (e) {
                   e.preventDefault();
                });
            } else {
                ieBtn.click(function () {
                    iePanel.fadeOut(100);
                    ieOverlay.fadeOut("slow");
                });
            }

            if (overlayClose === true) {
                ieOverlay.click(function () {
                    iePanel.fadeOut(100);
                    $(this).fadeOut("slow");
                });
            }

            if (ie === 6) {
                iepanel.addClass("ie6-style");
                overlay.css("background", "#d6d6d6");
                $obj.css("margin", "0");
            }
        }
        if (support === "ie11") {            // the modal box will appear on  IE10, IE9, IE8, IE7, IE6
            if (ie < 12) {
                active();
            }
        } else if (support === "ie10") {            // the modal box will appear on  IE10, IE9, IE8, IE7, IE6
            if (ie < 11) {
                active();
            }
        } else if (support === "ie9") {            // the modal box will appear on IE9, IE8, IE7, IE6
            if (ie < 10) {
                active();
            }
        } else if (support === "ie8") {     // the modal box will appear on IE8, IE7, IE6
            if (ie < 9) {
                active();
            }
        } else if (support === "ie7") {     // the modal box will appear on IE7, IE6
            if (ie < 8) {
                active();
            }
        } else if (support === "ie6") {     // the modal box will appear only on IE6 and below
            if (ie < 7) {
                active();
            }
        }

    }

    ; //end initialize function

    $.fn.iealert = function (options) {
        var defaults = {
            support:"ie8",
            title:"Did you know that your Internet Explorer is out of date?",
            text:"To get the best possible experience using our site we recommend that you upgrade to a modern web browser. To download a newer web browser click on the Upgrade button.",
            upgradeTitle:"Upgrade",
            upgradeLink:"http://browsehappy.com/",
            overlayClose:false,
            closeBtn: true
        };

        var option = $.extend(defaults, options);

        return this.each(function () {
        	
	    	ie = (function(){
	 
			    var undef,
			        v = 3,
			        div = document.createElement('div'),
			        all = div.getElementsByTagName('i');
			    
			    while (
			        div.innerHTML = '<!--[if gt IE ' + (++v) + ']><i></i><![endif]-->',
			        all[0]
			    );
			    
			    return v > 4 ? v : undef;
	    
	    	 }());

	    	 var isIE10 = /MSIE\s+10.0/i.test(navigator.userAgent) && (function() {"use strict";return this === undefined;}());
	    	 if(isIE10){
	    		 ie = 10;
	    	 }
	    	 var isIE11 = (navigator.userAgent.toLowerCase().indexOf("trident") > -1 && navigator.userAgent.indexOf("rv") > -1);
	    	 if(isIE11){
	    		 ie = 11;
	    	 }

	    	 // If browser is Internet Explorer
             if (ie >= 5) {
                var $this = $(this);
                initialize($this, option.support, option.title, option.text, option.upgradeTitle, option.upgradeLink, option.overlayClose, option.closeBtn);
             }

        });

    };
})(jQuery);

var check = function(r) {
    return r.test(navigator.userAgent.toLowerCase());
};

var statics = {
    /**
     * 是否为webkit内核的浏览器
     */
    isWebkit : function() {
      return check(/webkit/);
    },
    /**
     * 是否为火狐浏览器
     */
    isFirefox : function() {
      return check(/firefox/);
    },
    /**
     * 是否为谷歌浏览器
     */
    isChrome : function() {
      return !statics.isOpera() && check(/chrome/);
    },
    /**
     * 是否为Opera浏览器
     */
    isOpera : function() {
      return check(/opr/);
    },
    /**
     * 检测是否为Safari浏览器
     */
    isSafari : function() {
      // google chrome浏览器中也包含了safari
      return !statics.isChrome() && !statics.isOpera() && check(/safari/);
    }
};
