<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>

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
	$(document).ready(function(){
		$("#tags").find("li:first").addClass("selectTag");
		$(".tagContent:first").show();
	});
	
</script>

<div id="main">   
<div class="mainright">
<div class="content">
		<div class="title1 clearfix">
			<ul id="tags">
				<c:if test="${expertFlag!=GlobalConstant.FLAG_Y}">
					<li><a id="0" onclick="selectTag('tagContent0',this)" href="javascript:void(0)">基础信息</a></li>
				</c:if>
				<li><a onclick="selectTag('tagContent1',this)" href="javascript:void(0)">申请人简历</a></li>
				<li><a onclick="selectTag('tagContent2',this)" href="javascript:void(0)">项目信息</a></li>
				<li><a onclick="selectTag('tagContent3',this)" href="javascript:void(0)">年度计划及目标</a></li>
				<li><a onclick="selectTag('tagContent4',this)" href="javascript:void(0)">单位及合作单位的意见</a></li>
				<li><a onclick="selectTag('tagContent5',this)" href="javascript:void(0)">项目组成员</a></li>
				<li><a onclick="selectTag('tagContent6',this)" href="javascript:void(0)">经费预算</a></li> 
				<li><a onclick="selectTag('tagContent7',this)" href="javascript:void(0)">附件清单</a></li> 
			</ul>
			
	        <div id="tagContent" style="margin-top: 30px;border:none;">
				<!-- 一、信息表 -->
				<c:if test="${expertFlag!=GlobalConstant.FLAG_Y}">
	            <div class="tagContent " id="tagContent0" style="padding-top: 0px;">
					<jsp:include page="step1.jsp">
						<jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/>
					</jsp:include>
	            </div>
	            </c:if>
	            <div class="tagContent " id="tagContent1" style="padding-top: 0px;">
					<jsp:include page="step2.jsp">
						<jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/>
					</jsp:include>
	            </div>
	            
	            <div class="tagContent" id="tagContent2" style="padding-top: 0px;">
					<jsp:include page="step3.jsp">
						<jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/>
					</jsp:include>
	            </div>
	           
	            <div class="tagContent" id="tagContent3" style="padding-top: 0px;">
					<jsp:include page="step4.jsp">
						<jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/>
					</jsp:include>
	            </div>
	            
	            <div class="tagContent" id="tagContent4" style="padding-top: 0px;">
					<jsp:include page="step5.jsp">
						<jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/>
					</jsp:include>
	            </div>
	            
	            <div class="tagContent" id="tagContent5" style="padding-top: 0px;">
					<jsp:include page="step6.jsp">
						<jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/>
					</jsp:include>  
	            </div>
	            
	            <div class="tagContent" id="tagContent6" style="padding-top: 0px;">
					<jsp:include page="step7.jsp">
						<jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/>
					</jsp:include>
	            </div>
	            
	            <div class="tagContent" id="tagContent7" style="padding-top: 0px;">
					<jsp:include page="step8.jsp">
						<jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/>
					</jsp:include>
	            </div>
        	</div>
   		</div>
		<p>
		    <script type="text/javascript">
		        function selectTag(showContent, selfObj) {
		        	$(".selectTag").removeClass("selectTag");
		        	$(selfObj).parent().addClass("selectTag");
		        	$(".tagContent").hide();
		        	$("#"+showContent).show();
		        }
		    </script>
		</p>
</div>
</div>
</div>
