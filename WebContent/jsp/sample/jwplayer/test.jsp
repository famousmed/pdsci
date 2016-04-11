<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<title>README: JW Player</title>
<style type="text/css">
.partTop {
background: url("../img/bg_ceping.png") repeat;
height: 533px;
width: 100%;
}
.course-video-box {
position: relative;
width: 1200px;
margin: 0 auto;
height: 100%;
background-color: rgba(0,0,0,0.5);
}
.next-box {
position: absolute;
left: 0;
top: 0;
right: 0;
bottom: 0;
background-color: #2E3C45;
font-size: 14px;
text-align: center;
color: #cfcfcf;
}
.next-inner {
margin-top: 138px;
height: 280px;
}
.next-box a.again {
padding-left: 25px;
color: #fff;
font-size: 24px;
background: url(../img/course_video_again.png) no-repeat 0 5px;
}
.next-box a.btn {
font-size: 24px;
}
.btn.btn-xlarge {
height: 60px;
line-height: 60px;
overflow: visible;
font-size: 36px;
padding: 0 30px;
}
.btn, a.btn {
cursor: pointer;
border: none;
background: #c9394a;
color: #ffffff;
padding: 0 15px;
font-size: 14px;
display: inline-block;
-webkit-transition: 0.25s;
-moz-transition: 0.25s;
-o-transition: 0.25s;
transition: 0.25s;
font-family: '微软雅黑';
margin: 0;
height: 26px;
overflow: visible;
line-height: 26px;
text-decoration: none;
}
</style>
<script>

</script>
</head>
<body onKeyDown="KeyOn_Space(event);">
	<script type="text/javascript" src="${ctxPath }/js/jquery-1.8.1.js"></script>
	<script type="text/javascript" src="./jwplayer.js"></script>


	<div id="studyMain">
<div id="bgarea" class="partTop">
    <div id="J_Box" class="course-video-box">
        <div id="video-box" class="video-wrap"></div>
        <div class="next-box " id="J_NextBox" style="display: none">
            <div class="next-inner">
                <a href="javascript:window.location.reload(true);" class="again">重新观看</a>
                                <p>下一节课程:  如何进行 XML 文件解析前的准备工作</p>
                <a class="btn btn-xlarge" href="/video/3661">进入下一节</a>
                            </div>
        </div>
         <div class="next-box " id="randomConfirm" style="display: none">
         <div class="next-inner" >
            <input name="verifyCode" type="text" class="validate[required] logo_text"
					id="verifyCode"	style="width: 100px;" placeholder=""/>
					<img id="verifyImage" src="<s:url value='/captcha'/>" style="cursor:pointer;" onclick="reloadVerifyCode();" title="点击更换验证码" alt="看不清，换一张" />
       	<input type="button" value="提交" onclick="doContinue();"/>
       	</div>
        </div>
    </div>
</div>
</div>

		
<div style="text-align: left;margin-top: 10px">
    <input type="button" class="player-play" value="play" />
    <input type="button" class="player-stop" value="stop" />
    <input type="button" class="player-status" value="status" />
    <input type="button" class="player-current" value="current" />
    <input type="button" class="player-goto" value="goto.30min" />
    <input type="button" class="player-length" value="length" />
    <input type="button" class="player-onseek" value="onseek" />
    <input type="button" class="player-cover" value="cover" />
</div>
<br/>
<div>
<textarea id="output" style="width: 500px;height: 300px;"></textarea>
</div>
	<script type="text/javascript">
	var	playserWaitTime,//计时器－－－－－
	playerOldHd=0,
	bufferType=1;
	var randomTime=-1;
	var isConfirm = false;
	var key;
	function radKey(length){
		var word ="";
		for(var i=0;i<length;i++){
		var r = parseInt(Math.random()*75+48);
			if((r>57&&r<65) || (r>90&&r<97)){
				r-=10;
			}
		word += String.fromCharCode(r);
		}
		return word;
	}
	
	
		var thePlayer;
		//jwplayer.logo="logo-190px.png"; 
		//jwplayer.url="http://www.njpdkj.com/";

		thePlayer = jwplayer("video-box").setup({
			flashplayer : "jwplayer.flash.swf",
			image : "player.jpg",
			controls : true,
			//缁鐎穎lv,f4v,mov,m4a,m4v,mp4,aac,f4a,mp3
			//file : "hy.mp4",
			file : "123.flv",
			//file: "mi41.webm",		
			//file: "823.flv",

			//width: 800,
			//width:$(document.body).outerWidth(true),
			//height: 450,

			//skin: "skin/green.xml",
			//skin: "skin/blue.xml",
			//skin: "skin/five.xml",
			//skin: "skin/green.xml",
			bufferlength: 5,   
 			primary: "flash",
            autostart:false,
            startparam: "start",
            autochange:true,
			title : '医学视频',
			description : "视频一的简介",

			controlbar : "over", //控制条位置	//controlbar: "bottom",
			//controlbar: "none",
			screencolor : "#fff", //播放器颜色
			stretching : "fill", //画面自适应
			repeat : "", //always 重复播放
			//autostart:true,         //自动播放
			//mute: true,	          //静音

			width : 1200,
			height : 533,
			//aspectratio: "16:9",

			events : {
				onReady: function() { },
				onVolume : function(event) {
					alert("the new volume is" + event.volume);
				},
				onComplete : function() {
					$("#J_NextBox").show();
				},
				onTime:function(event) {
					if(randomTime==-1){
						randomVerify();
						$("#output").append("初始化验证时间："+randomTime+"\n");
					}else {
						if (parseInt(event.position) == randomTime && !isConfirm) {
							thePlayer.play(false);
							$("#randomConfirm").show();
							$("#output").append(parseInt(event.position)+"\n");
						}
					}
				},
				onSeek: function(evt) {
					
			    },
				onBuffer:function(evt){//缓冲状态，缓冲图标显示
					//playserWaitTime=new Date().getTime();
					//$("#output").append(playserWaitTime);
				   //if(bufferType==1){
				//		playerOldHd=thePlayer.getCurrentQuality();
				 //  };
				//	key=radKey(10)+playserWaitTime;
					//sendVideoTestData(2,0,"",playserWaitTime,0);
					
					//if(thePlayer.getBuffer() < 3 && thePlayer.getState() != "PAUSED"){
					//	thePlayer.pause();
						//setTimeout("thePlayer.play();",5000);
					//}
					
				},
				 onBufferChange: function(evt) {
					  //setTimeout("thePlayer.play();",15000);
					if((evt.bufferPercent >= 20 && playcnt == 0)){
						  playcnt++;
						  thePlayer.play();
						  // fires off event on media buffer change current settings will allow buffering to continue until it reaches 20%
				  	}
				  },
				onPlay:function(evt){//开始播放－缓冲结束
					$("#output").append("视频总长度："+thePlayer.getDuration()+"\n");
					//if(callback.oldstate=="PAUSED" ){
					//	return;
					//} 
					//var bufferTme=new Date().getTime()-playserWaitTime;
					//sendVideoTestData(1,bufferTme,"",new Date().getTime(),1);
				},
				 onQualityChange :function(callback){
					//console.log("onQualichange-----");
				},
		
				onError:function (callback){
					//loadVideo(callback.message);
				}
			},
			plugins : {
				sharing : {
					link : true
				}
			}

		});
		function reloadVerifyCode()
		{
			$("#verifyImage").attr("src","<s:url value='/captcha'/>?random="+Math.random());
		}
		function doContinue(){
			if(true){
				$("#randomConfirm").hide();
				thePlayer.play(true);
				isConfirm = true;
			}else {
				reloadVerifyCode();
			}
		}
		function randomVerify(){
			var duration = thePlayer.getDuration();
			var FilterStartTime = 10;
			var FilterEndTime = 20;
			randomTime =  Math.floor(FilterStartTime+Math.random()*(parseFloat(duration)-FilterStartTime-FilterEndTime));
			
		}
		//播放 暂停
		$('.player-play').click(function() {
			if (thePlayer.getState() != 'PLAYING') {
				thePlayer.play(true);
				this.value = 'pause';
			} else {
				thePlayer.play(false);
				this.value = 'play';
			}
		});

		
		
		
		//停止
		$('.player-stop').click(function() {
			thePlayer.stop();
		});

		//获取状态
		$('.player-status').click(function() {
			var state = thePlayer.getState();
			var msg;
			switch (state) {
			case 'BUFFERING':
				msg = '加载中';
				break;
			case 'PLAYING':
				msg = '正在播放';
				break;
			case 'PAUSED':
				msg = '暂停';
				break;
			case 'IDLE':
				msg = '停止';
				break;
			}
			alert(msg);
		});

		//获取播放进度
		$('.player-current').click(function() {
			alert(thePlayer.getPosition());
		});

		//跳转到指定位置播放
		$('.player-goto').click(function() {
			if (thePlayer.getState() != 'PLAYING') { //若当前未播放，先启动播放器
				thePlayer.play();
			}
			thePlayer.seek(30); //从指定位置开始播放(单位：秒)
		});

		//获取视频长度
		$('.player-length').click(function() {
			alert(thePlayer.getDuration());
		});

		//
		$('.player-oncomplete').click(function() {
			thePlayer.onComplete(function() {
				alert("video complete");
			});
		});

		//$('.player-onseek').click(function() {thePlayer.onSeek(function(event){alert(event.position+"==="+event.offset);}); });	

		$('.player-onseek').click(
				function() {
					thePlayer.onTime(function(event) {
						if (event.position == '15') {
							thePlayer.play(false);
							$("#randomConfirm").show();
						}
					}
					);
				});

		jwplayer().onReady(function() {
			if (window.location.hash) {
				var offset = window.location.hash.substr(3);
				thePlayer.seek(offset);
			}
		});

		$('.player-cover').click(function() {
			$("#background, #content").show();
			conPosition();
			thePlayer.play(false);
		});
		function conPosition() {
			var oBackground = document.getElementById("background");
			var dw = $(document).width();
			var dh = $(document).height();
			//oBackground.style.width = dw+'px';
			//oBackground.style.height = dh+'px';
			oBackground.style.width = thePlayer.getWidth() + 'px';
			oBackground.style.height = (thePlayer.getHeight() + 50) + 'px';
			oBackground.style.left = $("#myElement").position().left + 'px';
			oBackground.style.top = $("#myElement").position().top + 'px';

			var oContent = document.getElementById("content");

			var scrollTop = document.documentElement.scrollTop
					|| document.body.scrollTop;

			var l = (document.documentElement.clientWidth - oContent.offsetWidth) / 2;
			var t = ((document.documentElement.clientHeight - oContent.offsetHeight) / 2)
					+ scrollTop;

			//oContent.style.left = l + 'px';
			//oContent.style.top = t + 'px';
		}
		//$("#background").click(function() {
		//	$("#background, #content").hide();
		//	  thePlayer.play(true);
		//});
		$(window).resize(function() {
			conPosition();
		});
		function doBack() {
			$("#randomConfirm").hide();
			thePlayer.play(true);
		}

		function KeyOn_Space(ev) { //JW Player 空格控制播放暂停<body onKeyDown="KeyOn_Space(event);">
			ev = ev || window.event;
			var code = (ev.keyCode || ev.which);
			if (code == 32) {
				jwplayer('myElement').pause();
			}
		}
	</script>
</body>
</html>