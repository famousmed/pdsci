package com.pinde.sci.biz.gcp;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.gcp.GcpContractExt;
import com.pinde.sci.model.mo.GcpContract;
import com.pinde.sci.model.mo.GcpFund;
import com.pinde.sci.model.mo.PubProj;

/**
 * @Description 财务管理业务接口
 *
 */
public interface IGcpFinBiz {
	/**
	 * 新增或修改合同
	 * @param cont
	 * @param file 附件
	 * @return
	 * @throws IOException
	 */
	int editContract(GcpContract cont,MultipartFile file)throws IOException;
	/**
	 * 查询合同列表
	 * @param cont
	 * @param orderBy 排序方式 如：create_time desc
	 * @return
	 */
	List<GcpContract> searchContList(GcpContract cont,String orderBy);
	/**
	 * 查询单个合同
	 * @param contractFlow
	 * @return
	 */
	GcpContract searchContByFlow(String contractFlow);
	/**
	 * 删除合同附件
	 * @param contractFlow
	 * @return
	 */
	int delContractFile(String contractFlow);
	/**
	 * 删除合同
	 * @param contractFlow
	 * @return
	 */
	int delContract(String contractFlow);
	/**
	 * 统计项目的合同总例数
	 * @param projList
	 * @param contractNo
	 * @return
	 */
	Map<String,Map<String,Object>> countContract(List<PubProj> projList,String contractNo);
	/**
	 * 获取一条经费记录的详细信息
	 * @param fundFlow
	 * @return
	 */
    GcpFund readFund(String fundFlow);
    /**
     * 保存一条经费信息
     * @param gcpFund
     * @return
     */
    int saveFund(GcpFund gcpFund);
    /**
     * 统计项目总经费到账和支出
     * @param projList
     * @return
     */
    Map<String,Map<String,Object>> countFund(List<PubProj> projList);
    /**
     * 根据条件查询某项目下所有经费信息
     * @param gcpFund
     * @return
     */
    List<GcpFund> searchFundList(GcpFund gcpFund);
    /**
     * 查询该项目列表中每个项目的经费明细
     * @param projList
     * @return
     */
    Map<String,List<GcpFund>> fundMap(List<PubProj> projList);
	/**
	 * 删除该条经费明细
	 * @param fundFlow
	 * @return
	 */
    int delFund(String fundFlow);
    /**
     * 分类统计经费总和
     * @param fund
     * @return
     */
    BigDecimal searchSumFund(GcpFund fund);
    /**
     * 根据合同编号查询合同
     * @param cont
     * @return
     */
    GcpContract searchContByNo(String contractNo);
    
    /**
     * 根据相关条件查询合同信息
     * @param proj
     * @param gcpContract
     * @return
     */
    List<GcpContractExt> searchContractList(PubProj proj,GcpContract gcpContract);
    
    /**
     * 查询合同
     * @return
     */
	List<GcpContract> searchContractList();
	
	/**
	 * 根据projFlowList查询合同
	 * @param projFlowList
	 * @return
	 */
	List<GcpContract> searchContractList(List<String> projFlowList);
}
