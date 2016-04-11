<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_form" value="false" />
	<jsp:param name="jquery_ui_tooltip" value="true" />
	<jsp:param name="jquery_ui_combobox" value="false" />
	<jsp:param name="jquery_ui_sortable" value="false" />
	<jsp:param name="jquery_cxselect" value="true" />
	<jsp:param name="jquery_scrollTo" value="false" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="false" />
	<jsp:param name="jquery_datePicker" value="false" />
	<jsp:param name="jquery_fullcalendar" value="false" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="false" />
	<jsp:param name="jquery_placeholder" value="false" />
	<jsp:param name="jquery_iealert" value="false" />
</jsp:include>

<style type="text/css">
.top-tab,.content{}
.top-innder{ position:relative; height:50px;}
.top-sx{position: absolute;display: block;top: 50%; margin-top: -16px; left:35px;}
.sch{width:245px;height: 216px;float:left;margin-right: 10px;border:1px #ccc solid;margin-top: 15px;cursor: pointer;}
.sch_top{padding:10px;border-bottom:1px #ccc solid;height: 46px;}
.sch_top h3{margin-bottom: 5px; color:#3d91d5; font-size:15px; font-weight:normal;}
.sch_top p,.reorder p{color:#5A5A5A;}
.sch_img_1{width:48px;float: right;margin-top: -29px;margin-left: -16px;}
.sch_img{width:48px;float: right;margin-top: -10px;margin-right: -16px;}
.sch_title,.sch_info{float:left;margin-left: 10px;width:157; color:#A3A3A3;}
.sch_body{clear: both; padding:10px 10px;height: 60px;}
.sch_jd{width:55px;float: left;height:60px;line-height: 46px;text-align: center;vertical-align: middle;}
.sch_date{clear: both;text-align: center;width:245px;height: 40px;padding-top:15px;color: #A3A3A3;}
.sch_date_item{width:90px;height: 30px;text-align: center;vertical-align: middle;display:inline-block; line-height: 30px;border:1px #ccc solid; color:#A8A8A8; margin-right: 10px;}
.sch_info p{margin-bottom: 5px;}
.btn-group, .btn-group-vertical {
position: relative;
display: inline-block;
vertical-align: middle;
}
.select{ padding:4px 0;vertical-align: middle;border: 1px solid #e7e7eb;border-radius: 3px;-moz-border-radius: 3px;-webkit-border-radius: 3px;font-size: 14px; color:#363636; font-family: "Microsoft YaHei";}
.btn-sm{padding:0;line-height: 50px;}
.icon-th-large{background:url("<s:url value='/css/skin/${skinPath}/images/th_larger_g.png'/>"); background-repeat:no-repeat; background-position: 0px center;padding: 12px 22px; }
.icon-reorder{background:url("<s:url value='/css/skin/${skinPath}/images/reorder_w.png'/>"); background-repeat:no-repeat; background-position: 0px center;padding: 12px 22px; }
.icon-large{background:url("<s:url value='/css/skin/${skinPath}/images/th_larger_w.png'/>"); background-repeat:no-repeat; background-position: 0px center;padding: 12px 22px; }
.icon-th-reorder{background:url("<s:url value='/css/skin/${skinPath}/images/reorder_g.png'/>"); background-repeat:no-repeat; background-position: 0px center;padding: 12px 22px; }
.reorder{border: 1px solid #ddd;width: 100%;margin-bottom: 20px;height: 82px;cursor: pointer;}
.reorder h3{color:#3d91d5;font-size: 18px; font-weight:normal;}
.list,li{list-style:none; margin:0; padding:0;}  
.scroll{ width:500px; height:25px; overflow:hidden; }  
.scroll li{ width:500px; height:25px; line-height:25px; overflow:hidden;}  
.scroll li a{ font-size:14px;color:#333; text-decoration:none;}  
.scroll li a:hover{ text-decoration:underline;}  
.module-tabs{ height:49px; line-height:49px; font-size:15px; color:6e6e6e; border-bottom:1px solid #dadada}
.module-tabs li{ float:left;  cursor:pointer;display:block;}
.module-tabs .type li{padding:0 15px;}
.module-tabs li.on{ height:48px; border-bottom:2px solid #009fff; color:#009fff;}
.module-tabs li a{padding:8px 15px;}
.module-tabs li a.hove1{ height:48px; color:#fff; padding:8px 15px;  background:#009fff;}
.module-tabs li a:hover{color:#000;text-decoration:none;}
.fl{ float:left;}
.fr{ float:right;}
.module-content{ margin-top:10px;}
.module-content ul li{ display:none;}
.module-content ul li dl{ margin-left:20px; width:368px;}
.module-content ul li{background:#fff; overflow:hidden; border:1px solid #dfdfdf; position:relative; margin-bottom:10px;}
.module-content ul li dt{ line-height:40px; color:#000; font-size:15px; margin-bottom:12px;}
.module-content li dd p{ color:#9e9e9e; line-height:25px;}
.module-content dd div{ line-height:30px;}
.module-content dd div img{ vertical-align:middle;}
.module-content .btn{ position:absolute; right:10px; bottom:10px; height:30px; padding:0 24px;}
.module-content dt .fr{margin-right:10px;}
.module-content .lessonimg{border:4px solid #fff;cursor:default;}
.i-bnt{padding:1px 10px; line-height:22px;color:#242424;background:#f2d6aa; font-size:12px;border-radius:2px;border: 0;}
.b-bnt{padding:1px 10px; line-height:22px;color:#242424;background:#9cd9ea; font-size:12px;border-radius:2px;border: 0;}
.r-bnt{padding:1px 10px; line-height:22px;color:#242424;background:#f2b8ae; font-size:12px;border-radius:2px;border: 0;}
.btn{ height:40px; padding:0 15px; color:#fff; font-size:14px; background:#ffb433; cursor:pointer; border-radius:4px; margin-top:45px;border: 0;}
.module-content .graph{width:142px;background:#dadada;vertical-align:middle;height:11px;border-radius:5px;display:inline-block;}
.module-content #bar {
background: #f7a947;
float: left;
height: 11px;
border-radius: 5px;
}

table.basic th,table.basic td{text-align: center;padding: 0;}
</style>
<script type="text/javascript">
	//记录已选标签
	var hisSel = {};
	
	$(function(){
		//加载默认数据
		search();
	});
	
	//筛选条件自动加载
	function search(){
		$(".hove1").click();
	}
	
	//选择大类
	function checkType(type){
		var status = type.id;
		
		$(".on").removeClass("on");
		$(type).addClass("on");
		
		$(".fr").hide();
		$(".fr."+status).show();
		
		var statiusId = hisSel[status] || $(".fr."+status+" li:first a")[0].id;
		$("#"+statiusId).click();
	}
	
	//选择小类
	function checkStatus(status){
		var parentStatus = $(".on")[0].id;
		
		$(".hove1").removeClass("hove1");
		$(status).addClass("hove1");
		
		hisSel[parentStatus] = status.id;
		
		loadData();
	}
	
	//加载数据
	function loadData(){
		var data = $("#doctorSearchForm").serialize();
		jboxPost("<s:url value='/res/manager/rotationChangeList'/>?type="+$(".hove1")[0].id,data,function(resp){
			if(resp){
				$("#doctorData").html(resp);
			}
		},null,false);
	}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<form id="doctorSearchForm">
				<table class="basic" style="width:100%;margin-top: 10px;">
				<tr><td style="text-align: left;padding-left:10px;">
<!-- 					人员类型： -->
<!-- 					<select name="doctorCategoryId" style="width: 100px;" onchange="search();"> -->
<!-- 						<option/> -->
<%-- 						<c:forEach items="${recDocCategoryEnumList}" var="category"> --%>
<%-- 							<c:set var="res_doctor_category_key" value="res_doctor_category_${category.id }"/> --%>
<%-- 							<c:if test="${sysCfgMap[res_doctor_category_key]==GlobalConstant.FLAG_Y}"> --%>
<%-- 							<option value="${category.id}">${category.name}</option> --%>
<%-- 							</c:if> --%>
<%-- 						</c:forEach> --%>
<!-- 					</select> -->
<!-- 					&#12288; -->
					届数：
					<select name="sessionNumber" style="width: 100px" onchange="search();">
						<option></option>
						<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
							<option value="${dict.dictName}">${dict.dictName}</option>
						</c:forEach>
					</select>
					&#12288;
					培训专业：
					<select name="trainingSpeId" style="width: 100px" onchange="search();">
						<option></option>
						<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
							<option value="${dict.dictId}">${dict.dictName}</option>
						</c:forEach>
					</select>
					&#12288;
					医师姓名：
					<input name="doctorName" type="text" value="" style="width: 100px;" onchange="search();"/>
					</td></tr>
				</table>
			</form>
			<div class="top-tab">
			 	<div class="module-tabs" style="display: block;width: 100%;">
					<ul class="fl type">
						<li id="out" onclick="checkType(this);" class="on">转出</li>
					   	<li id="in" onclick="checkType(this);">转入</li>
					</ul>
					<ul class="fr in" style="display: none;">
					    <li>
					    	<a id="willIn" onclick="checkStatus(this);">
					    		待转入
					    	</a>
					    </li>
						<li>
							<a id="isIn" onclick="checkStatus(this);">
								已转入
							</a>
						</li>
			        </ul>
					<ul class="fr out">
					    <li>
					    	<a id="toOut" onclick="checkStatus(this);" class="hove1">
					    		转出医师
					    	</a>
					    </li>
						<li>
							<a id="outing" onclick="checkStatus(this);">
								转出中
							</a>
						</li>
						<li>
							<a id="isOut" onclick="checkStatus(this);">
								已转出
							</a>
						</li>
			        </ul>
			    </div>
				<div class="content" id="courseContent" style="padding-left: 0;">
					<div id="doctorData" class="module-content" style="width: 100%;">
						
		           	</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>