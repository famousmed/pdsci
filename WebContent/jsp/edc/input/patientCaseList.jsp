  <script src="<s:url value='/js/jquery.min.js'/>"></script>
 <script src="<s:url value='/js/jquery.blueimp-gallery.min.js'/>"></script>
<link rel="stylesheet" href="<s:url value='/css/blueimp-gallery.min.css'/>?" />
 <style>

    .lightBoxGallery {
        text-align: center;
    }

    .lightBoxGallery a {
        margin: 5px;
        display: inline-block;
        float: left;
        text-decoration: none;
    }
.alert {
    margin-bottom: 0;
    border-radius: 0;
    border: 1px solid #e4e5e7;
    border-bottom: none;
}
.alert-success {
    color: #3c763d;
    background-color: #dff0d8;
    border-color: #d6e9c6;
}
.alert {
    padding: 15px;
    margin-bottom: 20px;
    border: 1px solid transparent;
    border-radius: 4px;
}

.docs-pictures {
    margin: 0;
    padding: 0;
    list-style: none;
}
.docs-pictures li {
    margin: 0 -1px -1px 0;
    border: 1px solid transparent;
    overflow: hidden;
}
.docs-pictures li img {
 
}
.page-header {
    padding-bottom: 9px;
    margin: 10px 0 10px;
    border-bottom: 1px solid #eee;
}
.clearfix:after {
    content: ".";
    display: block;
    height: 0;
    clear: both;
    visibility: hidden;
}
</style>
 <div class="alert alert-success">
                <i class="fa fa-bolt"></i> ${currVisit.visitName }
            </div>
  <div class="lightBoxGallery" style="overflow: auto;height: 100%">
  	 <div class="docs-pictures clearfix">
				<c:forEach items="${dataList }" var="data" varStatus="status">
						<div style="width: 50%;float: left;">
                            <a href="${data.imageUrl}" title="${data.note }&#10;&#13;${data.time}" data-gallery=""><img src="${data.thumbUrl }">
                            <span style="vertical-align: top;display: inline-block;text-align: left;">${data.time }<br/>
					            		备注：<font id="${data.imageFlow}_label">${data.note }</font>
					            </span>
                            </a>
                        </div>
					</c:forEach>
					<c:if test="${empty dataList }">无上传病例!</c:if>
		</div>
    </div>
<!-- The Gallery as lightbox dialog, should be a child element of the document body -->
<div id="blueimp-gallery" class="blueimp-gallery">
    <div class="slides"></div>
    <h3 class="title"></h3>
    <a class="prev">‹</a>
    <a class="next">›</a>
    <a class="close">×</a>
    <a class="play-pause"></a>
    <ol class="indicator"></ol>
</div>
    