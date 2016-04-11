<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
    <jsp:param name="jquery_ui_combobox" value="true"/>
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script type="text/javascript">
  	$(document).ready(function(){
	});
	function searchProj() {
		jboxStartLoading();
		$("#searchForm").submit();
	}
	
	function audit(projFlow){
		jboxStartLoading();
		jboxOpen("<s:url value='/srm/proj/apply/audit'/>?projFlow="+projFlow,"审核", 900, 600);
	}
	
	function auditList(projFlow){
		jboxStartLoading();
		jboxOpen("<s:url value='/srm/proj/mine/auditList?projFlow='/>"+projFlow,"审核信息", 900, 600);
	}
	
	//加载申请单位
	function loadApplyOrg(){
		//清空
		var org = $('#org');
		org.html('<option value="">请选择</option>');
		var chargeOrgFlow = $('#chargeOrg').val();
		if(!chargeOrgFlow){
			return ;
		}
		var url = "<s:url value='/sys/org/loadApplyOrg'/>?orgFlow="+chargeOrgFlow;
		jboxStartLoading();
		jboxGet(url , null , function(data){
			$.each(data , function(i , n){
				org.append('<option value="'+n.orgFlow+'">'+n.orgName+'</option>');
			});
		} , null , false);
		//searchProj();
	}
	
	/* //加载申请单位New
	function loadApplyOrgNew(){
		//清空
		$('#orgDt').html("");
		$('#orgDt').append('<select id="org" name="applyOrgFlow" class="xlselect"></select>')
		//$("#org").append('<option>'+"请选择"+'</option>');
		var chargeOrgFlow = $('#chargeOrg').val();
		if(!chargeOrgFlow){
			return ;
		}
		var url = "<s:url value='/sys/org/loadApplyOrg'/>?orgFlow="+chargeOrgFlow;
		jboxStartLoading();
		jboxGet(url , null , function(data){
			$.each(data , function(i , n){
				$("#org").append('<option value="'+n.orgFlow+'">'+n.orgName+'</option>');
			});
			 $("#org").scombobox({
					forbidInvalid : true,
					invalidAsValue : true,
					expandOnFocus : false
				});
				$(".scombobox-display").css("height","25px");
				$(".scombobox-display").css("border","1px solid #bdbebe");
				$(".scombobox-display").css("width","167px");
				$(".scombobox-list").css("width","167px"); 
		} , null , false);
		
	} */
	
	function delProj(projFlow){
		var url = "<s:url value='/srm/proj/mine/del?projFlow='/>"+projFlow;
		jboxConfirm("确认删除该项目？" , function(){
			jboxStartLoading();
			jboxGet(url , null , function(){
				searchProj();
			} , null , true);
		});
	}
	
	function toPage(page) {
		if(page!=undefined){
			$("#currentPage").val(page);			
		}
		searchProj();
	}
	
	function exportExcel(){
		var url = "<s:url value='/srm/proj/apply/exportExcel/${sessionScope.projListScope}/${sessionScope.projCateScope}?recTypeId=${param.recTypeId}'/>"
		jboxSubmit($('#searchForm'), url, null, null);
		jboxEndLoading();
	}
</script>
</head>
<body>
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
        	<form id="searchForm" action="<s:url value="/srm/proj/apply/list/${sessionScope.projListScope}/${sessionScope.projCateScope}?recTypeId=${param.recTypeId}" />"
				method="post">
                <p>
              	年&#12288;&#12288;份：
              	<input type="text" class="xltext ctime" name="projYear" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})" value="${param.projYear }"/>
          		  项目类型：
          		  	<select class="xlselect" name="projTypeId">
          		  		<option value="">请选择</option>
                       	<c:forEach var="dictEnuProjType" items="${dictTypeEnumProjTypeList}">
                       		<option value="${dictEnuProjType.dictId}" <c:if test='${param.projTypeId==dictEnuProjType.dictId}'>selected="selected"</c:if>>${dictEnuProjType.dictName}</option>
                       	</c:forEach>
          		  	</select>
           	</p>
            <p>
            	<c:if test='${sessionScope.projListScope=="charge"}'>
            		申报单位：
            		<select name="applyOrgFlow" class="xlselect">
            			<option value="">请选择</option>
            			<c:forEach var="org" items="${orgList}">
            				<option  value="${org.orgFlow}" <c:if test="${param.applyOrgFlow==org.orgFlow}">selected</c:if>>${org.orgName}</option>
            			</c:forEach>
            		</select>
            	</c:if>
            	
            	<c:if test='${sessionScope.projListScope=="global" }'>
            		主管部门：
            		<select id="chargeOrg" name="chargeOrgFlow" onchange="loadApplyOrg();" class="xlselect">
            			<option value="">请选择</option>
            			<c:forEach var="chargeOrg" items="${chargeOrgList}">
            				<option value="${chargeOrg.orgFlow}" <c:if test="${param.chargeOrgFlow==chargeOrg.orgFlow}">selected</c:if>>${chargeOrg.orgName}</option>
            			</c:forEach>
            		</select>
            		
            		申报单位：
            		<select id="org" name="applyOrgFlow" class="xlselect">
            			<option value="">请选择</option>
            			<c:forEach var="org" items="${orgList}">
            				<option value="${org.orgFlow}" <c:if test="${param.applyOrgFlow==org.orgFlow}">selected</c:if>>${org.orgName}</option>
            			</c:forEach>
            		</select>
            	</c:if>
            	
            	项目名称：&nbsp;<input type="text" name="projName" value="${param.projName}" class="xltext"/>
				<input id="currentPage" type="hidden" name="currentPage" value=""/>
				<input type="button" class="search" onclick="searchProj();" value="查&#12288;询">
				<c:if test="${pdfn:contains(param.projTypeId, 'yhwsj') and sessionScope.projListScope eq 'global'}">
					<input type="button" class="search" onclick="exportExcel();" value="导出Excel">
				</c:if>
            </p>   
         </form>
        </div>
        <table class="xllist">
		     <thead>
		         <tr>
		             <th width="5%">年份</th>
		             <th width="10%">项目类别</th>
		             <th width="20%">项目名称</th>
		             <c:if test="${sessionScope.projListScope eq 'charge' or sessionScope.projListScope eq 'global'}">
						<th width="20%" >申报单位</th>
					 </c:if>
		             <th width="10%">申报人</th>
		             <th width="10%">起止时间</th>
		             <th width="10%">当前阶段</th>
		             <th width="10%">当前状态</th>
		             <th width="5%">审核意见</th>
		             <th width="5%">操作</th>
		         </tr>
		     </thead>
             <tbody>
             	<c:forEach items="${projList}" var="proj" varStatus="sta">
                	<tr>
                		<td>${proj.projYear}</td>
                		<td>${proj.projTypeName}</td>
                		<td><a style="color:blue;" href="<s:url value='/srm/proj/mine/auditProjView?projFlow=${proj.projFlow}'/>" target="_blank">${proj.projName}</a></td>
                		<c:if test="${sessionScope.projListScope eq 'charge' or sessionScope.projListScope eq 'global'}">
							<td>${proj.applyOrgName}</td>
						</c:if>
                		<td>${proj.applyUserName}</td>
                		<td>${proj.projStartTime}~<br/>${proj.projEndTime}</td>
                		<td>${proj.projStageName}</td>
                		<td>${proj.projStatusName}</td>
                		<td>[<a href="javascript:void(0)" onclick="auditList('${proj.projFlow}');">查看</a>]</td>
                		<td>[<a href="javascript:audit('${proj.projFlow}');">审核</a>]
                		<c:if test='${sessionScope.projListScope=="local" }'>
                		[<a href="javascript:delProj('${proj.projFlow}');">删除</a>]
                		</c:if>
                		</td>
                    </tr>
                </c:forEach>
             </tbody>
        </table>
        <c:set var="pageView" value="${pdfn:getPageView(projList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>	   
     </div> 	
   </div>
</body>
</html>