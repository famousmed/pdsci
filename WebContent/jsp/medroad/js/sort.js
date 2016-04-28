(function () {  
        //�����հ��Լ�����Ŀռ�������������Ŀ�����������������г�ͻ  
        if (!window.kw) {  
            window.kw = {};  
        };  
        kw = {  
            convert : function (sValue, sDataType) { //����ת�����ݲ�ͬ�����������򣬱��磬���ͣ����ڣ����㣬�ַ�������������������һ����ֵ��һ�����������������  
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
            geterateCompareTRs : function (iCol, sDataType) { //�ȽϺ���������sort������  
                return function compareTRs(oTR1, oTR2) {  
                    var vValue1,  
                    vValue2;  
                    if (oTR1.cells[iCol].getAttribute("value")) { //���ڸ߼����򣬱���ͼƬ�����һ�����������������  
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
            tabSort : function (sTableID, iCol, sDataType) { //��������sTableIDΪĿ��,iCol��������Ϊ���裬sDataType��ѡ  
                var oTable = document.getElementById(sTableID);  
                var oTBody = oTable.tBodies[0];  
                var colDataRows = oTBody.rows;  
                var aTRs = [];  
                for (var i = 0; i < colDataRows.length; i++) {  
                    aTRs[i] = colDataRows[i];  
                };  
                if (oTable.sortCol == iCol) { //����Ѿ���������  
                    aTRs.reverse();  
                } else {  
                    aTRs.sort(this.geterateCompareTRs(iCol, sDataType));  
                }  
                var oFragment = document.createDocumentFragment();  
                for (var j = 0; j < aTRs.length; j++) {  
                    oFragment.appendChild(aTRs[j]);  
                };  
                oTBody.appendChild(oFragment);  
                oTable.sortCol = iCol; //����һ��״̬  
            }  
        };  
    })();