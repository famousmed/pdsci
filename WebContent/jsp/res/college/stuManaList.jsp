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
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="false" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
</jsp:include>
<style type="text/css">
	table.basic th,table.basic td{ text-align: center;padding: 0; }
	.willC:HOVER {background: #eee;}
	.isSelInfo{background: pink;}
</style>

<script type="text/javascript">
	$(function(){
		$("#detail").slideInit({
			width:800,
			speed:500,
			outClose:function(){
				$(".isSelInfo").removeClass("isSelInfo");
			},
			haveZZ:true
		});
	});
	
	function search(){
		$("#searchForm").submit();
	}
	
	function toPage(page) {
		if(page!=undefined){
			$("#currentPage").val(page);			
		}
		search();
	}
	
	//标签高亮
	function selTag(tag,clazz){
		$(".selectTag").removeClass("selectTag");
		$(tag).addClass("selectTag");
		$(".userInfo tbody").hide();
		$("."+clazz).show();
	}
	
	//打开编辑
	function openEdit(ctr){
		$('#detail').rightSlideOpen();
		$(".isSelInfo").removeClass("isSelInfo");
		$(ctr).addClass("isSelInfo");
	}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/res/platform/stuManaList/${roleFlag}"/>"
				method="post">
				<table class="basic" style="width: 2280px;">
					<tr>
						<td style="padding-left: 10px;text-align: left;">
							人员类型：
							<select name="doctorCategoryId"  onchange="search();" style="width: 80px;">
								<option />
									<c:forEach items="${recDocCategoryEnumList}" var="category">
									<c:set var="res_doctor_category_key" value="res_doctor_category_${category.id }"/>
									<c:if test="${sysCfgMap[res_doctor_category_key]==GlobalConstant.FLAG_Y }">
										<option value="${category.id}" ${param.doctorCategoryId eq category.id?'selected':''}>${category.name}</option>
									</c:if>
									</c:forEach>
							</select>
							&#12288;
							姓名：
							<input type="text" name="sysUser.userName" onchange="search();" style="width: 90px;" value="${param['sysUser.userName']}" class=""/>
							&#12288;
							专&#12288;&#12288;业：
							<select name="trainingSpeId" onchange="search();" style="width: 145px;"> 
								<option />
									<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
									<option value="${dict.dictId}" ${param.trainingSpeId eq dict.dictId?'selected':''}>${dict.dictName}</option>
									</c:forEach>
							</select>
							&#12288;
							届数:
							<select name="sessionNumber" style="width: 60px" onchange="search();" >
								<option></option>
									<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict" varStatus="status">
										<option value="${dict.dictName}" ${(param.sessionNumber eq dict.dictName)?'selected':''}>${dict.dictName}</option>
									</c:forEach>
							</select>
							&#12288;
							学历：
							<select id="educationId" name="sysUser.educationId" onchange="search();" style="width: 70px;">
								<option/>
									<c:forEach items="${dictTypeEnumUserEducationList}" var="dict">
										<option value="${dict.dictId}" ${param['sysUser.educationId'] eq dict.dictId?'selected':''}>${dict.dictName}</option>
								</c:forEach>
							</select>&#12288;<br/>
							培训基地：
							<select name="orgFlow" onchange="search();" style="width: 240px;">
								<option></option>
								<c:forEach items="${applicationScope.sysOrgList}" var="org">
									<option value="${org.orgFlow}" ${param.orgFlow eq org.orgFlow?'selected':''}>${org.orgName}</option>
								</c:forEach>
							</select>
							&#12288;
							身份证号：
							<input type="text" style="width: 140px;" name="sysUser.idNo" onchange="search();" value="${param['sysUser.idNo']}" class=""/>
							&#12288;
<%-- 							<label><input type="checkbox" name="box" onchange="check(this);" value="${GlobalConstant.FLAG_Y}" <c:if test="${param.box eq GlobalConstant.FLAG_Y}">checked</c:if>/> 展示考核信息</label> --%>
							<input id="currentPage" type="hidden" name="currentPage" value=""/>
						</td>
					</tr>
				</table>
			</form>
	 </div>
	 <table class="basic" style="width: 2280px;">
 		<tr>
 			<th rowspan="3" style="min-width: 80px;">姓名</th>
 			<th style="min-width: 80px;" rowspan="3">届别<br>(20**年)</th>
 			<th style="min-width: 50px;"rowspan="3">性别</th>
 			<th style="min-width: 160px;"rowspan="3">学员单位</th>
 			<c:if test="${roleFlag==GlobalConstant.USER_LIST_CHARGE }"> 
 			<th style="min-width: 160px;"rowspan="3">培训基地</th>
 			</c:if>
 			<th style="min-width: 160px;"rowspan="3">身份证号码</th>
 			<th style="min-width: 80px;" rowspan="3">类型<br>(西医,中医)</th>
 			<th style="min-width: 60px;" rowspan="3">学历</th>
 			<th style="min-width: 60px;" rowspan="3">专业</th>
 			<th style="min-width: 80px;" rowspan="3">培训年限</th>
 			<th style="min-width: 100px;" rowspan="3">是否是执行医师</th>
 			<th style="min-width: 110px;" rowspan="3">手机号码</th>
 			<th style="min-width: 800px;" colspan="12">年度考核</th>
 			<th style="min-width: 280px;" colspan="4">结业考核</th>
 		</tr>
 		<tr>
 			<th style="min-width: 200px;" colspan="4">第一年</th>
 			<th style="min-width: 200px;" colspan="4">第二年</th>
 			<th style="min-width: 200px;" colspan="4">第三年</th>
 			<th rowspan="2">公共科目</th>
 			<th rowspan="2">理论知识</th>
 			<th rowspan="2">实践技能</th>
 			<th rowspan="2">考核结果<br>(是否通过)</th>
 		</tr>                     
 		<tr>
 			<th>过程考核<br/>(是否通过)</th>
 			<th>理论考试</th>
 			<th>技能考试</th>
 			<th>考核结果<br/>(是否通过)</th>
 			<th>过程考核<br/>(是否通过)</th>
 			<th>理论考试</th>
 			<th>技能考试</th>
 			<th>考核结果<br/>(是否通过)</th>
 			<th>过程考核<br/>(是否通过)</th>
 			<th>理论考试</th>
 			<th>技能考试</th>
 			<th>考核结果<br/>(是否通过)</th>
 		</tr>
	 	<tbody>
	 		<c:forEach items="${resDocExtList }" var="resDocExtList">
	 			<tr class="willC" title="点击编辑" style="cursor: pointer;" onclick="openEdit(this);">
	 				<td>${resDocExtList.sysUser.userName}</td>
	 				<td>${resDocExtList.sessionNumber}</td>
	 				<td>${resDocExtList.sysUser.sexName}</td>
	 				<td>${resDocExtList.sysUser.orgName}</td>
	 				<c:if test="${roleFlag==GlobalConstant.USER_LIST_CHARGE }"> 
	 				<td>${resDocExtList.orgName}</td>
	 				</c:if>
	 				<td>${resDocExtList.sysUser.idNo}</td>
	 			 	<td></td>
	 				<td>${resDocExtList.sysUser.educationName}</td>
	 				<td>${resDocExtList.trainingSpeName}</td>
	 				<td>${resDocExtList.trainingYears}</td>
	 				<td>${(resDocExtList.doctorLicenseFlag eq GlobalConstant.FLAG_Y)?'是':'否'}</td>
	 				<td>${resDocExtList.sysUser.userPhone}</td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 				<td></td>
	 			</tr>
	 		</c:forEach>
	 		<c:if test="${empty resDocExtList}">
	    			<tr><td colspan="99">无记录</td></tr>
	  		  	</c:if>
	 	</tbody>
	 </table>
 	 <c:set var="pageView" value="${pdfn:getPageView(resDocExtList)}" scope="request"></c:set> 
	<pd:pagination toPage="toPage"/>
	 </div>
	 <div id="detail">
		<div style="width: 100%;height: 100%;padding: 10px;background: white;">
			<ul id="tags">
	      			<li onclick="selTag(this,'assessInfo');" class="selectTag"><a style="cursor: pointer;">考核信息</a></li>
	      			<c:if test="${roleFlag==GlobalConstant.USER_LIST_CHARGE }"> 
	      			<li onclick="selTag(this,'basicInfo');" class=""><a style="cursor: pointer;" >基本信息</a></li>
	      			</c:if>
	        </ul>
	        <div id="tagContent">
	        	<table class="basic userInfo"  style="width:96%; margin: 10px;">
	        	<tbody class="assessInfo">
	        		<tr>
	        			<th  colspan="9">年度考核</th>
	        		</tr>
	        		<tr>
	        			<th colspan="9">第一年</th>
	        		</tr>
	        		<tr>
	        			<td style="width:16%; line-height: 20px;" >过程考核<br>(是否通过)</td>
	        			<td style="width: 10%"><select><option/><option>是</option><option>否</option></select></td>
	        			<td style="width: 10%">理论考试</td>
	        			<td style="width: 10%"><input type="text" class="inputText" value="" style="width: 50px;"/></td>
	        			<td style="width: 10%">技能考试</td>
	        			<td style="width: 10%"><input type="text" class="inputText" value="" style="width: 50px;"/></td>
	        			<td style="width: 10%; line-height: 20px;">考核结果<br>(是否通过)</td>
	        			<td style="width: 10%"><select><option/><option>是</option><option>否</option></select></td>
	        			<td style="width: 10%"><a style="cursor: pointer; color: blue;">审核</a></td>
				    <tr>
	        			<th colspan="9">第二年</th>
	        		</tr>  
	        		<tr>
	        			<td style="line-height: 20px;">过程考核<br>(是否通过)</td>
	        			<td><select><option/><option>是</option><option>否</option></select></td>
	        			<td>理论考试</td>
	        			<td><input type="text" class="inputText" value="" style="width: 50px;"/></td>
	        			<td>技能考试</td>
	        			<td><input type="text" class="inputText" value="" style="width: 50px;"/></td>
	        			<td style="line-height: 20px;">考核结果<br>(是否通过)</td>
	        			<td><select><option/><option>是</option><option>否</option></select></td>
	        			<td><a style="cursor: pointer; color: blue;">审核</a></td>
	        		<tr>
	        			<th colspan="9">第三年</th>
	        		</tr>  
	        		<tr>
	        			<td style="line-height: 20px;">过程考核<br>(是否通过)</td>
	        			<td><select><option/><option>是</option><option>否</option></select></td>
	        			<td>理论考试</td>
	        			<td><input type="text" class="inputText" value="" style="width: 50px;"/></td>
	        			<td>技能考试</td>
	        			<td><input type="text" class="inputText" value="" style="width: 50px;"/></td>
	        			<td style="line-height: 20px;">考核结果<br>(是否通过)</td>
	        			<td><select><option/><option>是</option><option>否</option></select></td>
	        			<td><a style="cursor: pointer; color: blue;">审核</a></td>
	        		</tr>
	        		<tr>
	        			<th  colspan="9">结业考核</th>
	        		</tr> 
	        		<tr>
	        			<td>公共科目</td>
	        			<td><select><option/><option>是</option><option>否</option></select></td>
	        			<td>理论知识</td>
	        			<td><input type="text" class="inputText" value="" style="width: 50px;"/></td>
	        			<td>实践技能</td>
	        			<td><input type="text" class="inputText" value="" style="width: 50px;"/></td>
	        			<td style="line-height: 20px;">考核结果<br>(是否通过)</td>
	        			<td><select><option/><option>是</option><option>否</option></select></td>
	        			<td><a style="cursor: pointer; color: blue;">审核</a></td>
	        		</tr>
	        	</tbody>
	        		<c:if test="${roleFlag==GlobalConstant.USER_LIST_CHARGE }"> 
			        	<tbody class="basicInfo" style="display: none;">	
			        		<tr>
			        			<td colspan="2">学员单位</td>
			        			<td colspan="2" style="text-align: left;padding-left: 10px;">
			        				<select style="width: 150px;">
			        					<option/>
			        					<c:forEach items="${applicationScope.sysOrgList}" var="org">
			        						<option value="${org.orgFlow}">${org.orgName}</option>
			        					</c:forEach>
			        				</select>
			        			</td>
			        			<td colspan="2">培训基地</td>
			        			<td colspan="2" style="text-align: left;padding-left: 10px;">
			        				<select style="width: 150px;">
			        					<option/>
			        					<c:forEach items="${applicationScope.sysOrgList}" var="org">
			        						<option value="${org.orgFlow}">${org.orgName}</option>
			        					</c:forEach>
			        				</select>
			        			</td>
			        		</tr>
			        		<tr>
			        			<td colspan="2">类型</td>
			        			<td colspan="2" style="text-align: left;padding-left: 10px;">
			        				<select style="width: 150px;">
			        					<option/>
			        					<option>中医</option>
			        					<option>西医</option>
			        				</select>
			        			</td>
			        			<td colspan="2">培训学科</td>
			        			<td colspan="2" style="text-align: left;padding-left: 10px;">
			        				<select style="width: 150px;">
			        					<option/>
			        					<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
			        						<option value="${dict.dictId}">${dict.dictName}</option>
			        					</c:forEach>
			        				</select>
			        			</td>
			        		</tr>
			        		<tr>
			        			<td colspan="2">是否执业医师</td>
			        			<td colspan="6" style="text-align: left;padding-left: 10px;">
			        				<label>
			        					<input type="radio" name="doctorLicenseFlag"> 是
			        				</label>
			        				&#12288;
			        				<label>
			        					<input type="radio" name="doctorLicenseFlag"> 否
			        				</label>
			        			</td>
			        		</tr>
			        	</tbody>
	        		</c:if>
	        	</table>
	        	<div style="margin-top: 10px;text-align: center;margin-bottom: 10px;">
	        		<input type="button" value="关&#12288;闭" class="search" onclick="$('#detail').rightSlideClose(function(){$('.isSelInfo').removeClass('isSelInfo');});"/>
	        	</div>
	        </div>	
		</div>
	 </div>
	 </div>
</body>
</html>