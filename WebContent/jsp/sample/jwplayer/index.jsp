<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<title>README: JW Player</title>
<style>
    body { padding: 50px 100px; width: 700px; font: 13px/20px Arial; background: #FFF; }
    a, h1, h2 { color: #369; }
    h2 { margin-top: 50px; }
    pre { font-size: 12px; background:#E5F3C8; padding:5px 10px; border: 1px solid #D3EAA4; }
    dt { font-weight: bold; }
</style>
<style type="text/css">
#background {position:absolute; z-index:998; top:0px; left:0px; background:rgb(50,50,50);background:rgba(0,0,0,0.5); display:none;}
#content {position:absolute; width:500px; z-index:999; padding:10px; background:#fff; border-radius:5px; display:none;}
</style>
</head>
<body onKeyDown="KeyOn_Space(event);">
<script type="text/javascript" src="${ctxPath }/js/jquery-1.8.1.js"></script>
<script type="text/javascript" src="./jwplayer.js"></script>
<div id="background" style="display: none; "><div id="content" style="display: none;margin-top: 50px;margin-left: 50px;">
	填写随机码 <input type="button" value="恢复" onclick="doBack();"/>
</div></div>
<div align="center" style="text-align: center;margin-left: 100px;">
<div id="myElement" >Loading the player...</div>
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
</div>

<script type="text/javascript">
	var thePlayer;
	//jwplayer.logo="logo-190px.png"; 
	//jwplayer.url="http://www.njpdkj.com/";
	
	thePlayer =  jwplayer("myElement").setup({
		flashplayer: "jwplayer.flash.swf",
		image: "player.jpg",
		controls: false,
		//缁鐎穎lv,f4v,mov,m4a,m4v,mp4,aac,f4a,mp3
        file: "upload/Video.mp4",
		//file: "mi41.webm",		
		//file: "823.flv",
		
		//width: 800,
		width:$(document.body).outerWidth(true),
		height: 450,
		
		
		//skin: "skin/green.xml",
		//skin: "skin/blue.xml",
		//skin: "skin/five.xml",
		//skin: "skin/green.xml",
		//bufferlength: 5,   

        title: '医学视频',
		description: "视频一的简介",	
			
		controlbar: "over",  //控制条位置	//controlbar: "bottom",
		//controlbar: "none",
		screencolor: "#fff",   //播放器颜色
		stretching: "fill",    //画面自适应
		repeat:"",       //always 重复播放
		//autostart:true,         //自动播放
		//mute: true,	          //静音

		
		//width: "100%",
		aspectratio: "16:9",
		
		
//		tracks: [{             
//		  file: "video.txt",
//		  //kind: "chapters"     //时间轴说明
//		  kind: "captions"     //字幕
//		}],

		
//		captions: {            //字幕设置
//		 color: "#FF0000",
//		 fontSize: 24,
//		 backgroundOpacity: 50
//		},
		
		
		events: {
		// onReady: function() { this.play(); },
		 onVolume: function(event) { alert("the new volume is"+event.volume); },
		 onComplete:function(){alert("video complete");}
		},


//		playlist: [
//		 { duration: 32, title: "Sintel Trailer1", description: "SintSintelel Trailer1", file: "video.mp4", image:"player.jpg"},
//		 { duration: 124, title: "Sintel Trailer2", description: "SSintelintel Trailer2",  file: "video.mp4", image:"player.jpg"},
//		 { duration: 542, title: "Sintel Trailer3", description: "SiSintelntel Trailer3",  file: "video.mp4", image:"player.jpg"}
//		],
//		
//
	//	listbar: {
	//	 position: "right",
	//	 size: 240
//		},

	
//		levels: [
//		 { bitrate: 300,label: "320p", file: "video.mp4", width:  320 },
//		 { bitrate: 600,label: "480p", file: "video.mp4", width:  480 },
//		 { bitrate: 900,label: "720p", file: "video.mp4", width:  720 }
//		],
//		provider: "rtmp",
//		streamer: "rtmp://rtmp.example.com/application/"


	//plugins: {
	//	 hd: { file:  "Video.mp4", fullscreen: true },
	//	 gapro: { accountid:  "UKsi93X940-24" }
	//	}
		plugins: {
		    sharing: {link:true}
		}

//modes配置项被用来指定渲染播放器不同浏览器技术的顺序�//		modes: [
//		 { type: 'html5' },
//		 { type: 'flash', 'src': 'jwplayer.flash.swf' },
//		 { type: 'download' }
//		]

    });
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
	$('.player-stop').click(function() { thePlayer.stop(); });

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
	$('.player-current').click(function() { alert(thePlayer.getPosition()); });

	//跳转到指定位置播放
	$('.player-goto').click(function() {
	    if (thePlayer.getState() != 'PLAYING') {    //若当前未播放，先启动播放器
	        thePlayer.play();
	    }
	    thePlayer.seek(30); //从指定位置开始播放(单位：秒)
	});

	//获取视频长度
	$('.player-length').click(function() { alert(thePlayer.getDuration()); });	
	
	//
	$('.player-oncomplete').click(function() {thePlayer.onComplete(function(){alert("video complete");}); });	
	
	//$('.player-onseek').click(function() {thePlayer.onSeek(function(event){alert(event.position+"==="+event.offset);}); });	
	
	$('.player-onseek').click(function() {thePlayer.onTime(function(event){
		if(event.position=='15'){ 
			thePlayer.play(false);
			alert(event.position+"==="+event.duration +"==do 10s");
		}
		if(event.position=='20'){ 
			thePlayer.play(false);
			alert(event.position+"==="+event.duration+"==== do 12s" );
		}
	}
	
	); });	
	
	
	jwplayer().onReady(function() { 
		    if(window.location.hash) {
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
		oBackground.style.width = thePlayer.getWidth()+'px';
		oBackground.style.height = (thePlayer.getHeight()+50)+'px';
		oBackground.style.left=$("#myElement").position().left+'px';
		oBackground.style.top=$("#myElement").position().top+'px';

		var oContent = document.getElementById("content");
		
		var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;

		var l = (document.documentElement.clientWidth - oContent.offsetWidth) / 2;
		var t = ((document.documentElement.clientHeight - oContent.offsetHeight) / 2) + scrollTop;

		//oContent.style.left = l + 'px';
		//oContent.style.top = t + 'px';
	}
	//$("#background").click(function() {
	//	$("#background, #content").hide();
	//	  thePlayer.play(true);
	//});
	$(window).resize(function() {conPosition();});
	function doBack(){
		$("#background, #content").hide();
		thePlayer.play(true);
	}
	
function KeyOn_Space(ev){     //JW Player 空格控制播放暂停<body onKeyDown="KeyOn_Space(event);">
    ev = ev || window.event;    
    var code = (ev.keyCode || ev.which);   
    if(code == 32) {  
        jwplayer('myElement').pause();  
    }  
}  

</script>





<img src="data:image/png;base64,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" alt="Base64 encoded image"/>
<h1>README: JW Player</h1>

<p>Thank you for downloading JW Player 6, the world's most popular HTML5/Flash video player! See <a href="http://www.longtailvideo.com/support/jw-player/28832/about-jw-player">About JW Player</a> for an overview of supported browsers/devices, as well as a more detailed feature list. See the <a href="http://www.longtailvideo.com/support/jw-player/28835/release-notes">Release Notes</a> if you want to learn what changed with this latest release.</p>

<h2>Quick Start</h2>

<p>Copy the <strong>jwplayer</strong> folder that contains this README to the www root of your website. Next, include the <em>jwplayer.js</em> script in the &lt;head&gt; of your HTML page.</p>

<p>If you have purchased the <a href="http://www.longtailvideo.com/jw-player/pricing/">Pro, Premium or Ads edition</a> of JW Player, its features can be activated by inserting your server-less JW Player license key in the second line:</p>

<pre>
&lt;script type="text/javascript" src="/jwplayer/jwplayer.js"&gt;&lt;/script&gt;
&lt;script type="text/javascript"&gt;jwplayer.key="ABCDEFGHIJKLMOPQ";&lt;/script&gt;
</pre>

<p>Note: A key is not required to use the Free edition, but will still be available from your <a href="https://account.longtailvideo.com/">JW Player Account</a>. Including your key will enable the free <a href="http://www.longtailvideo.com/support/jw-player/28852/using-jw-player-analytics">JW Player Analytics</a> for your account.</p>

<h3>Embed Code</h3>

<p>When the script and key are set, scroll down to the &lt;body&gt; of your HTML page and insert the JW Player embed code at the place you want your video to appear:</p>

<pre>
&lt;div id="myElement"&gt;Loading the player...&lt;/div&gt;

&lt;script type="text/javascript"&gt;
    jwplayer("myElement").setup({
        file: "/uploads/myVideo.mp4",
        image: "/uploads/myPoster.jpg"
    });
&lt;/script&gt;
</pre>

<p>See <a href="http://www.longtailvideo.com/support/jw-player/28839/embedding-the-player">Embedding JW Player</a> for a more elaborate description of options and some example embeds.</p>

<p><em>Note two very common issues prevent smooth video playback in Internet Explorer 9/10. First, you need to set <strong>&lt;!DOCTYPE html&gt;</strong> to prevent triggering IE's compatibility mode. Second, your videos must be served with the <strong>video/mp4</strong> mimetype. Not doing so will cause IE not to play them. See our <a href="http://www.longtailvideo.com/support/jw-player/28840/troubleshooting-your-setup">troubleshooting guide</a> for more common issues.</em></p>

<h3>Premium Skins</h3>

<p>If you have purchased the Premium or Ads edition of the player, your player includes a set of Premium skins. These skins can be downloaded from your <a href="https://account.longtailvideo.com/">JW Player Account</a>, but you can also load them off our CDN by simply inserting the skin name:</p>
<pre>    skin: "bekle"</pre>

<p>See <a href="http://www.longtailvideo.com/support/jw-player/28846/using-jw-player-skins">Using JW Player Skins</a> for more info.</p>



<h2>Documentation</h2>

<p>If you need help, the LongTail Support Community contains a wealth of information, including guides on:</p>

<ul>
<li>Supported <a href="http://www.longtailvideo.com/support/jw-player/28836/media-format-support">Media Formats</a> and <a href="http://www.longtailvideo.com/support/jw-player/28837/browser-device-support">Browsers &amp; Devices</a>.</li>
<li> How to <a href="http://www.longtailvideo.com/support/jw-player/28839/embedding-the-player">Customize</a> and <a href="http://www.longtailvideo.com/support/jw-player/28840/troubleshooting-your-setup">Troubleshoot</a> your embeds.</li>
<li>Configuring <a href="http://www.longtailvideo.com/support/jw-player/28842/working-with-playlists">Inline Playlists</a> or <a href="http://www.longtailvideo.com/support/jw-player/28843/loading-rss-feeds">RSS Feeds</a> (with multiple formats/qualities).</li>
<li>The <a href="http://www.longtailvideo.com/support/jw-player/28846/using-jw-player-skins">PNG Skinning Model</a> and <a href="http://www.longtailvideo.com/support/jw-player/28850/using-the-javascript-api">JavaScript API</a>.</li>
<li>Using <a href="http://www.longtailvideo.com/support/jw-player/28854/using-rtmp-streaming">RTMP Streaming</a> and <a href="http://www.longtailvideo.com/support/jw-player/28856/using-apple-hls-streaming/">Apple HLS</a> (Premium/Ads edition only).</li>
<li>How to <a href="http://www.longtailvideo.com/support/jw-player/28862/configuring-video-ads">Configure Video Ads</a> (Ads edition only).</li>
</ul>

<p>Visit our <a href="http://www.longtailvideo.com/support/forums/jw-player/">Support Forums</a> for setup problems, bug reports or suggestions for new features or enhancements. The forums are very active and frequently visited by members of the JW Player development team. Please see your <a href="http://account.longtailvideo.com">JW Player Account</a> for more information on obtaining technical support.</p>

<p>Follow the <a href="http://www.longtailvideo.com/blog/">LongTail Video Blog</a> for news on the JW Player and online video in general. We frequently publish posts on topics such as HTML5, video SEO, H.264, VAST advertising, etc. You can also <a href="http://twitter.com/longtailvideo">follow us on Twitter</a> or <a href="http://www.facebook.com/longtailvideo">like us on Facebook</a> to stay connected.</p>



<h2>Licensing</h2>

<p>Please be aware that each player edition has its own license:</p>

<dl>
<dt>JW Player Free</dt>
<dd>Under the terms of our <a href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons license</a>, you can use, modify and redistribute the player for non-commercial purposes only. 
Commercial sites must <a href=" http://www.longtailvideo.com/jw-player/pricing/">purchase a license</a> for the <strong>Pro</strong>, <strong>Premium</strong> or <strong>Ads</strong> editions. See the <a href="http://www.longtailvideo.com/jw-player/license/jw-player-license-text">JW Player 6 License</a> for further details.</dd>
<dt>JW Player Pro</dt>
<dd>
Under the terms of our <a href="http://www.longtailvideo.com/jw-player/license/jw-player-license-text">Commercial License</a>, you can deploy your copy of JW Player <strong>Pro</strong> for commercial use on 1 domain.  See our <a href="http://www.longtailvideo.com/jw-player/pricing/">pricing page</a> for more information on edition features and pricing.
</dd>
<dt>JW Player Premium</dt>
<dd>
  Under the terms of our <a href="http://www.longtailvideo.com/jw-player/license/jw-player-license-text">Commercial License</a>, you can deploy your copy of JW Player <strong>Premium</strong> for commercial use on up to 10 domains. See our <a href="http://www.longtailvideo.com/jw-player/pricing/">pricing page</a> for more information on edition features and pricing.
</dd>
<dt>JW Player Ads</dt>
<dd>
Under the terms of our <a href="http://www.longtailvideo.com/jw-player/license/jw-player-license-text">Commercial License</a>, you can deploy your copy of JW Player <strong>Ads</strong> for commercial use on up to 10 domains, with an additional restriction of up to 250.000 filled ad impressions per month. See our <a href="http://www.longtailvideo.com/jw-player/pricing/">pricing page</a> for more information on edition features and price.</dd>
</dl>

<p>Examples of <strong>commercial use</strong> includes websites with any advertisements, websites owned or operated by businesses, websites designed to promote products or services, and tools (e.g. a CMS) that bundle JW Player in their offering.</p>

<p>Note all editions of JW Player incorporate the <a href="http://www.movable-type.co.uk/scripts/tea-block.html">Block TEA library</a> from Movable Type (CC-BY license).</p>


</body>
</html>