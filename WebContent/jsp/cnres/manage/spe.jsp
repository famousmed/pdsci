<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
      <div class="main_hd">
        <h2>专业维护</h2>
        <div class="title_tab" id="toptab">
          <ul>
            <li class="tab_select"><a>培训专业</a></li>
          </ul>
        </div>
      </div>
      <div class="main_bd" id="div_table_0" >
        <div class="div_table">
          <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <th  style="text-align: left;padding-left: 40px;">专业代码</th>
              <th  style="text-align: left;padding-left: 40px;">专业基地名称</th>
            </tr>
            <c:forEach items="${ dictTypeEnumDoctorTrainingSpeList}" var="dict">
            <tr>
              <td style="text-align: left;padding-left: 40px;">${dict.dictId}</td>
              <td style="text-align: left;padding-left: 40px;">${dict.dictName}</td>
            </tr>
            </c:forEach>
          </table>
      </div>
      </div>
      
