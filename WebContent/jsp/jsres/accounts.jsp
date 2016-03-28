<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>安全中心</title>
<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script>
function modPasswd(userFlow){
	var url = "<s:url value='/jsres/manage/modPasswd'/>?userFlow="+userFlow;
	jboxOpen(url , "修改密码" , 500 , 300 , true);
}
</script>
</head>

        <div class="main_hd">
          <h2>安全中心</h2>
        </div>
        <div class="main_bd">
          <ul class="safe_list">
            <li class="safe_item">
              <dl>
                <dt class="title">邮箱</dt>
                <dd>
                 <span class="safe_xx">你的帐号已绑定邮箱：${sessionScope.currUser.userEmail }</span>
                 <span class="safe_xq"><a></a></span>
               
                </dd>
              </dl>
            </li>
            <li class="safe_item">
              <dl>
                <dt class="title">手机号</dt>
                <dd>
                <span class="safe_xx">您当前使用的手机号：${sessionScope.currUser.userPhone }</span>
                <span class="safe_xq"><a></a></span>
                </dd>
              </dl>
            </li>
            <li class="safe_item">
              <dl>
                <dt class="title">操作日志</dt>
                <dd>
                <span class="safe_xx">最近操作：${pdfn:transDateTime(log.logTime) } &nbsp; ${log.operName }</span>
                </dd>
              </dl>
            </li>
             <li class="safe_item">
              <dl>
                <dt class="title">修改密码</dt>
                <dd>
                <span class="safe_xx"><a href="javascript:modPasswd('${currUser.userFlow}');">修改</a></span>
                </dd>
              </dl>
            </li>
          </ul>
        </div>
