(function($) {

	$.suggest = function(input, options) {

		var $input = $(input).attr("autocomplete", "off");
		var $results;

		var timeout = false;		// hold timeout ID for suggestion results to appear	
		var prevLength = 0;			// last recorded length of $input.val()
		var cache = [];				// cache MRU list
		var cacheSize = 0;			// size of cache in chars (bytes?)
		var moveHeight = 0;        //滚动条移动距离
		
		//if($.trim($input.val())=='' || $.trim($input.val())=='中文/拼音') $input.val('中文/拼音').css('color','#aaa');
		if( ! options.attachObject )
			options.attachObject = $(document.createElement("ul")).appendTo('body');

		$results = $(options.attachObject);
		$results.addClass(options.resultsClass);
		
		resetPosition();
		$(window)
			.load(resetPosition)		// just in case user is changing size of page while loading
			.resize(resetPosition);

		$input.blur(function() {
			setTimeout(function() { $results.hide() }, 200);
		});
		
		$input.focus(function(){
			/*if($.trim($(this).val())=='中文/拼音'){
				$(this).val('').css('color','#000');
			}*/
			if($.trim($(this).val())==''){
				displayItems('');
			}
		});
		$input.click(function(){
			var q=$.trim($(this).val());
			displayItems(q);
			$(this).select();
		});
					
		// help IE users if possible
		try {
			$results.bgiframe();
		} catch(e) { }

		$input.keyup(processKey);//
		
		function resetPosition() {
			// requires jquery.dimension plugin
			var offset = $input.offset();
			$results.css({
				top: (offset.top + input.offsetHeight) + 'px',
				left: offset.left + 'px'
			});
		}
		
		
		function processKey(e) {
			
			// handling up/down/escape requires results to be visible
			// handling enter/tab requires that AND a result to be selected
			if ((/27$|38$|40$/.test(e.keyCode) && $results.is(':visible')) ||
				(/^13$|^9$/.test(e.keyCode) && getCurrentResult())) {
	            
	            if (e.preventDefault)
	                e.preventDefault();
				if (e.stopPropagation)
	                e.stopPropagation();

                e.cancelBubble = true;
                e.returnValue = false;
			
				switch(e.keyCode) {

					case 38: // up
						prevResult();
						break;
			
					case 40: // down
						nextResult();
						break;
					case 13: // return
						selectCurrentResult();
						options.enterFunc($(options.dataContainer).val());
						break;
						
					case 27: //	escape
						moveHeight = 0;
						$results.hide();
						break;

				}
				
			} else if ($input.val().length != prevLength) {

				if (timeout) 
					clearTimeout(timeout);
				timeout = setTimeout(suggest, options.delay);
				prevLength = $input.val().length;
				
			}			
				
			
		}
		
		function suggest() {
			moveHeight = 0;
			var q = $.trim($input.val());
			displayItems(q);
		}		
		function displayItems(items) {
			var html = '';
			if (items=='') {//遍历

			    for(h in options.hot_list){
					html+='<li rel="'+options.hot_list[h][0]+'"><a href="#'+h+'"><span>'+options.hot_list[h][1]+'</span>'+options.hot_list[h][2]+'</a></li>';
					//html+='<li rel="'+options.hot_list[h][0]+'"><a href="#'+h+'">'+options.hot_list[h][1]+'</a></li>';
				}
				html='<div class="s_gray ac_result_tip">滚动鼠标或者↑↓选择</div><ul>'+html+'</ul>';
			}
			else {
				/*if (!items)
				return;
				if (!items.length) {
					$results.hide();
					return;
				}*/
				for (var i = 0; i < options.source.length; i++) {//数据匹配
					var reg = new RegExp('^.*' + items + '.*$', 'im');	
					if ( reg.test(options.source[i][2]) || reg.test(options.source[i][1])) {
						if(options.source[i][2]!=null && options.source[i][2]!=""){
							html += '<li rel="' + options.source[i][0] + '"><a href="#' + i + '">' + options.source[i][1] + '<span>&#12288;[' + options.source[i][2] + ']</span></a></li>';
						}else{
							html += '<li rel="' + options.source[i][0] + '"><a href="#' + i + '">' + options.source[i][1] + '</a></li>';
						}
					}
//					if (reg.test(options.source[i][0])&& reg.test(options.source[i][2]) && reg.test(options.source[i][3])) {
//						html -= '<li rel="' + options.source[i][0] + '"><a href="#' + i + '"><span>' + options.source[i][2] + '</span>' + options.source[i][1] + '</a></li>';
//					}					
					/*var reg2 = new RegExp('.*?' + items + '.*?', 'im');
					if ( reg2.test(options.source[i][1])) {
						//html += '<li rel="' + options.source[i][0] + '"><a href="#' + i + '"><span>' + options.source[i][2] + '</span>' + options.source[i][1] + '</a></li>';
						html += '<li rel="' + options.source[i][0] + '"><a href="#' + i + '">' + options.source[i][1] + '</a></li>';
					}*/
				}
				
				if (html == '') {
					suggest_tip = '<div class="s_gray ac_result_tip">对不起，找不到：' + items + '</div>';
				}
				else {
					suggest_tip = '<div class="s_gray ac_result_tip">' + items + '，按名称排序</div>';
				}
				html = suggest_tip + '<ul>' + html + '</ul>';
			}
			
			$results.html(html).show();
			$results.children('ul').children('li:first-child').addClass(options.selectClass);
			
			$results.children('ul')
				.children('li')
				.mouseover(function() {
					$results.children('ul').children('li').removeClass(options.selectClass);
					$(this).addClass(options.selectClass);
				})
				.click(function(e) {
					e.preventDefault(); 
					e.stopPropagation();
					selectCurrentResult();
					options.triggerFunc($(this).attr("rel"));
				});
		}
					
		function getCurrentResult() {
		
			if (!$results.is(':visible'))
				return false;
		
			var $currentResult = $results.children('ul').children('li.' + options.selectClass);
			if (!$currentResult.length)
				$currentResult = false;
				
			return $currentResult;

		}
		
		function selectCurrentResult() {
		
			$currentResult = getCurrentResult();
			moveHeight = 0;
			if ($currentResult) {
				$input.val($currentResult.children('a').html().replace(/<span>.+?<\/span>/i,''));
				$results.hide();

				if( $(options.dataContainer) ) {
					$(options.dataContainer).val($currentResult.attr('rel'));
				}

				if (options.onSelect) {
					options.onSelect.apply($input[0]);
				}
			}
		
		}
		function nextResult() {
		
			$currentResult = getCurrentResult();
		
			if ($currentResult){
				$currentResult
				.removeClass(options.selectClass)
				.next()
					.addClass(options.selectClass);
				moveHeight += $currentResult.next().height();
				$results.animate({scrollTop: moveHeight},"fast");  
			}
			else{
				$results.children('ul').children('li:first-child').addClass(options.selectClass);
			}
		}
		
		function prevResult() {
		
			$currentResult = getCurrentResult();
		
			if ($currentResult){
				$currentResult
				.removeClass(options.selectClass)
				.prev()
					.addClass(options.selectClass);
				moveHeight -= $currentResult.prev().height();
				if(moveHeight<0){
					moveHeight = 0;
				}
				$results.animate({scrollTop: moveHeight},"fast"); 
			}
			else{
				$results.children('ul').children('li:last-child').addClass(options.selectClass);
			}
		}
		
//		function removeRepeat(html){
//			var strArr=html.split("&lt;li");//把字符串分割成一个数组  				             
//			strArr.sort();//排序  
//            var result=new Array();//创建出一个结果数组  
//            var tempStr="";  
//            var str="";
//            for(var i in strArr)  
//            {  
//                 if(strArr[i] != tempStr)  
//                 {  
//                      result.push(strArr[i]);  
//                      tempStr=strArr[i];  
//                      str+="<li"+strArr[i];
//                 }  
//                 else  
//                 {  
//                      continue;  
//                 }  
//            }              
//            return str;
//		}

	}
	
	$.fn.suggest = function(source, options) {
	
		if (!source)
			return;
	
		options = options || {};
		options.source = source;
		options.hot_list=options.hot_list || [];
		options.delay = options.delay || 0;
		options.resultsClass = options.resultsClass || 'ac_results';
		options.selectClass = options.selectClass || 'ac_over';
		options.matchClass = options.matchClass || 'ac_match';
		options.minchars = options.minchars || 1;
		options.delimiter = options.delimiter || '\n';
		options.onSelect = options.onSelect || false;
		options.dataDelimiter = options.dataDelimiter || '\t';
		options.dataContainer = options.dataContainer || '#SuggestResult';
		options.attachObject = options.attachObject || null;
		options.triggerFunc = options.triggerFunc || null;
		options.enterFunc = options.enterFunc || null;
		

		this.each(function() {
			new $.suggest(this, options);
		});

		return this;
		
	};
	
})(jQuery);