
//显示loading
function showLoading(){
	$.mobile.loadingMessageTextVisible = true;
	$.mobile.showPageLoadingMsg("a", "加载中..." );
}
//隐藏loading
function hideLoading(){
	$.mobile.hidePageLoadingMsg();
}  