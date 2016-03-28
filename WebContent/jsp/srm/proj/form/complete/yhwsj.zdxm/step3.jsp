<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
<script type="text/javascript">
	$(document).ready(function(){
		if($("#membTb tr").length<=0){
			add('memb');
		}
	});
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
	
	function add(tb){
		var length = $("#"+tb+"Tb").children().length;
		if(length > 7){
			jboxTip("不超过8人!");
			return false; 
		}
	 	$("#"+tb+"Tb").append($("#"+tb+"Template tr:eq(0)").clone());
	 	
	 	var length = $("#"+tb+"Tb").children().length;
	 	//序号
		$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length);
	}
	
	function delTr(tb){
		//alert("input[name="+tb+"Ids]:checked");
		var checkboxs = $("input[name='"+tb+"Ids']:checked");
		if(checkboxs.length==0){
			jboxTip("请勾选要删除的！");
			return false;
		}
		jboxConfirm("确认删除?",function () {
			var trs = $('#'+tb+'Tb').find(':checkbox:checked');
			$.each(trs , function(i , n){
				$(n).parent('td').parent("tr").remove();
			});
			//删除后序号
			var serial = 0;
			$("."+tb+"Serial").each(function(){
				serial += 1;
				$(this).text(serial);
			});
		});
	}
	
	function checkTeltphone(obj){
		var r, reg; 
		var s = obj.value;
		reg =/^[1][34578]\w*$/; //正则表达式模式。
		r = reg.test(s); 
		if(r){
			$(obj).addClass("validate[custom[mobile]]");
			$(obj).removeClass("validate[custom[phone2]]");
		}else{
			$(obj).addClass("validate[custom[phone2]]");
			$(obj).removeClass("validate[custom[mobile]]");
		}       
	}
</script>
</c:if>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step3" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>

		<font style="font-size: 14px; font-weight:bold;color: #333; ">三、建议验收组成员名单</font>
		<table class="bs_tb" style="width: 100%; margin-top: 10px;">
			<tr>
				<th colspan="10" class="theader">建议验收组成员名单
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('memb')"></img>&#12288;
					<img title="删除" style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('memb');"></img></span>
					</c:if>
				</th>
			</tr>
			<tr>
				<td width="4%"></td>
				<td width="5%">序号</td>
				<td width="10%">姓名</td>
				<td width="30%">工作单位</td>
				<td width="15%">现从事专业</td>
				<td width="20%">职务/职称</td>
				<td width="15%">电话</td>
			</tr>
			<tbody id="membTb">
			<c:if test="${not empty resultMap.member}">
				<c:forEach var="memb" items="${resultMap.member}" varStatus="status">
				<tr>
		             <td width="4%" style="text-align: center;"><input name="membIds" type="checkbox"/></td>
		             <td width="5%" style="text-align: center;" class="membSerial">${status.count}</td>
		             <td><input type="text" name="member_userName" value="${memb.objMap.member_userName}" class="inputText" style="width: 90%"/></td>
		             <td><input type="text" name="member_orgName" value="${memb.objMap.member_orgName}" class="inputText" style="width: 90%"/></td>
		             <td><input type="text" name="member_major" value="${memb.objMap.member_major}" class="inputText" style="width: 90%"/></td>
		             <td><input type="text" name="member_postTitle" value="${memb.objMap.member_postTitle}" class="inputText" style="width: 90%"/></td>
		             <td><input type="text" name="member_phone" value="${memb.objMap.member_phone}" onchange="checkTeltphone(this);" class="inputText" style="width: 90%"/></td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
		</table>
	</form>
	
	<!-------------------------------------------------------------------------------------------------------->
		
	<div style="display: none">
		<!-- 模板 -->
		<table class="basic" id="membTemplate" style="width: 100%">
        <tr>
             <td width="4%" style="text-align: center;"><input name="membIds" type="checkbox"/></td>
             <td width="5%" style="text-align: center;" class="membSerial"></td>
             <td><input type="text" name="member_userName" class="inputText" style="width: 90%"/></td>
             <td><input type="text" name="member_orgName" class="inputText" style="width: 90%"/></td>
             <td><input type="text" name="member_major" class="inputText" style="width: 90%"/></td>
             <td><input type="text" name="member_postTitle" class="inputText" style="width: 90%"/></td>
             <td><input type="text" name="member_phone" onchange="checkTeltphone(this);" class="inputText" style="width: 90%"/></td>
		</tr>
		</table>
	</div>	
   	<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="prev" type="button" onclick="nextOpt('step2')" class="search" value="上一步"/>
		    <input id="nxt" type="button" onclick="nextOpt('step4')" class="search" value="下一步"/>
       	</div>
    </c:if>

		