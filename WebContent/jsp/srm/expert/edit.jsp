<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ztree" value="true"/>
</jsp:include>
<script type="text/javascript">
var setting = {
		view: {
			dblClickExpand: false,
			showIcon: false,
			showTitle:false,
			selectedMulti:false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			beforeClick: beforeClick,
			onClick: onClick
		}
	};

	function beforeClick(treeId, treeNode) {
		var check = (treeNode.id!=0);
		if (!check) jboxTip('不能选择根节点');
		return check;
	}

	function onClick(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
		nodes = zTree.getSelectedNodes(),
		v = "";
		id = "";
		nodes.sort(function compare(a,b){return a.id-b.id;});
		for (var i=0, l=nodes.length; i<l; i++) {
			v += nodes[i].name + ",";
			id += nodes[i].id + ",";
		}
		if (v.length > 0 ) v = v.substring(0, v.length-1);
		if (id.length > 0 ) id = id.substring(0, id.length-1);
		var cityObj = $("#majorName");
		$("#majorId").val(id);
		cityObj.attr("value", v);
	}
function save(){
	if(false==$("#expertForm").validationEngine("validate")){
		return ;
	}
	var url = "<s:url value='/srm/expert/save'/>";
	jboxStartLoading();
	jboxPost(url , $('#expertForm').serialize() , function(){
		window.parent.frames['mainIframe'].location.reload(true);
		doClose();
	} , null , true);
}

function doClose() {
	jboxClose();
}
function showMenu() {
	var cityObj = $("#majorName");
	var cityOffset = $("#majorName").offset();
	$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
	$("body").bind("mousedown", onBodyDown);
}
function hideMenu() {
	$("#menuContent").fadeOut("fast");
	$("body").unbind("mousedown", onBodyDown);
}
function onBodyDown(event) {
	if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
		hideMenu();
	}
}
$(document).ready(function(){
	var url = "<s:url value='/sys/subject/getAllDataJson'/>";
	jboxPostJson(url,null,function(data){
    	if(data){
			zNodes = $.parseJSON(data);
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);//所属学科
		}
    },null,false);
});

</script>
</head>
<body>
<div class="mainright">
   <div class="content">
     <div class="title1 clearfix">
	<form id="expertForm" method="post">
		<table class="basic" style="width: 100%;">
			<tr class="bs_name" style="height: 26px">
		   		 <td style="text-align:left" colspan="8">修改专家信息</td>
		    </tr>
			<tr>
				<th>用户名：</th>
				<td>
					<%-- 用户流水号  --%>
					<input id="userFlow" type="hidden" name="userFlow" value="${user.userFlow}"/>
					${user.userCode}
				</td>
				<th>姓名：</th>
				<td>
					<input name="userName" class="validate[required] xltext" value="${user.userName}" type="text"  />
					<font color="red">*</font>
				</td>
			</tr>
			<tr>
				<th>性别：</th>
				<td>
					<input id="${userSexEnumMan.id }" class="validate[required]" type="radio" name="sexId"  value="${userSexEnumMan.id }" <c:if test="${userSexEnumMan.id == user.sexId}">checked</c:if> />
                    <label for="${userSexEnumMan.id }">${userSexEnumMan.name}</label>&#12288;
                    <input id="${userSexEnumWoman.id }" class="validate[required]" type="radio"  name="sexId" value="${userSexEnumWoman.id }" <c:if test="${userSexEnumWoman.id == user.sexId}">checked</c:if> />
                    <label for="${userSexEnumWoman.id }">${userSexEnumWoman.name }</label>
				<font color="red">*</font>
				</td>
				<th>身份证号：</th>
				<td>
					<input name="idNo" value="${user.idNo}" type="text" class="validate[required] xltext"  />
					<font color="red">*</font>
				</td>
			</tr>
			<tr>
				<th>手机号：</th>
				<td>
					<input name="userPhone" value="${user.userPhone}" type="text" class="validate[required,custom[phone]] xltext" />
					<font color="red">*</font>
				</td>
				<th>Email：</th>
				<td>
					<input name="userEmail" value="${user.userEmail}" type="text" class="validate[required,custom[email]] xltext" />
					<font color="red">*</font>
				</td>
			</tr>
			<tr>
			<th>传真：</th>
				<td>
					<input name="fax" value="${expert.fax}" class="xltext" />
				</td>
				<th>毕业院校：</th>
				<td>
					<input name="graduateSchool" value="${expert.graduateSchool}" class="xltext" />
				</td>
			</tr>
			<tr>
				<th>工作年份：</th>
				<td>
					<input name="beginWorkYear" value="${expert.beginWorkYear}"  class="ctime xltext" style='width: 160px;' readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})"/>
				</td>
					<th>所在机构：</th>
				<td>
				
					<select  name="orgFlow" class="validate[required]  xlselect" >
						<option value="">请选择</option>
						<c:forEach var="sysOrg" items="${applicationScope.sysOrgList}">
						<option value="${sysOrg.orgFlow}" <c:if test="${sysOrg.orgFlow==user.orgFlow}">selected</c:if>>${sysOrg.orgName}</option>
						</c:forEach>
					</select> 
					<font color="red">*</font>
				</td>
			</tr>
			<tr>
				<th>专业：</th>
				<td>
				<input type="hidden" id="majorId" name="majorId" value="${expert.majorId}"/>
					<input type="text" id="majorName" name="majorName" value="${expert.majorName}" class="validate[required] xltext" readonly="readonly" onclick="showMenu(); return false;"/>
					<font color="red">*</font>
				</td>
				<th>研究领域：</th>
				<td>
					<input name="techAreaName" value="${expert.techAreaName}" class="xltext" />
				</td>
			</tr>
			<tr>
				<th>学历：</th>
				<td>
					<select class="xlselect" name="educationId">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserEducationList }">
	                   <option value="${dict.dictId}" <c:if test="${user.educationId eq dict.dictId}">selected="selected"</c:if>>${dict.dictName }</option> 
	                   </c:forEach>
	                </select>
				</td>
				<th>学位：</th>
				<td>
					<select class="xlselect" name="degreeId">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserDegreeList }">
	                   <option value="${dict.dictId}" <c:if test="${user.degreeId eq dict.dictId}">selected="selected"</c:if>>${dict.dictName }</option> 
	                   </c:forEach>
	                </select>
				</td>
			</tr>
			<tr>
			<th>职称：</th>
				<td>
					<select class="xlselect" name="titleId">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserTitleList }">
	                   <option value="${dict.dictId}" <c:if test="${user.titleId eq dict.dictId}">selected="selected"</c:if>>${dict.dictName }</option> 
	                   </c:forEach>
	                </select>
				</td>
				<th>职务：</th>
				<td>
					<select class="xlselect" name="postId">
						<option value=''>请选择</option>
						<c:forEach items="${dictTypeEnumUserPostList}" var='dict'>
							<option value='${dict.dictId}' <c:if test='${user.postId eq dict.dictId}'>selected="selected"</c:if> >${dict.dictName}</option>
						</c:forEach>
					</select>
				</td>
				
			</tr>
			<tr>
				<th>联系地址：</th>
				<td>
					<input name="address" value="${expert.address}" class="xltext" />
				</td>
				<th>邮政编码：</th>
				<td>
					<input name="postcode" value="${expert.postcode}" class="xltext" />
				</td>
			</tr>
			<tr>
				<th>取得奖项：</th>
				<td colspan="3">
					<input name="award" value="${expert.award}" class="xltext" style="width: 510px;"/>
				</td>
				<!-- 
				<th>劳务支付方式：</th>
				<td>
					<select name="laborPayId" class="xlselect">
					 <option value="">请选择</option>
	                <c:forEach var="dict" items="${dictTypeEnumLaborPayList }">
	                   <option value="${dict.dictId}" <c:if test="${expert.laborPayId eq dict.dictId}">selected="selected"</c:if>>${dict.dictName }</option> 
	                </c:forEach>
	        	</select>
				</td>
	        	 -->
			</tr>
			<!-- 
			<tr>
				<th>开户银行：</th>
				<td>
					<input name="accountBank" value="${expert.accountBank}" class="xltext" />
				</td>
				<th>开户名：</th>
				<td>
					<input name="accountName" value="${expert.accountName}" class="xltext" />
				</td>
			</tr>
			<tr>
				<th>银行卡号：</th>
				<td>
					<input name="accountNo" value="${expert.accountNo}" class="xltext" />
				</td>
				<th>收款人：</th>
				<td>
					<input name="recipient" value="${expert.recipient}" class="xltext" />
				</td>
			</tr>
			<tr>
				<th>收款人地址：</th>
				<td colspan="3">
					<input name="recipientAddress" value="${expert.recipientAddress}" class="xltext" style="width: 555px"/>
				</td>
			</tr>
			-->
		</table>
		<p align="center">
			<input type="button" value="保&#12288;存" onclick="save()" class="search"/>
		</p>
	</form>
		<div id="menuContent" class="menuContent" style="display:none; position:absolute;">
		<ul id="treeDemo" class="ztree" style="margin-top:0; width:159px;"></ul>
	</div>
     </div>
   </div> 	
 </div>	
</body>
</html>