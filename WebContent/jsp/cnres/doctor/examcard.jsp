<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>国家住院医师规范化培训示范性基地招录系统</title>
<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>

<script type="text/javascript">
function pt(){
	window.print();
}

function down() {
	var url ="<s:url value='print'/>?watermarkFlag=${GlobalConstant.FLAG_N}&recTypeId=ExamCard";
 	window.location.href=url;
}

function downPdf() {
	/* var url ="<s:url value='print'/>?watermarkFlag=${GlobalConstant.FLAG_N}&recTypeId=ExamCard&printType=pdf"; */
	var url = "<s:url value='downPdfExamCard'/>";
 	window.location.href=url;
}
</script>
</head>
<style media=print type="text/css">   
.noprint{visibility:hidden}   
</style>  

<body>
  <div class="main_wrap">
    <div class="user-contain">
      <p class="ticket_title">2015年国家住院医师规范化培训招录考试第一阶段（笔试）</p>
      <h5>准考证</h5>
      <div class="user-bd">
        <table cellpadding="0" cellspacing="0" border="0" class="form_tab" style="width:93%;margin:0 auto;">
          <colgroup>
            <col width="18%" />
            <col width="20%" />
            <col width="10%" />
            <col width="20%" />
            <col width="32%" />
          </colgroup>
          <tr class="odd">
            <th>姓&#12288;&#12288;名：</th>
            <td style=" border-bottom:1px solid #ccc;">${user.userName}</td>
            <th>性&#12288;&#12288;别：</th>
            <td style=" border-bottom:1px solid #ccc;">${user.sexName}</td>
            <td rowspan="6" style="padding-left: 20px;">
            	<img src="${sysCfgMap['upload_base_url']}/${doctor.doctorHeadImg}" width="140px" height="200px"/>
			</td>
          </tr>
          <tr>
		      <th>身份证号：</th>
              <td style=" border-bottom:1px solid #ccc;">${user.idNo}</td>
			  <th></th>
			  <td></td>
		  </tr>
		  <tr>
		      <th>准考证号：</th>
			  <td style=" border-bottom:1px solid #ccc;">${examDoctor.ticketNum}</td>
			  <th></th>
			  <td></td>
		  </tr>
		  <tr>
		      <th>考点名称：</th>
			  <td style=" border-bottom:1px solid #ccc;">${examDoctor.siteName}</td>
			  <th></th>
			  <td></td>
		  </tr>
		  <tr>
		      <th>考点地址：</th>
			  <td style=" border-bottom:1px solid #ccc;">${examSite.siteAddress}</td>
			  <th></th>
			  <td></td>
		  </tr>
		  <tr>
		      <th>考&nbsp;&nbsp;场&nbsp;&nbsp;号：</th>
			  <td style=" border-bottom:1px solid #ccc;">${examDoctor.roomCode}</td>
			  <th></th>
			  <td></td>
		  </tr>
		  <tr>
		      <th>考试日期：</th>
			  <td style=" border-bottom:1px solid #ccc;">${exam.examDate}</td>
			  <th>考试时间：</th>
			  <td style=" border-bottom:1px solid #ccc;">${exam.examTime}</td>
		  </tr>
        </table>
        
        <div class="rules" id="">
        <p style="line-height: 30px;text-align: center;">
        	<b>考场规则</b>
        </p>
        <p style="line-height: 30px;">
&#12288;&#12288;一、考生必须自觉服从监考员等考试工作人员管理，不得以任何理由妨碍监考员等考试工作人员履行职责，不得扰乱考场及其他工作地点的秩序。<br/>
&#12288;&#12288;二、考生凭《准考证》、《身份证》，按规定的时间，到指定地点参加考试。<br/>
&#12288;&#12288;三、考前15分钟考生开始入场，除书写用黑色签字笔、填涂用2B铅笔、橡皮擦等，不准携带书包、文具盒、自备垫板和任何书籍、报纸、纸张以及其他任何与考试无关物品进入考场。考试正式开始后，迟到考生不准入场。考生中途不得退场，考试结束，试卷和答题卡清点无误后方可离场。<br/>
&#12288;&#12288;严禁携带各种通讯工具（如移动电话）、电子录放器材（如录音笔）以及修正液（带）等物品进入考场。考生在考场内不得自行传递文具用品。<br/>
&#12288;&#12288;四、考生入场后按准考证号对号入座，并将《准考证》、《身份证》（或《临时身份证》）放在座位左上角。得到答题卡和试卷后，应首先核对专业，清点试卷，核对有无漏印、字迹不清或破损，然后在规定位置准确填写和涂划自己的姓名、准考证号。不得在规定位置以外书写姓名、准考号或做记号，违者取消考试成绩。<br/>
&#12288;&#12288;五、如不遵守考场纪律，不服从考试工作人员管理，涉嫌违纪、舞弊等行为的考生，将按照《国家教育考试违规处理办法》及其它有关规定进行处理。</p>
        </div>
        
        <p class="noprint" style="text-align: center;">
        	<!-- 
	        <a onclick="pt();"  class="btn blue-btn" id="pt" target="_self">打印</a>
	        <a onclick="downPdf();"  class="btn blue-btn">pdf下载</a>
        	 -->
	        <a onclick="down();"  class="btn_blue">word下载</a>
        </p>
      </div>
    </div>
  </div>
</body>
</html>
