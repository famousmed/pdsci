<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ztree" value="true"/>
</jsp:include>

<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
//处理键盘事件 禁止后退键（Backspace）密码或单行、多行文本框除外
function banBackSpace(e){   
    var ev = e || window.event;//获取event对象   
    var obj = ev.target || ev.srcElement;//获取事件源   
    var t = obj.type || obj.getAttribute('type');//获取事件源类型  
    //获取作为判断条件的事件类型
    var vReadOnly = obj.getAttribute('readonly');
    //处理null值情况
    vReadOnly = (vReadOnly == "") ? false : vReadOnly;
    //当敲Backspace键时，事件源类型为密码或单行、多行文本的，
    //并且readonly属性为true或enabled属性为false的，则退格键失效
    var flag1=(ev.keyCode == 8 && (t=="password" || t=="text" || t=="textarea") 
                && vReadOnly=="readonly")?true:false;
    //当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效
    var flag2=(ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea")
                ?true:false;        
    
    //判断
    if(flag2){
        return false;
    }
    if(flag1){   
        return false;   
    }   
}

window.onload=function(){
//禁止后退键 作用于Firefox、Opera
document.onkeypress=banBackSpace;
//禁止后退键  作用于IE、Chrome
document.onkeydown=banBackSpace;
}
	function nextOpt(step){
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		var form = $('#projForm');
		var action = form.attr('action');
		action+="?nextPageName="+step;
		form.attr("action" , action);
		form.submit();
	}
	
	/* 学科代码 */
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
		var cityObj = $("#belongSubject");
		$("#belongSubjectCode").val(id);
		cityObj.attr("value", v);
	}

	function showMenu() {
		var cityObj = $("#belongSubject");
		var cityOffset = $("#belongSubject").offset();
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
				$.fn.zTree.init($("#treeDemo2"), setting2, zNodes);//相关学科
			}
	    },null,false);
	});
	
	/* 相关学科 */
	var setting2 = {
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
			onClick: onClick2
		}
	};
	
	function onClick2(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo2"),
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
		var cityObj = $("#relatedSubject");
		$("#relatedSubjectCode").val(id);
		cityObj.attr("value", v);
	}
	function showMenu2() {
		var cityObj = $("#relatedSubject");
		var cityOffset = $("#relatedSubject").offset();
		$("#menuContent2").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown2);
	}
	function hideMenu2() {
		$("#menuContent2").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown2(event) {
		if (!(event.target.id == "menuBtn" || event.target.id == "menuContent2" || $(event.target).parents("#menuContent2").length>0)) {
			hideMenu2();
		}
	}
	
</script>
</c:if>
<style>
		#infoTable .inputText{text-align: left;}
</style>
<!-- 	<div id="menuContent"  style="display:none; position:absolute; z-index:1000;">
    <ul id="treeDemo" class="ztree" style="margin-top:0; width:159px;"></ul>
</div>
<div id="menuContent2" style="display:none; position:absolute; z-index:1000;">
    <ul id="treeDemo2" class="ztree" style="margin-top:0; width:159px;"></ul>
</div> -->

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step1" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		<font style="font-size: 14px; font-weight:bold;color: #333;">一、信息表</font>
		<table id="infoTable" class="basic" style="width: 100%; margin-top: 10px;" >
			<tr>
				<th rowspan="4">项目负责人</th>
				<td style="text-align: right;">姓&#12288;&#12288;名：</td>
				<td><input type="text" name="userName" value="${resultMap.userName}" class="validate[required] inputText" style="width: 80%"/></td>
				<td style="text-align: right;">性&#12288;&#12288;别：</td>
				<td>
	                <select name="gender" class="validate[required] inputText" style="width: 80%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="sex" items="${userSexEnumList}">
	                   		<c:if test="${sex.id != userSexEnumUnknown.id}">
	                   			<option value="${sex.name}" <c:if test="${resultMap.gender eq sex.name}">selected="selected"</c:if>>${sex.name}</option>
	                   		</c:if>	 
	                   </c:forEach>
	                </select>
           		</td>
           		<td style="text-align: right;">出生年月：</td>
				<td><input class="validate[required] inputText ctime" type="text" name="birthday"  value="${resultMap.birthday}" onClick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly" style="width: 80%"/></td>
			</tr>
			<tr>   
				<td style="text-align: right;">学历（学位）：</td>
				<td colspan="2">
					<select name="education" class="validate[required] inputText" style="width: 80%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserEducationList}">
	                   		<option value="${dict.dictName}" <c:if test="${resultMap.education eq dict.dictName}">selected="selected"</c:if>>${dict.dictName}</option> 
	                   </c:forEach>
	                </select>
				</td>
				<td style="text-align: right;">技术专业：</td>
				<td colspan="2"><input type="text" name="major" value="${resultMap.major}" class="validate[required] inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">技术职称：</td>
				<td colspan="2">
					<select class="validate[required] inputText" name="title" style="width: 80%">
						<option value="">请选择</option>
						<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
							<option value="${title.dictName}" <c:if test='${resultMap.title==title.dictName}'>selected="selected"</c:if>>${title.dictName}</option>
						</c:forEach>
					</select>
				</td>
				<td style="text-align: right;">职&#12288;&#12288;务：</td>
				<td colspan="2">
					<select class="validate[required] inputText" name="duty" style="width: 80%">
						<option value="">请选择</option>
						<c:forEach items="${dictTypeEnumUserPostList}" var="post">
							<option value="${post.dictName}" <c:if test='${resultMap.duty==post.dictName}'>selected="selected"</c:if>>${post.dictName}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">手机号码：</td>
				<td colspan="2"><input type="text" name="mobilePhone" value="${resultMap.mobilePhone}" class="validate[required,custom[mobile]] inputText" style="width: 80%"/></td>
				<td style="text-align: right;">电子邮箱：</td>
				<td colspan="2"><input type="text" name="email" value="${resultMap.email}" class="validate[required,custom[email]] inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<th rowspan="5">所在单位</th>
			</tr>
			<tr>
				<td style="text-align: right;">单位全称：</td>
				<td colspan="2"><input type="text" name="orgName" value="${resultMap.orgName}" class="validate[required] inputText" style="width: 80%"/></td>
				<td style="text-align: right;">所在部门：</td>
				<td colspan="2"><input type="text" name="deptName" value="${resultMap.deptName}" class="validate[required] inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">通讯地址：</td>
				<td colspan="2"><input type="text" name="postAddress" value="${resultMap.postAddress}" class="validate[required] inputText" style="width: 80%"/></td>
				<td style="text-align: right;">邮政编码：</td>
				<td colspan="2"><input type="text" name="postCode" value="${resultMap.postCode}" class="validate[required,custom[chinaZip]] inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">单位联系人：</td>
				<td colspan="2"><input type="text" name="orgLinkman" value="${resultMap.orgLinkman}" class="validate[required] inputText" style="width: 80%"/></td>
				<td style="text-align: right;">联系电话：</td>
				<td colspan="2"><input type="text" name="orgPhone" value="${resultMap.orgPhone}" class="validate[required,custom[phone2]] inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">电子邮箱：</td>
				<td colspan="2"><input type="text" name="orgEmail" value="${resultMap.orgEmail}" class="validate[required,custom[email]] inputText" style="width: 80%"/></td>
				<td style="text-align: right;">传&#12288;&#12288;真：</td>
				<td colspan="2"><input type="text" name="orgFax" value="${resultMap.orgFax}" class="validate[required,custom[phone2]] inputText" style="width: 80%"/></td>
			</tr>
			
			<tr>
				<th rowspan="6">研究项目简介</th>
			</tr>
			<tr>
				<td style="text-align: right;">项目名称：</td>
				<td colspan="5"><input type="text" name="projectName" value="${resultMap.projectName}" class="validate[required] inputText" style="width: 80%;text-align: left;" /></td>
			</tr>
			<tr>
				<td style="text-align: right;">所属学科：</td>
				<td colspan="2">
					<input type="text" id="belongSubject" name="belongSubject" value="${resultMap.belongSubject}" class="validate[required] inputText" style="width: 80%;" readonly="readonly" onclick="showMenu(); return false;"/>
				</td>
				<td style="text-align: right;">代&#12288;&#12288;码：</td>
				<td colspan="2"><input type="text" id="belongSubjectCode" name="belongSubjectCode" value="${resultMap.belongSubjectCode}" class="inputText" style="width: 80%" readonly="readonly" /></td>
			</tr>
			<tr>
				<td style="text-align: right;">相关学科：</td>
				<td colspan="2">
					<input type="text" id="relatedSubject" name="relatedSubject" value="${resultMap.relatedSubject}" class="validate[required] inputText" style="width: 80%;" readonly="readonly" onclick="showMenu2(); return false;"/>
				</td>
				<td style="text-align: right;">代&#12288;&#12288;码：</td>
				<td colspan="2"><input type="text" id="relatedSubjectCode" name="relatedSubjectCode" value="${resultMap.relatedSubjectCode}" class="inputText" style="width: 80%" readonly="readonly" /></td>
			</tr>
			<tr>
				<td style="text-align: right;">申请经费：</td>
				<td colspan="2"><input type="text" name="applyFunds" value="${resultMap.applyFunds}" class="validate[required,custom[number]] inputText" style="width: 80%"/>万元</td>
				<td style="text-align: right;">起止年月：</td>
				<td colspan="2">
					<input type="text" name="projStartYearMonth" value="${resultMap.projStartYearMonth}" onClick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly" class="validate[required] inputText ctime" style="width: 37%;margin-right: 0px;"/>
					~ <input type="text" name="projEndYearMonth" value="${resultMap.projEndYearMonth}" onClick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly" class="validate[required] inputText ctime" style="width: 37%;"/>
				</td>
			</tr>
			<tr>
				<td colspan="6" style="text-align:left;">
		     		<textarea placeholder="研究内容、技术路线和研究意义摘要（限300字）" class="validate[required] xltxtarea" style="height: 300px;" name="contentTechnologySignificanceSummary">${resultMap.contentTechnologySignificanceSummary}</textarea>
		     	</td>
			</tr>
		</table>
	</form>
	
	<div id="menuContent" class="menuContent" style="display:none; position:absolute;z-index:1000;">
		<ul id="treeDemo" class="ztree" style="margin-top:0; width:210px;"></ul>
	</div>
	<div id="menuContent2" class="menuContent" style="display:none; position:absolute;z-index:1000;">
		<ul id="treeDemo2" class="ztree" style="margin-top:0; width:210px;"></ul>
	</div>
	
    <c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="nxt" type="button" onclick="nextOpt('step2')" class="search" value="下一步"/>
       	</div>
    </c:if>

		