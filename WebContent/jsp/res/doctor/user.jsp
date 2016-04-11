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
	<jsp:param name="jquery_cxselect" value="true"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>

<script type="text/javascript">
	function saveOrg() {
		var url = "<s:url value='/sys/org/save'/>";
		$("#orgProvName").val($("#orgProvId option:selected").text());
		$("#orgCityName").val($("#orgCityId option:selected").text());
		$("#orgAreaName").val($("#orgAreaId option:selected").text());
		var data = $('#sysOrgForm').serialize();
		jboxPost(url, data, function() {
			//window.parent.frames['mainIframe'].window.search();
			//jboxClose();
		});
	}
</script>
</head>
<body>	
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
		<form id="sysOrgForm">
   		<table class="basic" width="100%">
   			<tr>
                <th colspan="6" style="text-align: left;">&#12288;基本信息</th>
            </tr>
      		<tr>
             	<td width="100px;">用户名：</td>
                <td>
                    <input class="validate[required] " name="orgCode" type="text" value="${sysOrg.orgCode }" />
				</td>
                   <td width="100px;">工号：</td>
                <td>
                     <input name="orgName" type="text" value="${sysOrg.orgName }" class=""/>
                </td>           
                <td width="100px;">证件号：</td>
                <td>
                     <input name="orgName" type="text" value="${sysOrg.orgName }" class=""/>
                </td>                                    
             </tr>
           <tr>
             	<td width="100px;">姓名：</td>
                <td>
                    <input class="validate[required] " name="orgCode" type="text" value="${sysOrg.orgCode }" />
				</td>
                   <td width="100px;">性别：</td>
                <td>
                     <select style="width: 156px;">
                     	<option>男</option>
                     	<option>女</option>
                     </select>
                </td>           
                <td width="100px;">出生日期：</td>
                <td>
                     <input name="orgName" type="text" value="${sysOrg.orgName }" class=""/>
                </td>                                    
             </tr>
             <tr>
             	<td width="100px;">手机：</td>
                <td>
                    <input class="validate[required] " name="orgCode" type="text" value="${sysOrg.orgCode }" />
				</td>
                   <td width="100px;">E-mail：</td>
                <td>
                     <input name="orgName" type="text" value="${sysOrg.orgName }" class=""/>
                </td>           
                <td width="100px;">毕业院校：</td>
                <td>
                     <select style="width: 156px;">
                     	<option>南京医科大学</option>
                     </select>
                </td>                                    
             </tr>
              <tr>
             	<td width="100px;">所学专业：</td>
                <td>
                    <input class="validate[required] " name="orgCode" type="text" value="${sysOrg.orgCode }" />
				</td>
                   <td width="100px;">学历：</td>
                <td>
                    <select style="width: 156px;">
                     	<option>大专</option>
                     	<option>本科</option>
                     	<option>研究生</option>
                     	<option>博士</option>
                     </select>
                </td>           
                <td width="100px;">学位：</td>
                <td>
                    <select style="width: 156px;">
                     	<option>学士</option>
                     	<option>硕士</option>
                     	<option>博士</option>
                     	<option>院士</option>
                     </select>
                </td>                                    
             </tr>
               <tr>
             	<td width="100px;">毕业时间：</td>
                <td>
                    <input class="validate[required] " name="orgCode" type="text" value="${sysOrg.orgCode }" />
				</td>
                   <td width="100px;">工作单位：</td>
                <td>
                     <input name="orgName" type="text" value="${sysOrg.orgName }" class=""/>
                </td>           
                <td width="100px;">入院时间：</td>
                <td>
                     <input name="orgName" type="text" value="${sysOrg.orgName }" class=""/>
                </td>                                    
             </tr>
               <tr>
             	<td width="100px;">培训专业：</td>
                <td>
                    <select style="width: 156px;">
                     	<option>麻醉学</option>
                     </select>
				</td>
                   <td width="100px;">医师状态：</td>
                <td>
                       <select style="width: 156px;">
                     	<option>在培</option>
                   		<option>结业</option>
                     </select>
                </td>           
                <td width="100px;">医师走向：</td>
                <td>
                     <select style="width: 156px;">
                     	<option></option>
                     </select>
                </td>                                    
             </tr>
               <tr>
             	<td width="100px;">是否结业：</td>
                <td>
                   <select style="width: 156px;">
                     	<option>否</option>
                     	<option>是</option>
                     </select>
				</td>
                   <td width="100px;">结业时间：</td>
                <td>
                     <input name="orgName" type="text" value="${sysOrg.orgName }" class=""/>
                </td>           
                <td width="100px;">毕业证书号：</td>
                <td>
                     <input name="orgName" type="text" value="${sysOrg.orgName }" class=""/>
                </td>                                    
             </tr>
              <tr>
             	<td width="100px;">导师：</td>
                <td>
                    <select style="width: 156px;">
                     	<option>(带教老师)徐磊</option>
                     </select>
				</td>
				<td width="100px;"></td>
                <td>
				</td>
				<td width="100px;"></td>
                <td>
				</td>
             </tr>
              </table>
              <!-- 
            <table class="xllist" style="width: 100%;margin-top: 10px;"> 
             <tr>
                <th colspan="7" style="text-align: left;">&#12288;个人履历
                <span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('thesis')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('thesis');"></img></span></th>
             </tr>
             <tr>
             			<th width="50px;"><input type="checkbox"/></th>
                		<th width="200px;">开始时间</th>
                		<th width="200px;">结束时间</th>
                		<th width="200px;">工作单位</th>
                		<th  width="200px;">专业</th>
                		<th>学历</th>
                		<th>学位</th>
                	</tr>
			</table>
			<table class="xllist" style="width: 100%;margin-top: 10px;"> 
                	<tr  >
                		<th colspan="6" style="text-align: left;">&#12288;工作记录
                		<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('thesis')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('thesis');"></img></span>
                		</th>
                	</tr>
                	<tr>
                		<th width="50px;"><input type="checkbox"/></th>
                		<th width="200px;">开始时间</th>
                		<th width="200px;">结束时间</th>
                		<th width="200px;">工作单位</th>
                		<th  width="200px;">工作专业</th>
                		<th>技术职称</th>
                	</tr>
                   
                </table>
                 -->
			<p align="center">
				<input class="search" type="button" value="保&#12288;存"  onclick="saveOrg();" />
				<input type="hidden" name="orgFlow" value="${sysOrg.orgFlow}" /> 
			</p>
		</form>
         </div>
        
     </div> 	
   </div>	
</body>
</html>