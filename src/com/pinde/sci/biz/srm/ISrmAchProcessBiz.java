package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchProcess;

public interface ISrmAchProcessBiz {
   /**
    * �����������
    * @param srmAchProcess
    * @return
    */
   public int saveAchProcess(SrmAchProcess srmAchProcess);
   /**
    * ��ѯ��������
    * @param srmAchProcess
    * @return
    */
   public List<SrmAchProcess> searchAchProcess(String achFlow,String statusId);
   
   /**
    * �ɹ���¼��ѯ
    * @param achProcess
    * @return
    */
   public List<SrmAchProcess> searchAchProcess(SrmAchProcess achProcess);
}
