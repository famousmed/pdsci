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
	$(document).ready(function(){
		// 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件 
		$.cxSelect.defaults.url = "<s:url value='/js/provCityAreaJson.min.json'/>"; 
		$.cxSelect.defaults.nodata = "none"; 

		$("#provCityAreaId").cxSelect({ 
		    selects : ["province", "city", "area"], 
		    nodata : "none" ,
			firstValue : ""
		}); 
	});		
</script>
</head>
<body>	
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
		<form id="sysOrgForm">
   		<table class="basic" width="100%">
   			<tr>
                <th colspan="4" style="text-align: left;">&#12288;机构信息：</th>
            </tr>
      		<tr>
             	<td>机构代码：</td>
                <td>
                    <input class="validate[required] xltext" name="orgCode" type="text" value="${sysOrg.orgCode }" />
				</td>
                          
                <td>机构名称：</td>
                <td>
                     <input name="orgName" type="text" value="${sysOrg.orgName }" class="xltext"/>
                </td>                                    
             </tr>
             <tr>
                <td>所属地区：</td>
                <td colspan="3">
                	<div id="provCityAreaId" style="width: 600px;display:block; float:left; ">
						<select id="orgProvId" name="orgProvId" class="province xlselect" data-value="${sysOrg.orgProvId}" data-first-title="选择省"></select>
						<select id="orgCityId" name="orgCityId" class="city xlselect" data-value="${sysOrg.orgCityId}" data-first-title="选择市"></select>
						<select id="orgAreaId" name="orgAreaId" class="area xlselect" data-value="${sysOrg.orgAreaId}" data-first-title="选择地区"></select>
						<input id="orgProvName" name="orgProvName" type="hidden" value="${sysOrg.orgProvName}">
						<input id="orgCityName" name="orgCityName" type="hidden" value="${sysOrg.orgCityName}">
						<input id="orgAreaName" name="orgAreaName" type="hidden" value="${sysOrg.orgAreaName}">
					</div>
                </td>             
             </tr>
             <tr>
                <td>机构地址：</td>
                <td>
                   	<input name="orgAddress" type="text" value="${sysOrg.orgAddress }" class="xltext" style="width: 300px;"/>
                   	&#12288;&nbsp;邮编:  	<input name="orgZip" type="text" value="${sysOrg.orgZip }" class="xltext" style="width: 100px;"/>
                </td>
                <td>机构电话：</td>
                <td>
                    <input name="orgPhone" type="text" value="${sysOrg.orgPhone }"  class="xltext"/>
                </td>                   
             </tr>
               
             <tr>
                <th colspan="4" style="text-align: left;">&#12288;单位负责人：</th>
             </tr>
             <tr>
                <td >姓名：</td>
                <td> 	
                   	<input type="text" name="orgInfo.name" value="${orgInfoData['orgInfo.name']}" class="xltext"/>
                </td>
                <td >电话：</td>
                <td>
                    <input type="text"  name="orgInfo.phone" value="${orgInfoData['orgInfo.phone']}"  class="xltext"/>
                </td>
              <tr>
                   <td>职务：</td>
                   <td>
                      	<input type="text" name="orgInfo.duty" value="${orgInfoData['orgInfo.duty']}"  class="xltext"/>
                  	</td>
                   <td>职称：</td>
                   <td>
                        <input type="text" name="orgInfo.jobTitle" value="${orgInfoData['orgInfo.jobTitle']}"  class="xltext"/>
                  	</td>
               </tr>
              <!-- 
                       <tr style="height:26px">
                           <td style="text-align:right" class="td_blue">组织机构代码证：</td>
                           <td style="text-align:left;padding-left:5px" class="td_blue">
                              <input class="validate[required] text-input" style="margin-top: 5px" type="file" name=""  value=""/>
</td>
                          
                           <td style="text-align:right" class="td_blue">工商营业执照：</td>
                           <td style="text-align:left;padding-left:5px" class="td_blue" colspan="3">
                              <input class="validate[required] text-input" style="margin-top: 5px" type="file" name="" id="" value=""/>
                           </td>                                    
                       </tr> -->
             	<tr>
                   <td class="td_blue">单位网址：</td>
                   <td colspan="3">
                   	<input class="validate[required,custom[url]] xltext" name="orgInfo.website" type="text" value="${orgInfoData['orgInfo.website']}" style="width: 500px;"/>
                   </td>
               </tr>
			</table>
			<table class="xllist" style="width: 100%"> 
                	<tr  >
                		<th colspan="6" style="text-align: left;">&#12288;基本信息：</th>
                	</tr>
                    <tr >
                        <td>职工总人数：</td>
                        <td>
                            <input name="orgInfo.workerSum" type="text" value="${orgInfoData['orgInfo.workerSum']}" class="xltext"/>
                        </td>
                        <td> 科技人员（人）：</td>
                        <td>
                            <input name="orgInfo.technologyWorkCount" type="text" value="${orgInfoData['orgInfo.technologyWorkCount']}" class="xltext"/>
                        </td>
                        <td>研发人员（人）：</td>
                        <td>
                            <input name="orgInfo.developmentWorkCount" type="text" value="${orgInfoData['orgInfo.developmentWorkCount']}" class="xltext"/>
                        </td>
                    </tr>
                    <tr>
                        <td>年研发经费（万元）： </td>
                        <td>
                            <input name="orgInfo.yearCost" type="text" value="${orgInfoData['orgInfo.yearCost']}" class="xltext"/>
                        </td>
                        <td>拥有专利数：</td>
                        <td>
                            <input name="orgInfo.patentCount" type="text" value="${orgInfoData['orgInfo.patentCount']}" class="xltext"/>
                        </td>
                        <td>其中：发明专利数：</td>
                        <td>
                            <input name="orgInfo.patentInventionCount" type="text" value="${orgInfoData['orgInfo.patentInventionCount']}" class="xltext"/>
                        </td>
                    </tr>
                    <tr>
                        <td>拥有软件著作权数：</td>
                        <td>
                            <input name="orgInfo.patentWriteCount" type="text" value="${orgInfoData['orgInfo.patentWriteCount']}" class="xltext"/>
                        </td>
                        <td>年产值（万元）：</td>
                        <td>
                            <input name="orgInfo.yearOutputVal" type="text" value="${orgInfoData['orgInfo.yearOutputVal']}" class="xltext"/>
                        </td>
                        <td>年销售额（万元）：</td>
                        <td>
                            <input name="orgInfo.yearMarketVal" type="text" value="${orgInfoData['orgInfo.yearMarketVal']}" class="xltext"/>
                        </td>
                    </tr>
                    <tr>
                        <td>年创汇（万美元）： </td>
                        <td>
                            <input name="orgInfo.yearEarning" type="text" value="${orgInfoData['orgInfo.yearEarning']}" class="xltext"/>
                        </td>
                        <td>缴税金（万元）： </td>
                        <td>
                            <input name="orgInfo.taxes" type="text" value="${orgInfoData['orgInfo.taxes']}" class="xltext"/>
                        </td>
                        <td>年利润（万元）： </td>
                        <td>
                            <input name="orgInfo.yearProfit" type="text" value="${orgInfoData['orgInfo.yearProfit']}" class="xltext"/>
                        </td>
                    </tr>
                </table>
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