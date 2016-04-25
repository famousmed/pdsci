(function($){
			$.fn.isClose = function(){
				var options = this.data("options");
				return options.status == "close";
			};
			
			$.fn.rightSlideOpen = function(func){
				var options = this.data("options");
				if(options.haveZZ){
					$("#slideRightZZ").show();
				}
				if(this.css("right")==(-options.width+"px")){
					this.show().animate({right:"0px"},options.speed,function(){
						options.status = "open";
						$(this).data("options",options);
						if(func){
							func(this);
						}
					});
				}
				return this;
			};
		
			$.fn.rightSlideClose = function(func){
				var options = this.data("options");
				if(this.css("right")=="0px"){
					this.animate({right:-options.width+"px"},options.speed,function(){
						options.status = "close";
						$(this).data("options",options);
						if(options.haveZZ){
							$("#slideRightZZ").hide();
						}
						$(this).hide();
						if(func){
							func(this);
						}
					});
				}
				return this;
			};
		
			$.fn.slideInit = function(options){
				options = options || {};
				options.width = options.width || 800;
				options.minWidth = options.minWidth || 0;
				options.speed = options.speed || 1000;
				options.outClose = options.outClose || false;
				options.haveZZ = options.haveZZ || false;
				options.status = "close";
				this.data("options",options);
				
				this.css({
					height:"100%",
					width: options.width+"px",
					right: -options.width+"px",
					top: 0,
					display:"none",
					position: "fixed",
					zIndex: 1000,
					paddingLeft:"11px"
				});
				
				if(options.haveZZ){
					if(!$("#slideRightZZ").length){
						var $slideRightZZ = $('<div/>');
						$slideRightZZ.css({
							height:"100%",
							width: "100%",
							right: 0,
							top: 0,
							display:"none",
							position: "fixed",
							zIndex: 1,
							backgroundColor:"rgba(0,0,0,0.1)"
						}).attr("id","slideRightZZ");
						this.after($slideRightZZ);
					}
				}
				
				this.addClass("slideRightDiv");
				
				if(options.outClose){
					var div = this;
					$("[onclick]").click(function(e){
						e.stopPropagation();
					});
					this.click(function(e){
						e.stopPropagation();
					});
					$(document).mouseup(function(e){
						if((document.body.offsetWidth-options.width)>e.pageX && e.pageX>0 &&
								$(e.target).closest($(".reorder")).length==0){
							div.rightSlideClose((typeof options.outClose == "function")?(options.outClose):false);
						}
					});
				}
				return this;
			};
		})(jQuery);