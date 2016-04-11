var	playserWaitTime;//计时器
var randomTime=-1;//随机验证秒数
var isConfirm = false;
var thePlayer;
var nowSecond;//当前播放秒数
var nowMinutes;//当前播放分钟数
var interval;
var nowTimeInterval;//保存当前播放时间的计时器
var isRun = false;
var sec;
var timer;
var isFinish="";
var nowChapterFlow="";
var isSave=false;
var firstPlayFlag="Y";
var currTime="";
function initPlayer(chapterFlow,control,validation,sysUrl,saveFlag,streamUrl){
	nowChapterFlow=chapterFlow;
	var controls = false;
	if(control=="Y"){
		controls = true;
	}
	var isValidation = true;
	if(validation=="N"){
		isValidation = false;
	}
	if(saveFlag=='Y'){
		isSave=true;
	}
	var url = rootPath()+"/resedu/course/chapterData?chapterFlow="+chapterFlow;
	jboxPost(url,null,function(data){
		if(data){
			var startImg;
			if(data['chapter'].chapterImg==""){
				startImg=rootPath()+"/js/jwplayer/player.jpg";
			}else{
				startImg=sysUrl+data['chapter'].chapterImg;
			}
			var fileUrl=streamUrl+data['chapter'].chapterFile;
			currTime=data['currTime'];
			//jwplayer.logo=rootPath()+"/js/jwplayer/logo.png"; 
			//jwplayer.url="http://www.njpdkj.com/";
			thePlayer =  jwplayer("myPlayer").setup({
				flashplayer: rootPath()+"/js/jwplayer/jwplayer.flash.swf",
				image: startImg,
				controls: controls,
		        file:fileUrl,
		        //title: '',
				//description: "",	
				controlbar: "bottom",  //控制条位置	//controlbar: "bottom",controlbar: "none"
				screencolor: "#fff",   //播放器颜色
				stretching: "fill",    //画面自适应
				repeat:"",       //always 重复播放
				width: "100%",
				aspectratio: "16:9",
				events: {
				 onReady: function(event) {
					 firstPlayFlag="N";
					 this.play();
					 $("#nowSecond").html(data['nowSecond']);
					 $("#nowMinutes").html(data['nowMinutes']);
					 $("#video_length").html(data['chapter'].chapterTime);//设置视频右下方总时长
				 },
				 onComplete : function() {
					$("#play_length").html($("#video_length").html());//解决输入验证码后播放完成时间比总时间晚一秒问题	
					$("#completeShowBox").show();
					stopClock();
					isFinish='Y';
					completeVideo();
					},
				 onTime:function(event) {
						if(randomTime==-1){
							randomVerify();
						}else {
							if (parseInt(event.position) == randomTime && !isConfirm && isValidation) {
								thePlayer.play(false);
								$("#randomConfirm").show();
								//设置定时器,验证码X秒后未输入，重新播放视频
								timer=setInterval("setSec()",1000);
								$("#playButton").unbind("click");
							}
						}
					},
				  onPlay:function() {
					  if(firstPlayFlag=="N" && parseFloat(data['currTime'])>0){
						  setTimeout("seeeeeek()",500);
						  firstPlayFlag="Y";
					  }
					  startClock();
				  },
				  onPause:function(){
					  stopClock();
				  }
				},
				plugins: {
				    sharing: {link:true}
				}
		    });
			jwplayer().onReady(function() {
				if (window.location.hash) {
					var offset = window.location.hash.substr(3);
					thePlayer.seek(offset);
				}
			});
		//播放/暂停按钮控制
			bindPlayEvent();
		}
	},null,false);
	
}

function seeeeeek(){
	thePlayer.seek(currTime);
}
//保存播放时间
function savePlayTime(){
	if(isSave==true){
		nowSecond =  $.trim($("#nowSecond").html());
		nowMinutes = $.trim($("#nowMinutes").html());
		var url=rootPath()+"/resedu/course/saveVideoTime?chapterFlow="+nowChapterFlow+"&nowMinutes="+nowMinutes+"&nowSecond="+nowSecond;
		jboxPostNoLoad(url,null,function(resp){
		},null,false);
	}
}
//视频看完后
function completeVideo(){
		var url=rootPath()+"/resedu/course/completeVideo?chapterFlow="+nowChapterFlow;
		jboxPost(url,null,function(resp){
		},null,false);
}

function KeyOn_Space(ev){     //JW Player 空格控制播放暂停<body onKeyDown="KeyOn_Space(event);">
    ev = ev || window.event;    
    var code = (ev.keyCode || ev.which);   
    if(code == 32) {  
        jwplayer('myElement').pause();  
    }  
}
function reloadVerifyCode(){
	$("#verifyImage").attr("src",rootPath()+"/captcha?random="+Math.random());
}
function doContinue(){
	var form=$("#randForm");
	var url=rootPath()+"/resedu/course/checkVerifyCode";
	if(form.validationEngine("validate")){
		jboxPost(url,form.serialize(),function(resp){
			if(resp=="Y"){
				thePlayer.play(true);
				$("#randomConfirm").hide();
				isConfirm = true;
				clearInterval(timer);
				bindPlayEvent();
			}else {
				jboxTip("验证码输入错误！");
			}
		},function(){
			reloadVerifyCode();
		},false);
	}
}
/*生成随机秒数*/
function randomVerify(){
	var min = 10;
	var max = parseInt(thePlayer.getDuration());
	randomTime = getRandomNum(min,max);
}
/*function paseTime(time){
	alert(time);
	time = parseInt(time);
	alert(time);
	var minutes = time / 60;
	var second = time % 60;
	if(minutes<10){
		minutes = "0"+minutes;
	}
	if(second<10){
		second = "0"+second;
	}
	return minutes+":"+second;
}*/
/*重新播放*/
function doRestart(){
	var url=rootPath()+"/resedu/course/completeVideo?chapterFlow="+nowChapterFlow;
	jboxPost(url,null,function(resp){
		window.location.reload();
	},null,false);
	
}
function getRandomNum(Min,Max){ 
    var Range = Max - Min; 
    var Rand = Math.random(); 
    return(Min + Math.round(Rand * Range)); 
}
/*开始计时*/
function startClock(){
   if(!isRun){
		nowSecond =  $.trim($("#nowSecond").html());
		nowMinutes = $.trim($("#nowMinutes").html());
    interval = setInterval('runclick()',1000);
    nowTimeInterval=setInterval("savePlayTime()",3000);
    isRun = true; 
   	}
  }
/*暂停计时*/
function stopClock(){
  	if(isRun){
  		clearInterval(interval);
  		clearInterval(nowTimeInterval);
  		isRun = false; 
  		}
 }
/*计时器*/
function runclick(){
   nowSecond = parseInt(nowSecond) + 1;
   //小于十秒
   if(nowSecond < 10){
    $("#nowSecond").html('0' + nowSecond);
   }else{
    if(nowSecond == 60){
     nowSecond = '00';
	}
    $("#nowSecond").html(nowSecond);
	   }
	   //大于59秒
	   if(nowSecond == 0){
	    nowMinutes = parseInt(nowMinutes) + 1;
	    nowSecond = 0;
	    if(nowMinutes < 10){
	     $("#nowMinutes").html('0' + nowMinutes);
	}else{
	 $("#nowMinutes").html(nowMinutes);
    }
	    
   }
}
function setVolume(volume){
	jwplayer("myPlayer").setVolume(volume);
}
function setSec(){
	sec=parseInt($("#sec").text());
	
	if(sec<=1){
		doRestart();
	}
	if(sec>=1){
		sec=sec-1;	
	}
	
	$("#sec").text(sec);
}
/*设置静音*/
function setMute(obj){
	var volume =  jwplayer("myPlayer").getVolume();
	var $obj = $(obj);
	if(volume>0){
		jwplayer("myPlayer").setVolume(0);
		$obj.attr("class","video-m");
		$obj.attr("title","取消静音");
		$("#mySlider").slider("value",[0]);
		$("#mySlider").slider("disable");
	}else{
		jwplayer("myPlayer").setVolume(70);
		$obj.attr("class","video-j");
		$obj.attr("title","静音");
		$("#mySlider").slider("enable");
		$("#mySlider").slider("value",[70]);
	}
}
function bindPlayEvent(){
	$("#playButton").click(function() {
		if (thePlayer.getState() != 'PLAYING') {
			thePlayer.play(true);
			$(this).parent().attr("class","video-pause");
		} else {
			thePlayer.play(false);
			$(this).parent().attr("class","video-play");
		}
	});
}

