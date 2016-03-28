<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script type="text/javascript">
	$(function(){
		$(".redspan").hide();
		$('input').attr("readonly","readonly");
		$('textarea').attr("readonly","readonly");
		$("select").attr("disabled", "disabled");
		$(":checkbox").attr("disabled", "disabled");
		$(":radio").attr("disabled", "disabled");
		$(".ctime").removeAttr("onclick");
	});
	function back() {
		history.back();
	}
</script>

<style type="text/css">
	.line {border: none;}
	#fund td{text-align: center;}
</style>

</head>
<body>
<div id="main">   
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
          <ul id="tags">
            <li class="selectTag"><a onclick="selectTag('tagContent0',this)" href="javascript:void(0)">学科概况</a></li>
            <li><a onclick="selectTag('tagContent1',this)" href="javascript:void(0)">学科带头人</a></li>
            <li><a onclick="selectTag('tagContent2',this)" href="javascript:void(0)">主要业绩</a></li>
            <li><a onclick="selectTag('tagContent3',this)" href="javascript:void(0)">学科成员</a></li>
            <li><a onclick="selectTag('tagContent4',this)" href="javascript:void(0)">学科项目</a></li>
            <li><a onclick="selectTag('tagContent5',this)" href="javascript:void(0)">学科成果</a></li>
            <li><a onclick="selectTag('tagContent6',this)" href="javascript:void(0)">学会任职</a></li> 
            <li><a onclick="selectTag('tagContent7',this)" href="javascript:void(0)">实验室设备</a></li> 
            <li><a onclick="selectTag('tagContent8',this)" href="javascript:void(0)">协作单位</a></li> 
            <li><a onclick="selectTag('tagContent9',this)" href="javascript:void(0)">经费预算</a></li>
            <li><a onclick="selectTag('tagContent10',this)" href="javascript:void(0)">附件</a></li> 
          </ul>
        <div id="tagContent" style="margin-top: 10px;border:none;">
            <div class="tagContent selectTag" id="tagContent0" style="padding-top: 0px;">
            	  <jsp:include page="introduction.jsp">
            	  	<jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/>
            	  </jsp:include>
            </div>
            <%-- 重点学科带头人概况 --%>
            <div class="tagContent" id="tagContent1" style="padding-top: 0px;">
            	   <jsp:include page="chief.jsp">
            	   	<jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/>
            	   </jsp:include>
            </div>
            
            <%-- 重点学科带头人主要业绩 --%>
            <div class="tagContent" id="tagContent2" style="padding-top: 0px;">
            	   <jsp:include page="achievement.jsp">
            	   	<jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/>
            	   </jsp:include>
            </div>
           
            <%-- 重点学科人员信息 --%>
            <div class="tagContent" id="tagContent3" style="padding-top: 0px;">
            	    <jsp:include page="personInfo.jsp">
            	    	<jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/>
            	    </jsp:include>
            </div>
            
            <%-- 已完成的市级及以上科研项目 --%>
            <%-- 在研的市级及以上科技项目 --%>
            <div class="tagContent" id="tagContent4" style="padding-top: 0px;">
            	   <jsp:include page="completeProj.jsp"><jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/></jsp:include>
            	   <jsp:include page="researchProj.jsp"><jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/></jsp:include>
            </div>
            
            <%-- 市级及以上科技进步奖 --%>
            <div class="tagContent" id="tagContent5" style="padding-top: 0px;">
            	    <jsp:include page="progressPraise.jsp"><jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/></jsp:include>
            	    <jsp:include page="SCIAndThesis.jsp"><jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/></jsp:include>
            	    <jsp:include page="patentAndCertificate.jsp"><jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/></jsp:include>
            	    <jsp:include page="monograph.jsp"><jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/></jsp:include>
            </div>
            
            <%-- 学会任职情况 --%>
            <div class="tagContent" id="tagContent6" style="padding-top: 0px;">
            	    <jsp:include page="academic.jsp"><jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/></jsp:include>
            </div>
            
            <%-- 专用实验室设备 --%>
            <div class="tagContent" id="tagContent7" style="padding-top: 0px;">
            	  <jsp:include page="laboratoryEquipment.jsp"><jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/></jsp:include>
            </div>
            
            <%-- 协作单位（科室）相关材料 --%>
            <div class="tagContent" id="tagContent8" style="padding-top: 0px;">
            	  <jsp:include page="cooperationOrg.jsp"><jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/></jsp:include>
            </div>
            
            <%-- 经费预算 --%>
            <div class="tagContent" id="tagContent9" style="padding-top: 0px;">
            	  <jsp:include page="fundsBudget.jsp"><jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/></jsp:include>
            </div>
            
            <%-- 附件 --%>
            <div class="tagContent" id="tagContent10" style="padding-top: 0px;">
            	  <jsp:include page="step15.jsp"><jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/></jsp:include>
            </div>
        </div>
    </div>
        <p>
        <script type="text/javascript">
            function selectTag(showContent, selfObj) {
                // 操作标签
                var tag = document.getElementById("tags").getElementsByTagName("li");
                var taglength = tag.length;
                for (i = 0; i < taglength; i++) {
                    tag[i].className = "";
                }
                selfObj.parentNode.className = "selectTag";
                // 操作内容
                for (i = 0; j = document.getElementById("tagContent" + i); i++) {
                    j.style.display = "none";
                }
                document.getElementById(showContent).style.display = "block";
            }
        </script>
    </p>
      </div>
    </div>
</div>
</body>
</html>