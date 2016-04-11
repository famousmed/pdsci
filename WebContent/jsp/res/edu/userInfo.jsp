         <div class="sc_r_tc">
            <i class="icon_up"></i>
            <div class="sc_r_border">
               <div class="sc_photo">
                 <span class="sc_p_name">
                   <%-- <h1><a href="javascript:personalCenter();">${sessionScope.currUser.userName}</a><i><img src="<s:url value='/jsp/res/images/edit.png' />"></i></h1> --%>
                   <h2>${sessionScope.currUser.deptName}</h2>
                 </span>
               </div>
               <div class="sc_score">
                  <dl>
                    <dt>${sumUserCreditMap['achieveCredit'] }</dt>
                    <dd>获得学分</dd>
                  </dl>
                  <dl class="sc_r_score">
                    <dt>${sumUserCreditMap['notAchieveCredit'] }</dt>
                    <dd>未获得学分</dd>
                  </dl>
               </div>
               <dl class="new_study">
                 <c:if test="${empty studentCourseExtList }">
                 <dt>最新学习：无</dt>
                 </c:if>
                 <c:if test="${not empty studentCourseExtList }">
                 <dt>最新学习：</dt>
                 <dd>
			     <a href="<s:url value='/resedu/course/courseMain?courseFlow=${studentCourseExtList.get(0).course.courseFlow }'/>&scope=student" target="_blank">${studentCourseExtList.get(0).course.courseName }</a>
                 </dd>
                 </c:if>
               </dl>
            </div>
            
            <div class="sc_r_border sc_type">
               <dl class="sc_course">
                 <dt>必修课程：${countUserCourseMap[eduCourseTypeEnumRequired.id] }</dt>
                 <dd class="wxw">未学完：${requireNotFinish }</dd>
                 <dd class="yxw">已学完：${countUserCourseFinishMap[eduCourseTypeEnumRequired.id] }</dd>
               </dl>
            </div>
            
            <div class="sc_r_border sc_type">
               <dl class="sc_course">
                 <dt>选修课程：${countUserCourseMap[eduCourseTypeEnumOptional.id] }</dt>
                 <dd class="wxw">未学完：${optionalNotFinish }</dd>
                 <dd class="yxw">已学完：${countUserCourseFinishMap[eduCourseTypeEnumOptional.id] }</dd>
               </dl>
            </div>
        </div>