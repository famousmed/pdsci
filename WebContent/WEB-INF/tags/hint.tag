<%@ tag body-content="scriptless" pageEncoding="UTF-8"%>
<%@ attribute name="fieldId" required="false" %>
<%@ attribute name="width" required="true" %>

<div id="${fieldId}_hint" class="hint" style="width:${width}px;"><span class="hint-pointer">&nbsp;</span><jsp:doBody/></div>
<script type="text/javascript">
    $(function() {
        var hint = $("#${fieldId}_hint");

        var showHint = function(elem) {
            var pos = elem.position();
            var posX = pos.left + elem.width() + 50;
            var posY = pos.top;
            hint.css({left: posX + 80, top: posY}).animate({left: posX, opacity: "show"}, 500);
        };
        if (${not empty fieldId}) {
            $('#${fieldId}').focus(function() {
                showHint($(this));
            }).blur(function() {
                hint.hide();
            });
        }
    });
</script>
