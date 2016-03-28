<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
function nextOpt(step){
	if(false==$("#projForm").validationEngine("validate")){
		return false;
	}
	var form = $('#projForm');
	form.append('<input type="hidden" name="nextPageName" value="'+step+'"/>');
	$('#nxt').attr({"disabled":"disabled"});
	$('#prev').attr({"disabled":"disabled"});
	jboxStartLoading();
	form.submit();
}
function add(itemGroupName){
	var url = "?pageName="+$('#pageName').val()+
	"&itemGroupName="+itemGroupName+
	"&recFlow="+$('#recFlow').val()+
	"&projFlow="+$('#projFlow').val();
	jboxOpen("<s:url value='/srm/proj/mine/showPageGroupStep'/>"+url, "添加信息", 700,500);
}

function edit(flow,itemGroupName){
	var url = "?pageName="+$('#pageName').val()+
	"&itemGroupName="+itemGroupName+
	"&recFlow="+$('#recFlow').val()+
	"&projFlow="+$('#projFlow').val()+
	"&itemGroupFlow="+flow;
	jboxOpen("<s:url value='/srm/proj/mine/showPageGroupStep'/>"+url, "编辑信息", 700,500);
}

function del(flow,itemGroupName){
	var datas = {
			"pageName":$('#pageName').val(),
			"&itemGroupName=":itemGroupName,
			"recFlow":$('#recFlow').val(),
			"projFlow":$('#projFlow').val(),
			"itemGroupFlow":flow,
	};
	var url = "<s:url value='/srm/proj/mine/delPageGroupStep'/>";
	jboxPost(url , datas , function(){
		window.parent.frames['mainIframe'].location.reload(true);
		doClose();
	} , null , true);
}

function addApplyUser(tb){
	var html = '<tr>'+
	'<td><input name="ids" type="checkbox"/></td>'+
	'<td><input style="width:80%;" name="'+tb+'_name" type="text" class="inputText"/></td>'+
	'<td>'+
	 '<select name="'+tb+'_sex" class="inputText" style="width: auto;">'+
	 '<option value="">请选择</option>'+ 
	    <c:forEach items="${userSexEnumList }" var="sex">
	    	<c:if test="${sex.id != userSexEnumUnknown.id}">
            '<option value="${sex.id }">${sex.name }</option>'+ 
            </c:if>
        </c:forEach>
	 '</select></td>'+
	'<td><input style="width:80%;" name="'+tb+'_birthday" type="text" class="inputText" onClick="WdatePicker({dateFmt:'+"'yyyy-MM-dd'"+'})" readonly="readonly"/></td>'+
	'<td>'+
	'<select name="'+tb+'_degree" class="inputText">'+
		<c:forEach items="${dictTypeEnumUserDegreeList}" var="degree">
			'<option value="${degree.dictId}">${degree.dictName}</option>'+
		</c:forEach>
	'</select></td>'+
	'<td>'+
		'<select name="'+tb+'_professional" class="inputText">'+
			<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
				'<option value="${title.dictId}">${title.dictName}</option>'+
			</c:forEach>
		'</select></td>'+
	'<td>'+
	'<select name="'+tb+'_post" class="inputText">'+  
	    <c:forEach items="${dictTypeEnumUserPostList}" var="post">
	   '<option value="${post.dictId}">${post.dictName}</option>'+
        </c:forEach>
	 '</select>'+ 
	'</td>'+
	'<td><input name="'+tb+'_workTime" type="text" class="inputText" style="width:80%"/></td>'+
	'<td><input name="'+tb+'_workOrg" type="text" class="inputText"  style="width: 90%"/></td>'+
'</tr>'; 
	$('#projMainPeopTb').append(html);
	
	
}


function delTr(tb){
	var checkboxs = $("input[name='ids']:checked");
	if(checkboxs.length==0){
		jboxTip("请勾选要删除的！");
		return false;
	}
	jboxConfirm("确认删除?",function () {
		var trs = $('#'+tb).find(':checkbox:checked');
		$.each(trs , function(i , n){
			$(n).parent('td').parent("tr").remove();
		});
	});
}

</script>
</c:if>
<style type="text/css">
.title_sp{padding-left: 10px;font-size: 14px; margin-bottom:10px; margin-top:10px; font-weight: bold;color: #333;}
</style>
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" id="pageName" name="pageName" value="step2"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
	<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
	<div class="title_sp">二、人员情况</div>
    <table width="100%" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
           		    <tr>
					    <th colspan="9" class="theader">项目负责人<c:if test="${param.view != GlobalConstant.FLAG_Y}"><span style="float: right;padding-right: 10px"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addApplyUser('projMainPeop');"></img>&nbsp;<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('projMainPeopTb');"></img></span></c:if></th>
					</tr>
			        <tr>
					    <td width="5%">序号</td>
						<td width="12%">姓名</td>
						<td width="7%">性别</td>
						<td width="15%">出生日期</td>
						<td width="10%">学位</td>
						<td width="10%">职称</td>
						<td>职务</td>
						<td width="10%">工作时间（单位：月/年）</td>
						<td width="20%">所在单位</td>
			        </tr>
			        <tbody id="projMainPeopTb">
			            <c:if test="${! empty resultMap.projMainPeop}">
						    <c:forEach var="mainPeop" items="${resultMap.projMainPeop}" varStatus="num">
							    <tr>
								    <!-- 复选框 -->
								    <td><input name="ids" type="checkbox"/></td>
								    <!-- 姓名 -->    
								    <td><input name="projMainPeop_name" value="${mainPeop.objMap.projMainPeop_name}" class="inputText" style="width:80%;"/></td>
								    <!-- 性别 -->   
								    <td>
								        <select name="projMainPeop_sex" class="inputText" style="width: auto;">
										    <option value="">请选择</option>
											<c:forEach items="${userSexEnumList }" var="sex">
											    <c:if test="${sex.id != userSexEnumUnknown.id}">
											        <option value="${sex.id}" <c:if test='${mainPeop.objMap.projMainPeop_sex eq sex.id}'>selected="selected"</c:if>>${sex.name }</option>     
											    </c:if>
											</c:forEach>
										</select>		
								    </td>
								    <!-- 出生日期 --> 
								    <td><input name="projMainPeop_birthday" value="${mainPeop.objMap.projMainPeop_birthday}" style="width:80%;" class="inputText" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
								    <!-- 学位 --> 
								    <td>
								        <select name="projMainPeop_degree" class="inputText" >
										    <c:forEach items="${dictTypeEnumUserDegreeList}" var="degree">
		        							    <option value="${degree.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_degree==degree.dictId}'>selected="selected"</c:if>>${degree.dictName}</option>
		        						    </c:forEach>
										</select>
								    </td>
								    <!-- 职称 -->
								    <td>
								        <select name="projMainPeop_professional" class="inputText">
										    <c:forEach items="${dictTypeEnumUserTitleList}" var="title">
		        							    <option value="${title.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_professional==title.dictId}'>selected="selected"</c:if>>${title.dictName}</option>
		        							</c:forEach>
										</select>
								    </td>
								    <!-- 职务 -->
								    <td>
								        <select name="projMainPeop_post" class="inputText">
										    <c:forEach items="${dictTypeEnumUserPostList}" var="post">
		        							    <option value="${post.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_post==post.dictId}'>selected="selected"</c:if>>${post.dictName}</option>
		        						    </c:forEach>
										</select>
								    </td>
								    <!-- 工作时间 -->
								    <td>
								        <input name="projMainPeop_workTime" value="${mainPeop.objMap.projMainPeop_workTime}" class="inputText" style="width: 80%"/>
								    </td>
								    <!-- 所在单位 -->  
								    <td>
								        <input name="projMainPeop_workOrg" value="${mainPeop.objMap.projMainPeop_workOrg}" class="inputText" style="width: 90%"/>
								    </td>
								</tr>
						    </c:forEach>
						</c:if>
						<c:if test="${empty resultMap.projMainPeop}">
						    <c:forEach var="mainPeop" items="${projInfoMap.projMainPeop}">
							    <tr>
								    <!-- 复选框 -->
									<td><input name="ids" type="checkbox"/></td>
								    <!-- 姓名 -->  
								    <td><input name="projMainPeop_name" value="${mainPeop.objMap.projMainPeop_name}" class="inputText" style="width:80%;"/></td>
								    <!-- 性别 -->   
								    <td>
								        <select name="projMainPeop_sex" class="inputText" style="width: auto;">
								            <option value="">请选择</option>
											<c:forEach items="${userSexEnumList }" var="sex">
											    <c:if test="${sex.id != userSexEnumUnknown.id}">
											        <option value="${sex.id }" <c:if test='${mainPeop.objMap.projMainPeop_sex eq sex.id}'>selected="selected"</c:if>>${sex.name }</option>     
											    </c:if>
											</c:forEach>
										</select>			
								    </td>
								    <!-- 出生日期 -->
								    <td><input name="projMainPeop_birthday" value="${mainPeop.objMap.projMainPeop_birthday}" class="inputText" style="width:80%;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
								    <!-- 学位 -->
								    <td>
								        <select name="projMainPeop_degree" class="inputText">
										    <c:forEach items="${dictTypeEnumUserDegreeList}" var="degree">
		        							    <option value="${degree.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_degree==degree.dictId}'>selected="selected"</c:if>>${degree.dictName}</option>
		        							</c:forEach>
										</select>
								    </td>
								    <!-- 职称 -->
								    <td>
								        <select name="projMainPeop_professional" class="inputText">
										    <c:forEach items="${dictTypeEnumUserTitleList}" var="title">
		        							    <option value="${title.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_professional==title.dictId}'>selected="selected"</c:if>>${title.dictName}</option>
		        							</c:forEach>
										</select>
								    </td>
								    <!-- 职务 -->
								    <td>
								        <select name="projMainPeop_post" class="inputText">
										    <c:forEach items="${dictTypeEnumUserPostList}" var="post">
		        							    <option value="${post.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_post==post.dictId}'>selected="selected"</c:if>>${post.dictName}</option>
		        							</c:forEach>
										</select>
								    </td>
								    <!-- 工作时间 -->
								    <td><input name="projMainPeop_workTime" value="${mainPeop.objMap.projMainPeop_workTime}" class="inputText"  style="width: 80%"/></td>
								    <!-- 所在单位 -->  
								    <td><input name="projMainPeop_workOrg" value="${mainPeop.objMap.projMainPeop_workOrg}" class="inputText" style="width: 90%"/></td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
      			</table> 
      		</td>
        </tr>
    </table>
    <table width="100%" class="bs_tb" style="margin-top: 10px;">
	    <tbody>
		    <tr>
			    <th colspan="5" class="theader">人员信息</th>
			</tr>
			<tr>
			    <td>研发总人数</td>
			    <td>博士个数</td>
			    <td>硕士个数</td>
			    <td>高级职称个数</td>
			    <td>中级职称个数</td>
			</tr>
			<tr>
			    <td><input name="sumCount" value="${resultMap.sumCount}" class="inputText validate[custom[integer]]"/></td>
			    <td><input name="boShiCount" value="${resultMap.boShiCount}" class="inputText validate[custom[integer]]"/></td>
			    <td><input name="shuoShiCount" value="${resultMap.shuoShiCount}" class="inputText validate[custom[integer]]"/></td>
			    <td><input name="hightDutyCount" value="${resultMap.hightDutyCount}" class="inputText validate[custom[integer]]"/></td>
			    <td><input name="midDutyCount" value="${resultMap.midDutyCount}" class="inputText validate[custom[integer]]"/></td>
			</tr>
        </tbody>
    </table>
</form>
<div class="button" width="100%" style="
<c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
    <input id="prev" type="button" onclick="nextOpt('step1')" class="search" value="上一步"/>
    <input id="nxt" type="button" onclick="nextOpt('step3')" class="search" value="下一步"/>
</div>

		</div>
	</div>
</div>
