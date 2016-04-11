package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchProcess;

public interface ISrmAchProcessBiz {
   /**
    * 保存操作过程
    * @param srmAchProcess
    * @return
    */
   public int saveAchProcess(SrmAchProcess srmAchProcess);
   /**
    * 查询操作流程
    * @param srmAchProcess
    * @return
    */
   public List<SrmAchProcess> searchAchProcess(String achFlow,String statusId);
   
   /**
    * 成果记录查询
    * @param achProcess
    * @return
    */
   public List<SrmAchProcess> searchAchProcess(SrmAchProcess achProcess);
}
