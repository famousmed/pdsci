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
</script>

<div id="main">   
<div class="mainright">
<div class="content">
		<div class="title1 clearfix">
			<ul id="tags">
				<li class="selectTag"><a onclick="selectTag('tagContent0',this)" href="javascript:void(0)">基本信息</a></li>
				<li><a onclick="selectTag('tagContent1',this)" href="javascript:void(0)">附件清单</a></li>
			</ul>
			
	        <div id="tagContent" style="margin-top: 10px;border:none;">
				<!-- 一、信息表 -->
	            <div class="tagContent selectTag" id="tagContent0" style="padding-top: 0px;">
					<jsp:include page="step1.jsp">
						<jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/>
					</jsp:include>
	            </div>
	            
	            <div class="tagContent" id="tagContent1" style="padding-top: 0px;">
					<jsp:include page="step2.jsp">
						<jsp:param  name="view" value="${ GlobalConstant.FLAG_Y}"/>
					</jsp:include>
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
