<jsp:include page="/jsp/sczyres/htmlhead-sczyres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
	<div class="main_bd">
	  <ul class="div_table">
          <li class="score_frame">
	         <h1>报名信息</h1>
	         <div class="sub_menu">
              <h3>人员类型：${doctor.doctorTypeName}</h3>
             </div>	
		
     <div class="div_table">
     	<h4>基本信息</h4>	
		<table border="0" cellspacing="0" cellpadding="0" class="base_info">
		   <colgroup>
              <col width="12%"/>
              <col width="22%"/>
              <col width="12%"/>
              <col width="22%"/>
              <col width="12%"/>
              <col width="20%"/>
            </colgroup>
	     	 <tr>
				<th><font color="red">*</font>姓名：</th>
				<td>${user.userName}</td>
				<th><font color="red">*</font>出生日期：</th>
				<td colspan="2">${user.userBirthday}</td>
				<td rowspan="3" style="text-align: center; padding-top:5px; padding-bottom:5px;">
					<img src="${sysCfgMap['upload_base_url']}/${user.userHeadImg}" height="120px" onerror="this.src='<s:url value="/jsp/edu/css/images/up-pic.jpg"/>'"/>
				</td>
			</tr>
			<tr>
			    <th><font color="red">*</font>性别：</th>
				<td>${user.sexName}</td>
				<th>籍贯：</th>
				<td colspan="2">${extInfo.nativePlace}</td>
			</tr>
			<tr>
	            <th>民族：</th>
	            <td>${user.nationName}</td>
	            <th>健康状况：</th>
	            <td colspan="2">${extInfo.healthStatus}</td>
	        </tr>
	        <tr>
	                   <th>政治面貌：</th>
	                   <td>${extInfo.political}</td>
	                   <th>婚姻状况：</th>
	                   <td>${extInfo.maritalStatus}</td>
	                   <th>既往病史：</th>
	                   <td>${extInfo.beforeCase}</td>
	               </tr>               
	               <tr>
	                   <th>外语水平：</th>
	                   <td>${doctor.foreignSkills}</td>
	                   <th><font color="red">*</font>最高学历：</th>
	                   <td>
	                       <c:forEach items="${dictTypeEnumUserEducationList}" var="dict">
							    <c:if test='${user.educationId eq dict.dictId}'>
							        ${dict.dictName}
							    </c:if>
						   </c:forEach>
	                   </td>
	                   <th>现工作单位：</th>
	                   <td>${extInfo.societyWork}</td>
	               </tr>	               
	               <tr>
	                   <th><font color="red">*</font>毕业专业：</th>
	                   <td>${doctor.specialized}</td>
	                   <th><font color="red">*</font>学位：</th>
	                   <td>
	                       <c:forEach items="${dictTypeEnumUserDegreeList}" var="dict">
							    <c:if test='${user.degreeId eq dict.dictId}'>
							          ${dict.dictName}
							    </c:if>
						   </c:forEach>
	                   </td>
	                   <th><font color="red">*</font>有无医师执照：</th>
	                   <td>
	                       <c:if test="${doctor.doctorLicenseFlag eq GlobalConstant.FLAG_Y}">有</c:if>
	                       <c:if test="${doctor.doctorLicenseFlag eq GlobalConstant.FLAG_N}">无</c:if>
	                   </td>
	               </tr>	               
	               <tr>
	               	   <th><font color="red">*</font>毕业院校：</th>
	                   <td colspan="3">${doctor.graduatedName}</td>
	               	   <th><font color="red">*</font>最高学历毕业时间：</th>
	                   <td>${doctor.graduationTime}</td>
	               </tr>	               
	               <tr>
	               	   <th><font color="red">*</font>身份证号：</th>
	                   <td colspan="3">${user.idNo}</td>
	                   <th><font color="red">*</font>是否应届生：</th>
	                   <td style="padding-left: 10px;">
	                       <c:if test="${extInfo.yearGraduateFlag eq GlobalConstant.FLAG_Y}">是</c:if>
	                       <c:if test="${extInfo.yearGraduateFlag eq GlobalConstant.FLAG_N}">否</c:if>
	                   </td>
	               </tr>	               
	               <tr>
	               	   <th><font color="red">*</font>规培生源地：</th>
	                   <td colspan="5">
	                       	${extInfo.birthProvName}-${extInfo.birthCityName}-${extInfo.birthAreaName}
	                   </td>
	               </tr>	               		
	               <tr>
	               	   <th><font color="red">*</font>家庭住址 ：</th>
	                   <td>${extInfo.homeAddress}</td>
	                   <th><font color="red">*</font>家庭电话 ：</th>
	                   <td>${extInfo.homePhome}</td>
	                   <th><font color="red">*</font>邮编 ：</th>
	                   <td>${extInfo.zipCode}</td>
	               </tr>
		</table>
		</div>
		
		<div class="div_table" ID="contactway">
			<h4>本人联系方式</h4>
	        <table border="0" cellpadding="0" cellspacing="0" class="base_info">
	            <colgroup>
	              <col width="12%"/>
	              <col width="22%"/>
	              <col width="12%"/>
	              <col width="54%"/>
	            </colgroup>
		           <tbody>
		               <tr>
		                   <th><font color="red">*</font>手机号码：</th>
	                   	   <td>${user.userPhone}</td>
		                   <th><font color="red">*</font>通讯地址：</th>
	                   	   <td>${user.userAddress}</td>
		               </tr>
		               <tr>
		                   <th><font color="red">*</font>E-mail：</th>
	                   	   <td>${user.userEmail}</td>
		                   <th>其它方式：</th>
	                   	   <td>${extInfo.otherWay}</td>
		               </tr>
		           </tbody>
		       </table>
		      </div>
              
            <div class="div_table">
			<h4>工作（实习）经历</h4>
	         <table border="0" cellpadding="0" cellspacing="0" class="grid">
	         	<colgroup>
	         		<col width="5%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					</colgroup>
					<tr style="font-weight: bold;">
					  <th></th>
		              <th><font color="red">*</font>临床工作<br/>起止时间</th>
		              <th>时间长度</th>
		              <th><font color="red">*</font>医院名称</th>
		              <th>医院级别</th>
		              <th>科室</th>
		              <th>职务</th>
		              <th>证明人</th>
		              <th>证明人<br/>现任何职</th>
		              <th>证明人<br/>联系电话</th>
		           </tr>
					<tbody id="workTb">
					<c:if test="${fn:length(extInfo.workResumeList)>0 }">
					<c:forEach var="resume" items="${extInfo.workResumeList}" varStatus="status">
					<tr>
					  <td>${status.count}</td>
                      <td>${resume.clinicalRoundDate}</td>
		              <td>${resume.dateLength}</td>
		              <td>${resume.hospitalName}</td> 
		              <td>${resume.hospitalLevel}</td>
		              <td>${resume.deptName}</td>
		              <td>${resume.postName}</td>
		              <td>${resume.witness}</td>
		              <td>${resume.witnessPost}</td>
		              <td>${resume.witnessPhone}</td>
					</tr>
					</c:forEach>
					</c:if>
					<c:if test="${empty extInfo.workResumeList}">
						<tr><td colspan="10">无记录</td></tr>
					</c:if>
				    </tbody>
	        </table>
	        </div>
	        
	        <div class="div_table">
				<h4>证书及文件</h4>
		        <table border="0" cellpadding="0" cellspacing="0" class="base_info">
		        
		           <tr>
			          <th width="20%"><font color="red">*</font>身份证图片：</th>
			          <td colspan="3">
			          	  <span id="idNoUriSpan" style="display:${!empty extInfo.idNoUri?'':'none'} ">
		              	      [<a href="${sysCfgMap['upload_base_url']}/${extInfo.idNoUri}" target="_blank">查看图片</a>]&#12288;
		            	  </span>
			          </td>
			       </tr> 
			       <tr>
			          <th><font color="red">*</font>毕业证编号：</th>
			          <td colspan="3">
			              ${empty doctor.certificateNo?"无":doctor.certificateNo}
			              <c:if test='${!empty extInfo.certificateUri}'>
			                  <span id="certificateUriSpan">
		              	          [<a href="${sysCfgMap['upload_base_url']}/${extInfo.certificateUri}" target="_blank">查看图片</a>]&#12288;
		            	      </span>
			              </c:if>
			          </td>
			       </tr> 
			       <tr>
			          <th>学位证编号：</th>
			          <td colspan="3">
			               ${empty doctor.degreeNo?"无":doctor.degreeNo}
			               <c:if test='${!empty extInfo.degreeUri}'>
			                   <span id="degreeUriSpan">
		              	           [<a href="${sysCfgMap['upload_base_url']}/${extInfo.degreeUri}" target="_blank">查看图片</a>]&#12288;
		            	       </span>
			               </c:if>
			              
			          </td>
			       </tr> 
			       <tr>
			          <th>
			    <c:if test="${doctor.doctorLicenseFlag eq GlobalConstant.FLAG_Y }"><font color='red'>*</font></c:if>      
			          医师资格证书编号：</th>
			          <td colspan="3">
			              ${empty doctor.qualifiedNo?"无":doctor.qualifiedNo}
			              <c:if test='${!empty extInfo.qualifiedUri}'>
			                  <span id="qualifiedUriSpan">
		              	          [<a href="${sysCfgMap['upload_base_url']}/${extInfo.qualifiedUri}" target="_blank">查看图片</a>]&#12288;
		            	      </span>
			              </c:if>
			              
			          </td>
			       </tr>     
			       <c:if test="${doctor.doctorLicenseFlag eq GlobalConstant.FLAG_Y}">
			       <tr class="yszz">
			          <th><font color="red">*</font>医师执业证书编号：</th>
			          <td colspan="3">
			               ${empty doctor.regNo?"无":doctor.regNo}
			               <c:if test='${!empty extInfo.regUri}'>
			                   <span id="regUriSpan">
		              	           [<a href="${sysCfgMap['upload_base_url']}/${extInfo.regUri}" target="_blank">查看图片</a>]&#12288;
		            	       </span>
			               </c:if>
			          </td>
			       </tr>   
			       </c:if>         
			    </table>
			</div>
	        
             <c:if test='${sczyRecDocTypeEnumAgency.id eq doctor.doctorTypeId}'>
             <div class="div_table">
				<h4>单位信息</h4>
		        <table border="0" cellpadding="0" cellspacing="0" class="base_info">
			       <tr>
			          <th width="34%"><font color="red">*</font>工作单位：</th>
			          <td width="66%">${doctor.workOrgName}</td>
			       </tr> 
			       <tr>
			          <th>委培单位同意证明：</th>
			          <td>
			              <span id="dispatchFileFSpan" style="display:${!empty doctor.dispatchFile?'':'none'} ">
		              	      [<a href="${sysCfgMap['upload_base_url']}/${doctor.dispatchFile}" target="_blank">查看图片</a>]&#12288;
		            	  </span>
			          </td>
			       </tr>        
			    </table>
			</div>
			</c:if>
		
	<div class="div_table">
	  <h4>志愿填报信息</h4>
		<table border="0" width="945" cellspacing="0" cellpadding="0" class="base_info" style="margin-bottom: 10px;">
		    <colgroup>
	            <col width="12%"/>
	            <col width="54%"/>
	            <col width="12%"/>
	            <col width="22%"/>
	        </colgroup>
            <c:forEach items='${recruits}' var='recruit'>
                <tr>
				<th>基地名称：</th>
				<td>${recruit.orgName}</td>
				<th>专业名称：</th>
				<td>${recruit.catSpeName}-${recruit.speName} &nbsp;&nbsp;
				    <c:if test='${recruit.recruitFlag eq "Y" and recruit.recruitTypeId eq recruitTypeEnumFill.id}'>(已录取)</c:if>
				    <c:if test='${recruit.recruitFlag eq "Y" and recruit.recruitTypeId eq recruitTypeEnumSwap.id}'>(调剂)</c:if>
				    <c:if test='${recruit.recruitFlag eq "N"}'>(未录取)</c:if>
				</td>
			</tr>
            </c:forEach>    
		</table>
	</div>
	</li>
  </ul>	
	</div>
