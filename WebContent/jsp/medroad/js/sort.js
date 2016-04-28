(function () {  
        //创建闭包以及下面的空间命名，避免项目开发中与其它内容有冲突  
        if (!window.kw) {  
            window.kw = {};  
        };  
        kw = {  
            convert : function (sValue, sDataType) { //类型转，根据不同类型数据排序，比如，整型，日期，浮点，字符串，接受两个参数，一个是值，一个是排序的数据类型  
                switch (sDataType) {  
                case "int":  
                    return parseInt(sValue);  
                case "float":  
                    return parseFloat(sValue);  
                case "date":  
                    return new Date(Date.parse(sValue));  
                default:  
                    return sValue.toString();  
                }  
            },  
            geterateCompareTRs : function (iCol, sDataType) { //比较函数，用于sort排序用  
                return function compareTRs(oTR1, oTR2) {  
                    var vValue1,  
                    vValue2;  
                    if (oTR1.cells[iCol].getAttribute("value")) { //用于高级排序，比如图片，添加一个额外的属性来排序  
                        vValue1 = kw.convert(oTR1.cells[iCol].getAttribute("value"), sDataType);  
                        vValue2 = kw.convert(oTR2.cells[iCol].getAttribute("value"), sDataType);  
                    } else {  
                        vValue1 = kw.convert(oTR1.cells[iCol].firstChild.nodeValue, sDataType);  
                        vValue2 = kw.convert(oTR2.cells[iCol].firstChild.nodeValue, sDataType);  
                    }  
                    if (vValue1 < vValue2) {  
                        return -1;  
                    } else if (vValue1 > vValue2) {  
                        return 1;  
                    } else {  
                        return 0;  
                    }  
                }  
            },  
            tabSort : function (sTableID, iCol, sDataType) { //排序函数，sTableID为目标,iCol哪列排序，为必需，sDataType可选  
                var oTable = document.getElementById(sTableID);  
                var oTBody = oTable.tBodies[0];  
                var colDataRows = oTBody.rows;  
                var aTRs = [];  
                for (var i = 0; i < colDataRows.length; i++) {  
                    aTRs[i] = colDataRows[i];  
                };  
                if (oTable.sortCol == iCol) { //如果已经排序，则倒序  
                    aTRs.reverse();  
                } else {  
                    aTRs.sort(this.geterateCompareTRs(iCol, sDataType));  
                }  
                var oFragment = document.createDocumentFragment();  
                for (var j = 0; j < aTRs.length; j++) {  
                    oFragment.appendChild(aTRs[j]);  
                };  
                oTBody.appendChild(oFragment);  
                oTable.sortCol = iCol; //设置一个状态  
            }  
        };  
    })();