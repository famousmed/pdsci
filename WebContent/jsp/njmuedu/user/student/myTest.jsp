<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
	<jsp:param name="findCourse" value="true"/>
</jsp:include>
<div class="right fr">
	 	<div class="wrap">
     	<div class="courseBg" >
        	<div class="title clearfix">
              	<h3 class="fl" style="border:none;"><img src="<s:url value='/jsp/njmuedu/css/images/test.png'/>" />我的测验</h3>
              </div>
              <div class="courseList-content allCourse">
                	<div class="mytest-content" style="display:block;" > 
<!--                	        <div class="nomessage" style="text-align: center;"> 
								<img src="${ctxPath }/jsp/njmuedu/css/images/tanhao.png">           
								<p>暂未获得学分！</p>
							</div>-->
                    	<div class="course_test">
                          <dl class="mytest">
                            <dt>哲学-辩证唯物主义</dt>
                            <dd>开始时间：2014-12-22 15:30:30</dd>
                            <dd>完成时间: 2014-12-22 17:30:30</dd>
                            <dd>测验状态：<font color="#000">已完成</font></dd>
                          </dl>
                          <dl class="fr test_go">
                          <input class="test_btn" name="" type="button" value="查看详细"/>
                          </dl>
                        </div>
                        <div class="course_test">
                          <dl class="mytest">
                            <dt>语文-古诗词鉴赏</dt>
                            <dd>开始时间：2014-12-22 15:30:30</dd>
                            <dd>完成时间: 2014-12-22 17:30:30</dd>
                            <dd>测验状态：<font color="#000">已完成</font></dd>
                          </dl>
                          <dl class="fr test_go">
                          <input class="test_btn" name="" type="button" value="查看详细"/>
                          </dl>
                        </div>
                        <div class="course_test">
                          <dl class="mytest">
                            <dt>物理-黑洞的形成</dt>
                            <dd>开始时间：2014-12-22 15:30:30</dd>
                            <dd>完成时间: 2014-12-22 17:30:30</dd>
                            <dd>测验状态：<font color="#000">已完成</font></dd>
                          </dl>
                          <dl class="fr test_go">
                          <input class="test_btn" name="" type="button" value="查看详细"/>
                          </dl>
                        </div>
                   </div>
              </div>
         </div>
      </div>
</div>      
