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
	var applyUser_type=$(".sort").length+1;
	if(applyUser_type>3){
		jboxTip("限填3人！");
		return false;
	}
	var url = "?pageName="+$('#pageName').val()+
	"&itemGroupName="+itemGroupName+
	"&recFlow="+$('#recFlow').val()+
	"&projFlow="+$('#projFlow').val()+
	"&applyUser_type="+applyUser_type;
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/proj/mine/showPageGroupStep'/>"+url, "添加主要完成人",1000,600);
}

function edit(flow,itemGroupName,applyUser_type){
	var url = "?pageName="+$('#pageName').val()+
	"&itemGroupName="+itemGroupName+
	"&recFlow="+$('#recFlow').val()+
	"&projFlow="+$('#projFlow').val()+
	"&applyUser_type="+applyUser_type+
	"&itemGroupFlow="+flow;
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/proj/mine/showPageGroupStep'/>"+url, "编辑主要完成人",1000,600);
}

function del(flow,itemGroupName){
	jboxConfirm("确认删除?",function(){
		var datas = {
				"pageName":$('#pageName').val(),
				"&itemGroupName=":itemGroupName,
				"recFlow":$('#recFlow').val(),
				"projFlow":$('#projFlow').val(),
				"itemGroupFlow":flow,
		};
		jboxStartLoading();
		jboxPost("<s:url value='/srm/proj/mine/delPageGroupStep'/>",datas,function(){
			window.parent.frames['mainIframe'].location.reload(true);
			doClose();
		},null,true);
	});
}

</script>
</c:if>
<c:if test="${param.view == GlobalConstant.FLAG_Y}">
<script type="text/javascript">
   function on(flow){
	  $(".intro").hide(1000);
	  $("#"+flow).show(1000);
	  $(".off").hide();
	  $(".on").show();
	  $("#"+flow+"_closeHref").show();
	  $("#"+flow+"_openHref").hide();
	}
	function off(flow){
		$("#"+flow).hide(1000);
		$("#"+flow+"_closeHref").hide();
		$("#"+flow+"_openHref").show();
	} 
	
</script>
</c:if>
<script type="text/javascript">
$(document).ready(function(){
	 var trsLen=$(".sort").length;
	 while(trsLen>0){
		   for(var j=0;j<trsLen-1;j++){
			   var trs=$(".sort");
		     if(trs[j].id>trs[j+1].id){
		       $(trs[j+1]).insertBefore($(trs[j])); 
		     }	   
		   }
		   trsLen=trsLen-1;
	   } 
	});
</script>
<style>
.bs_tb a img{ padding-left:10px;padding-bottom:5px; }
.xllist td{text-align: center;}
</style>
     
            	 	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
	            		<input type="hidden" id="pageName" name="pageName" value="step4"/>
						<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
						<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
                					<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
                					<tr><th colspan="10" class="theader">四、主要完成人情况表<c:if test="${param.view!=GlobalConstant.FLAG_Y }"><span style="float: right;padding-right: 10px"><img  src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('applyUser');" title="添加主要完成人"/></span> </c:if></th></tr>
			          					<tr>
							           		<td style="text-align: center;" width="10%" >署名顺序</td>
							                <td style="text-align: center;" width="10%" >姓名</td>
							                <td style="text-align: center;" width="5%" >性别</td>
							                <td style="text-align: center;" width="10%" >出生日期</td>
							                <td style="text-align: center;" width="10%" >学历</td>
							                <td style="text-align: center;" width="10%" >学位</td>
							                <td style="text-align: center;" width="10%" >职称</td>
							                <td style="text-align: center;" width="15%" >工作单位</td>
							                <td style="text-align: center;" width="10%" >联系电话</td>
							                <td style="text-align: center;" width="10%" >操作</td>
			           					</tr>

							            <c:forEach var="apply" items="${resultMap.applyUser }" varStatus="num">
								        <tbody class="sort" id="${apply.objMap.applyUser_type }">
								        <tr>
								           <td style="text-align: center;">第${apply.objMap.applyUser_type}完成人</td>
								           <td style="text-align: center;">${apply.objMap.applyUser_name}</td>
								           <td style="text-align: center;">${apply.objMap.applyUser_sex}</td>
								           <td style="text-align: center;">${apply.objMap.applyUser_birthday}</td>
								           <td style="text-align: center;">${apply.objMap.applyUser_education}</td>
								           <td style="text-align: center;">${apply.objMap.applyUser_degree}</td>
								           <td style="text-align: center;">${apply.objMap.applyUser_title}</td>
								           <td style="text-align: center;">${apply.objMap.applyUser_orgBelong}</td>
								           <td style="text-align: center;">${apply.objMap.applyUser_phone} </td>
								           <td style="text-align: center;">
								           <c:if test="${param.view != GlobalConstant.FLAG_Y}">
								           [<a href="javascript:void(0);" onclick="edit('${apply.flow}','applyUser','${apply.objMap.applyUser_type }')">编辑</a>]&#12288;
								           [<a href="javascript:void(0);" onclick="del('${apply.flow}','applyUser')">删除</a>]
								           </c:if>
								            <c:if test="${param.view == GlobalConstant.FLAG_Y}">
								              <a id="${apply.flow}_openHref"  class="on" href="javascript:void(0);" onclick="on('${apply.flow}')">详细</a>
								              <a id="${apply.flow}_closeHref" class="off" href="javascript:void(0);" style="display: none;" onclick="off('${apply.flow}')">收起</a>
								            </c:if> 
								           </td>
								        </tr>
								        <c:if test="${param.view == GlobalConstant.FLAG_Y}">
								        <tr id="${apply.flow}" style="display: none;" class="intro">
								          <td colspan="10">
								             <table  width="100%" >
                    <tr >
                        <th colspan="6" style="text-align: left;padding-left: 20px;">${apply.objMap.applyUser_name}的详细信息</th>
                    </tr>
                 <tbody>
                      <tr>
                         <td style="width: 16%;text-align: center;">姓名</td>
                         <td style="text-align: left;">&#12288;
                             ${apply.objMap.applyUser_name}
                         </td>
                         <td style="width: 16%;text-align: center;">性别</td>
                         <td style="text-align: left;">&#12288;
                            ${apply.objMap.applyUser_sex}
                         </td>
                         <td style="width: 16%;text-align: center;">民族</td>
                         <td style="text-align: left;">&#12288;
                            ${apply.objMap.applyUser_nation }
                         </td>
                      </tr>
                     <tr>
                       <td style="width: 16%;text-align: center;">出生地</td>
                       <td colspan="3" style="text-align: left;">&#12288;
                          ${apply.objMap.applyUser_home }
                       </td>
                       <td style="width: 16%;text-align: center;">出生</td>
                       <td style="text-align: left;">&#12288;
                          ${apply.objMap.applyUser_birthday}
                       </td>
                     </tr>
                     <tr>
                        <td style="width: 16%;text-align: center;">政治面貌</td>
                        <td style="text-align: left;">&#12288;
                          ${apply.objMap.applyUser_politicalStatus }
                        </td>
                        <td style="width: 16%;text-align: center;">留学国家</td>
                        <td colspan="3" style="text-align: left;">&#12288;
                          ${apply.objMap.applyUser_studyAbroadArea }
                        </td>
                     </tr>
                     <tr>
                       <td style="width: 16%;text-align: center;">工作单位</td>
                       <td style="text-align: left;">&#12288;
                          ${apply.objMap.applyUser_orgBelong }
                       </td>
                        <td style="width: 16%;text-align: center;">联系电话</td>
                       <td colspan="3" style="text-align: left;">&#12288;
                          ${apply.objMap.applyUser_phone }
                       </td>
                     </tr>
                     <tr>
                       <td style="width: 16%;text-align: center;">通讯地址</td>
                       <td colspan="5" style="text-align: left;">&#12288;
                          ${apply.objMap.applyUser_address }
                       </td>
                     </tr>
                     <tr>
                       <td style="width: 16%;text-align: center;">毕业学校</td>
                       <td style="text-align: left;">&#12288;
                          ${apply.objMap.applyUser_graduateSchool }
                       </td>
                       <td style="width: 16%;text-align: center;">学历</td>
                       <td style="text-align: left;">&#12288;
                          ${apply.objMap.applyUser_education }
                       </td>
                       <td style="width: 16%;text-align: center;">学位</td>
                       <td style="text-align: left;">&#12288;
                          ${apply.objMap.applyUser_degree }
                       </td>
                     </tr>
                     <tr>
                       <td style="width: 16%;text-align: center;">职称</td>
                       <td style="text-align: left;">&#12288;
                          ${apply.objMap.applyUser_title }
                       </td>
                       <td style="width: 16%;text-align: center;">专业</td>
                       <td style="text-align: left;">&#12288;
                          ${apply.objMap.applyUser_major }
                       </td>
                        <td style="width: 16%;text-align: center;">毕业单位</td>
                       <td colspan="3" style="text-align: left;">&#12288;
                          ${apply.objMap.applyUser_graduateOrg }
                       </td>
                     </tr>
                     <tr>
                       <td style="width: 16%;text-align: center;">外语语种</td>
                       <td style="text-align: left;">&#12288;
                          ${apply.objMap.applyUser_foreignLanguageType }
                       </td>
                       <td style="width: 16%;text-align: center;">熟练程度</td>
                       <td colspan="5" style="text-align: left;">
                          &#12288; <c:if test="${apply.objMap.applyUser_skillful eq 'jt'}">精通</c:if>
                          <c:if test="${apply.objMap.applyUser_skillful eq 'sl'}">熟练</c:if>
                          <c:if test="${apply.objMap.applyUser_skillful eq 'lh'}">良好</c:if>
                          <c:if test="${apply.objMap.applyUser_skillful eq 'yb'}">一般</c:if>
                       </td>
                     </tr>
                     <tr>
                      <td style="width: 16%;text-align: center;">曾获奖励及荣誉称号</td>
                       <td colspan="5" style="text-align: left;">
                         <textarea  placeholder="此处填写曾获奖励及荣誉称号情况" style="height:120px;width:100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">border-style: none;</c:if>" class="xltxtarea" name="applyUser_rewardHistory" >
                         ${apply.objMap.applyUser_rewardHistory}
                         </textarea>
                       </td>
                     </tr>
                     <tr>
                       <td style="width: 16%;text-align: center;">参加本项目的起止时间</td>
                       <td colspan="5" style="text-align: left;">
                          ${apply.objMap.applyUser_joinStartTime}&#12288;至&#12288;${apply.objMap.applyUser_joinEndTime}
                       </td>
                     </tr>
                     <tr>
                       <td style="width: 16%;text-align: center;">所做贡献</td>
                       <td colspan="5" style="text-align: left;">
                          <textarea style="height:120px;width:100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">border-style: none;</c:if>" placeholder="此处填写所做贡献情况" class="xltxtarea" name="applyUser_devote" >${apply.objMap.applyUser_devote}</textarea>
                       </td>
                     </tr>
                 </tbody>
           </table>
								          </td>
								        </tr>
								        </c:if>
								        </tbody>
								      </c:forEach>
								    
      								</table> 
            		</form>
            		<div class="button" style="width:100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
         				<input id="prev" type="button" onclick="nextOpt('step3')" class="search" value="上一步"/>
         				<input id="nxt" type="button" onclick="nextOpt('step5')" class="search" value="下一步"/>
  					</div>
