	<div class="div_table">
        <h4>
        	培训信息
        </h4>
			<table border="0" cellpadding="0" cellspacing="0" class="base_info">
            <colgroup>
              <col width="15%"/>
              <col width="30%"/>
              <col width="15%"/>
              <col width="40%"/>
            </colgroup>
	           <tbody>
	           <tr>
	               <th>规培起始日期：</th>
	               <td>${doctorRecruit.recruitDate}</td>
	               <th>培训类别：</th>
	               <td>${doctorRecruit.catSpeName}</td>
	           </tr>
	           <tr>
	               <th>所在地区：</th>
	               <td colspan="3">${doctorRecruit.placeName}</td>
	           </tr>
	           <tr>
	               <th>培训基地：</th>
	               <td>${doctorRecruit.orgName}</td>
	               <th class="trainSpe">培训专业：</th>
	               <td>${doctorRecruit.speName}</td>
	           </tr>
	           <tr>
	               <th>培养年限：</th>
	               <td>${doctorRecruit.trainYear}</td>
	               <th>已培养年限：</th>
	               <td>${doctorRecruit.yetTrainYear}</td>
	           </tr>
	           <tr>
	               <th>医师状态：</th>
	               <td>${doctorRecruit.doctorStatusName}</td>
	               <th>医师走向：</th>
	               <td>${doctorRecruit.doctorStrikeName}</td>
	           </tr>
	           </tbody>
           </table>
		</div>
		<c:if test="${empty doctorRecruit.auditStatusId or jsResDoctorAuditStatusEnumNotSubmit.id eq doctorRecruit.auditStatusId}">
			<div align="center" style="margin-top: 20px; margin-bottom:20px;">
				<input type="button" class="btn_blue" onclick="editTrainInfo('${doctorRecruit.recruitFlow}');" value="编辑"/>
			</div>
		</c:if>