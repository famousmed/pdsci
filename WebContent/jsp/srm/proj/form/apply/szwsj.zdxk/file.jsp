<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
	function save(){
		$('#sv').attr({"disabled":"disabled"});
		jboxStartLoading();
		$('#fileForm').submit();
	}
	
	var callBack = function(result){
		if(result=="1"){
			jboxTip("保存成功");
			doClose();
		}else{
			jboxTip("保存失败");
		}
		
	};
	function refreshOpener(){
		window.parent.frames['mainIframe'].location.reload(true);
	}
	function doClose() {
		refreshOpener();
		jboxClose();
	}
</script>
</c:if>

        <form id="fileForm" action="<s:url value="/srm/proj/mine/savePageGroupStep"/>" method="post" enctype="multipart/form-data" target="screct_frame" style="position: relative;">
			<input type="hidden" name="pageName" value="${param.pageName}"/>
			<input type="hidden" name="itemGroupName" value="${param.itemGroupName}"/>
			<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
            <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
			<input type="hidden" name="itemGroupFlow" value="${param.itemGroupFlow}"/>
           <table class="basic" style="width: 100%">
                 <thead>
                    <tr>
                        <th colspan="4" class="bs_name">附件</th>
                    </tr>
                 </thead>
                 <tbody>
                 	  <tr>
                         <th  width="40%">颁发时间：</th>
                         <td>
			           		<input type="text" readonly="readonly" name="certificate_awardTime" class="ctime"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:80%;"/>
			           	 </td>
                      </tr>
                      <tr>
                         <th>名称：</th>
                         <td>
                         	<input class="validate[required]" name="certificate_fileName" type="text"  style="width:80%;"/>
                         </td>
                      </tr>
                      <tr>
                         <th>完成人：</th>
                         <td>
			           		<input type="text" name="certificate_publishPerson"  style="width:80%;"/>
			           	 </td>
                      </tr>
                      <tr>
                         <th>发明专利或新药证书：</th>
                         <td>
                         	<input type="file" name="certificate_file" class="validate[required]" />
                         </td>
                      </tr>
                      <tr>
                         <th>等级：</th>
                         <td>
			           		<input type="text" name="certificate_grade" style="width:80%;"/>
			             </td>
                      </tr>
                 </tbody>
           </table>
           <div class="button">
		   	<input class="search" id="sv" type="button" onclick="save();" value="保存"/>
      	   </div>
           </form>

			<iframe name="screct_frame" style="display: none"></iframe>
			
