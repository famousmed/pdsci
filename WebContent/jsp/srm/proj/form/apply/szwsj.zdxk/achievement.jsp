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
		//计算行数
		var length = $("#"+tb+"Tb").children().length;
		$("input[name="+tb+"Num]").val(length);
		//删除后序号
		var serial = 0;
		$("."+tb+"Serial").each(function(){
			serial += 1;
			$(this).text(serial);
		});
	});
}
$(function(){ 
    var tables=$(".tb");
    $.each(tables , function(i , n){
    	var count=$(n).children().length;
    	var id=$(n).parent().attr("id");
    	$("input[name="+id+"Num]").val(count);
    });
});


function addFruit(tb,obj){
	var length = $("#"+tb+"Tb").children().length;
	if(length > 4){
		jboxTip("限填5项!");
		return false; 
	}
	$("input[name="+tb+"Num]").val(length+1);
	
	var html = '<tr>'+
	'<td width="50px"><input name="fruitIds" type="checkbox"/></td>'+
	'<td width="50px" class="fruitSerial"></td>'+
	'<td><input type="text" class="inputText" name="fruit_fruitAwardTime"   onclick="WdatePicker({dateFmt:'+"'yyyy-MM-dd'"+'})" style="width:80%; margin-right: 0px;"/></td>'+
	'<td><input type="text" class="inputText" name="fruit_fruitName" style="width:90%;"/></td>'+
	'<td><input type="text" class="inputText" name="fruit_fruitAwardOrg" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="fruit_fruitGrade" style="width:80%;"/></td>'+
	'</tr>'; 
	$('#'+tb+'Tb').append(html);
	//序号
	$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length+1);
}


function addTopic(tb,obj){
	var length = $("#"+tb+"Tb").children().length;
	if(length > 4){
		jboxTip("限填5项!");
		return false; 
	}
	$("input[name="+tb+"Num]").val(length+1);
	
	var html = '<tr>'+
	'<td width="50px"><input name="topicIds" type="checkbox"/></td>'+
	'<td width="50px" class="topicSerial"></td>'+
	'<td><input type="text" class="inputText" name="topic_topicNo" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="topic_topicName" style="width:90%;"/></td>'+
	'<td><input type="text" class="inputText" name="topic_topicSource" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText validate[custom[number]]" name="topic_topicOutlay" style="width:80%;"/></td>'+
	'<td><input type="text" onClick="WdatePicker({dateFmt:'+" 'yyyy-MM-dd'  "+'})" class="inputText"  name="topic_topicStartTime" style="width:40%;" />'+
	' ~ <input type="text" onClick="WdatePicker({dateFmt:'+" 'yyyy-MM-dd'  "+'})" class="inputText"  name="topic_topicEndTime" style="width:40%;" />'+
	'</td>'+
	'</tr>'; 
	$('#'+tb+'Tb').append(html);
	//序号
	$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length+1);
}

function addThesis(tb,obj){
	var length = $("#"+tb+"Tb").children().length;
	if(length > 4){
		jboxTip("限填5项!");
		return false; 
	}
	$("input[name="+tb+"Num]").val(length+1);
	var html = '<tr>'+
	'<td width="50px"><input name="thesisIds" type="checkbox"/></td>'+
	'<td width="50px" class="thesisSerial"></td>'+
	'<td><input type="text" class="inputText"  name="thesis_thesisPublishTime" onclick="WdatePicker({dateFmt:'+"'yyyy-MM-dd'"+'})"  style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText"  name="thesis_thesisName" style="width:90%;"/></td>'+
	'<td><input type="text" class="inputText"  name="thesis_thesisPublicationName"  style="width:90%;"/></td>'+
	'</tr>'; 
	$('#'+tb+'Tb').append(html);
	//序号
	$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length+1);
}

function addMagazine(tb,obj){
	var length = $("#"+tb+"Tb").children().length;
	if(length > 4){
		jboxTip("限填5项!");
		return false; 
	}
	$("input[name="+tb+"Num]").val(length+1);
	
	var html = '<tr>'+
	'<td width="50px"><input  name="magazineIds" type="checkbox"/></td>'+
	'<td width="50px" class="magazineSerial"></td>'+
	'<td><input type="text" class="inputText"  name="magazine_magazineAppointYear" class="validate[custom[number]]" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText"  name="magazine_magazineName" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText"  name="magazine_magazineTitle" style="width:90%;"/></td>'+
	'</tr>'; 
	$('#'+tb+'Tb').append(html);
	//序号
	$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length+1);
}

function addGroup(tb,obj){
	var length = $("#"+tb+"Tb").children().length;
	if(length > 4){
		jboxTip("限填5项!");
		return false; 
	}
	$("input[name="+tb+"Num]").val(length+1);
	
	var html = '<tr>'+
	'<td width="50px"><input name="groupIds" type="checkbox"/></td>'+
	'<td width="50px" class="groupSerial"></td>'+
	'<td><input type="text" class="inputText"  name="group_groupAppointYear" class="validate[custom[number]]" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText"  name="group_groupName" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText"  name="group_groupTitle" style="width:90%;"/></td>'+
	'</tr>'; 
	$('#'+tb+'Tb').append(html);
	//序号
	$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length+1);
}
</script>
</c:if>

        			<font style="font-size: 14px; font-weight:bold;color: #333; ">三、主要业绩</font>
        	    	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
						<input type="hidden" name="pageName" value="achievement"/>
						<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
						<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
   					<table class="bs_tb" style="width: 100%" id="fruit">
   					   	<tr>
	   					   	<th colspan="6" class="theader">1、近五年为第一完成人的市局级及以上科研成果（含专利、新药证书）共<input type="text" name="fruitNum"  value="${resultMap.fruitNum}" style="width:30px;" class="inputText" /> 项，限填5项代表作。
	   					   	<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
		  		 			<span style="float: right;padding-right: 10px">
			  				<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addFruit('fruit',this);"></img>&nbsp;
	   					  	<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('fruit');"></img>
	   					  	</span> 
	   					  	</c:if>
	   					   	</th>
   					   	</tr>
       					<tr>
			           		<td style="text-align: center;" width="50px"></td>
			           		<td style="text-align: center;" width="50px">序号</td>
			                <td style="text-align: center;" width="150px">授予时间</td>
			                <td style="text-align: center;" >成果名称</td>
			                <td style="text-align: center;" width="200px">授予部门</td>
			                <td width="200px" style="text-align: center;">等级</td>
          				</tr>
          			<tbody id="fruitTb" class="tb">
          			<c:if test="${empty resultMap.fruit}">
          			   <tr>
				           <td width="50px"><input name="fruitIds" type="checkbox"/></td>
				           <td width="50px" style="text-align: center;" class="fruitSerial">1</td>
				           <td>
				           		<input type="text" class="inputText"   name="fruit_fruitAwardTime"    onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:80%;" />
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="fruit_fruitName"  style="width:90%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="fruit_fruitAwardOrg"  style="width:80%;"/>
				           </td>
				           <td>
				             	<input type="text" class="inputText"  name="fruit_fruitGrade"  style="width:80%;"/>
				           </td>
				        </tr>
          			</c:if>
          			<c:if test="${! empty resultMap.fruit}">
					<c:forEach var="fruit" items="${resultMap.fruit}" varStatus="status">
				        <tr>
				           <td width="50px"><input name="fruitIds" type="checkbox"/></td>
				           <td width="50px" style="text-align: center;" class="fruitSerial">${status.count}</td>
				           <td>
				           		<input type="text" class="inputText"   name="fruit_fruitAwardTime" value="${fruit.objMap.fruit_fruitAwardTime}"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:80%;" />
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="fruit_fruitName" value="${fruit.objMap.fruit_fruitName}" style="width:90%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="fruit_fruitAwardOrg" value="${fruit.objMap.fruit_fruitAwardOrg}" style="width:80%;"/>
				           </td>
				           <td>
				             	<input type="text" class="inputText"  name="fruit_fruitGrade" value="${fruit.objMap.fruit_fruitGrade}" style="width:80%;"/>
				           </td>
				        </tr>
				    </c:forEach>
				    </c:if>
				    </tbody>
					</table>
   					<table class="bs_tb" style="width: 100%" id="topic">
   					<tr>
	   					<th colspan="7" class="theader">2、近五年为第一负责人的市局级及以上科研课题共<input type="text" name="topicNum" value="${resultMap.topicNum}" style="width:30px;" class="inputText"/>项，限填5项代表作。
		   					<c:if test="${param.view != GlobalConstant.FLAG_Y}">
		   					<span style="float: right;padding-right: 10px">
		   					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addTopic('topic',this);"></img>&nbsp;
		   					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('topic');"></img>
		   					</span> 
		   					</c:if>
	   					</th>
   					</tr>
       					<tr>
			           		<td style="text-align: center;" width="50px"></td>
			           		<td style="text-align: center;" width="50px">序号</td>
			                <td style="text-align: center;" width="150px">课题编号</td>
			                <td style="text-align: center;">课题名称</th>
			                <td style="text-align: center;"width="150px">课题来源</td>
			                <td style="text-align: center;" width="50px">经费<br/>(万元)</td>
			                <td style="text-align: center;" width="200px">起止时间</td>
          				</tr>
          			<tbody id="topicTb" class="tb">
          			<c:if test="${empty resultMap.topic}">
          			    <tr>
				           <td width="50px"><input name="topicIds" type="checkbox"/></td>
				           <td width="50px" style="text-align: center;" class="topicSerial">1</td>
				           <td>
				           		<input type="text" class="inputText"  name="topic_topicNo"  style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="topic_topicName"  style="width:90%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="topic_topicSource"  style="width:80%;"/>
				           </td>
				           <td width="8%">
				             	<input type="text" class="inputText validate[custom[number]]"  name="topic_topicOutlay"  style="width:80%;" />
				           </td>
				           <td>
				             	<input type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText"  name="topic_topicStartTime"   style="width:40%;" />
				             	~
				             	<input type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText"  name="topic_topicEndTime"   style="width:40%;" />
				           </td>
				        </tr>
          			</c:if>
          			<c:if test="${! empty resultMap.topic}">
					<c:forEach var="topic" items="${resultMap.topic}" varStatus="status">
				        <tr>
				           <td width="50px"><input name="topicIds" type="checkbox"/></td>
				           <td width="50px" style="text-align: center;" class="topicSerial">${status.count}</td>
				           <td>
				           		<input type="text" class="inputText"  name="topic_topicNo" value="${topic.objMap.topic_topicNo}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="topic_topicName" value="${topic.objMap.topic_topicName}" style="width:90%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="topic_topicSource" value="${topic.objMap.topic_topicSource}" style="width:80%;"/>
				           </td>
				           <td width="8%">
				             	<input type="text" class="inputText validate[custom[number]]"  name="topic_topicOutlay" value="${topic.objMap.topic_topicOutlay}" style="width:80%;" />
				           </td>
				           <td>
				             	<input type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText"  name="topic_topicStartTime" value="${topic.objMap.topic_topicStartTime}"  style="width:40%;" />
				             	~
				             	<input type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText"  name="topic_topicEndTime" value="${topic.objMap.topic_topicEndTime}"  style="width:40%;" />
				           </td>
				        </tr>
				    </c:forEach>
				    </c:if>
				    </tbody>
					</table> 
   					<table class="bs_tb" style="width: 100%" id="thesis">
	   					<tr>
		   					<th colspan="6" class="theader">3、近五年为第一作者发表的SCI和中华级学术论文共<input type="text" name="thesisNum" value="${resultMap.thesisNum}" style="width:30px;" class="inputText"/>篇，限填5项代表作。
		   					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
		   					<span style="float: right;padding-right: 10px">
		   					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addThesis('thesis',this);"></img>&nbsp;
		   					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('thesis');"></img>
		   					</span>
		   					</c:if>
		   					</th>
	   					</tr>
       					<tr>
			           		<td style="text-align: center;" width="50px"></td>
			           		<td style="text-align: center;" width="50px">序号</td>
			                <td style="text-align: center;" width="150px">发表时间</td>
			                <td style="text-align: center;">论文名称</td>
			                <td style="text-align: center;" width="400px">刊物名称</td>
          				</tr>
          			<tbody id="thesisTb" class="tb">
          			<c:if test="${empty resultMap.thesis}">
          			   <tr>
				           <td width="50px"><input name="thesisIds" type="checkbox"/></td>
				           <td width="50px" style="text-align: center;" class="thesisSerial">1</td>
				           <td>
				           		<input type="text" class="inputText"  name="thesis_thesisPublishTime"   style="width:80%;"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="thesis_thesisName"  style="width:90%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="thesis_thesisPublicationName"  style="width:90%;"/>
				           </td>
				        </tr>
          			</c:if>
          			<c:if test="${! empty resultMap.thesis}">
					<c:forEach var="thesis" items="${resultMap.thesis}" varStatus="status">
				        <tr>
				           <td width="50px"><input name="thesisIds" type="checkbox"/></td>
				           <td width="50px" style="text-align: center;" class="thesisSerial">${status.count}</td>
				           <td>
				           		<input type="text" class="inputText"  name="thesis_thesisPublishTime" value="${thesis.objMap.thesis_thesisPublishTime}"  style="width:80%;"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="thesis_thesisName" value="${thesis.objMap.thesis_thesisName}" style="width:90%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="thesis_thesisPublicationName" value="${thesis.objMap.thesis_thesisPublicationName}" style="width:90%;"/>
				           </td>
				        </tr>
				    </c:forEach>
				    </c:if>
				    </tbody>
					</table> 
   					<table class="bs_tb" style="width: 100%" id="magazine">
	   					<tr>
		   					<th colspan="6" class="theader">4、近五年学术杂志任职情况，共<input type="text" name="magazineNum" value="${resultMap.magazineNum}" style="width:30px;" class="inputText"/>份杂志，限填5份代表杂志
		   					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
		   					<span style="float: right;padding-right: 10px">
		   					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addMagazine('magazine',this);"></img>&nbsp;
		   					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('magazine');"></img>
		   					</span>
		   					</c:if>
		   					</th>
	   					</tr>
       					<tr>
			           		<td style="text-align: center;" width="50px"></td>
			           		<td style="text-align: center;" width="50px">序号</td>
			                <td style="text-align: center;" width="150px">任期年限</td>
			                <td style="text-align: center;">学术杂志名称</td>
			                <td style="text-align: center;" width="400px">主编/副主编/编委</td>
          				</tr>
          			<tbody id="magazineTb" class="tb">
          			<c:if test="${empty resultMap.magazine}">
          			   <tr>
				           <td width="50px"><input name="magazineIds" type="checkbox"/></td>
				           <td width="50px" style="text-align: center;" class="magazineSerial">1</td>
				           <td>
				           		<input type="text" class="inputText"  name="magazine_magazineAppointYear"  style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="magazine_magazineName" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="magazine_magazineTitle" style="width:90%;"/>
				           </td>
				        </tr>
          			</c:if>
          			<c:if test="${! empty resultMap.magazine}">
					<c:forEach var="magazine" items="${resultMap.magazine}" varStatus="status">
				        <tr>
				           <td width="50px"><input name="magazineIds" type="checkbox"/></td>
				           <td width="50px" style="text-align: center;" class="magazineSerial">${status.count}</td>
				           <td>
				           		<input type="text" class="inputText"  name="magazine_magazineAppointYear" value="${magazine.objMap.magazine_magazineAppointYear}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="magazine_magazineName" value="${magazine.objMap.magazine_magazineName}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="magazine_magazineTitle" value="${magazine.objMap.magazine_magazineTitle}" style="width:90%;"/>
				           </td>
				        </tr>
				    </c:forEach>
				    </c:if>
				    </tbody>
					</table> 
   					<table class="bs_tb" style="width: 100%" id="group">
	   					<tr>
		   					<th colspan="6" class="theader">5、近五年学会任职情况，共<input type="text" name="groupNum" value="${resultMap.groupNum}" style="width:30px;" class="inputText"/>个职务，限填5项最高职务。
		   					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
		   					<span style="float: right;padding-right: 10px">
		   					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addGroup('group',this);" ></img>&nbsp;
		   					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('group');"></img></span> 
		   					</c:if>
		   					</th>
	   					</tr>
       					<tr>
			           		<td style="text-align: center;" width="50px"></td>
			           		<td style="text-align: center;" width="50px">序号</td>
			                <td style="text-align: center;" width="150px">任期年限</td>
			                <td style="text-align: center;">学会（分会、学组）名称</td>
			                <td style="text-align: center;" width="400px">主委/副主委/组长/常委/委员</td>
          				</tr>
          			<tbody id="groupTb" class="tb">
          			<c:if test="${empty resultMap.group}">
          			   <tr>
				           <td width="50px"><input name="groupIds" type="checkbox"/></td>
				           <td width="50px" style="text-align: center;" class="groupSerial">1</td>
				           <td>
				           		<input type="text" class="inputText"  name="group_groupAppointYear"  style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text"  class="inputText" name="group_groupName"  style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="group_groupTitle"  style="width:90%;"/>
				           </td>
				        </tr>
          			</c:if>
          			
          			<c:if test="${! empty resultMap.group}">
					<c:forEach var="group" items="${resultMap.group}" varStatus="status">
				        <tr>
				           <td width="50px"><input name="groupIds" type="checkbox"/></td>
				           <td width="50px" style="text-align: center;" class="groupSerial">${status.count}</td>
				           <td>
				           		<input type="text" class="inputText"  name="group_groupAppointYear" value="${group.objMap.group_groupAppointYear}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text"  class="inputText" name="group_groupName" value="${group.objMap.group_groupName}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="group_groupTitle" value="${group.objMap.group_groupTitle}" style="width:90%;"/>
				           </td>
				        </tr>
				    </c:forEach>
				    </c:if>
				    </tbody>
					</table> 
					</form>
                	 <div class="button" style="width:100%;
                	 <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none;</c:if>">
                	 	<input id="prev" type="button" onclick="nextOpt('chief')" class="search" value="上一步"/>
                	    <input id="nxt" type="button" onclick="nextOpt('personInfo')" class="search" value="下一步"/>
      			     </div>