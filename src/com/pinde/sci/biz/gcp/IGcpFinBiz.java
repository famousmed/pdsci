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
 * @Description �������ҵ��ӿ�
 *
 */
public interface IGcpFinBiz {
	/**
	 * �������޸ĺ�ͬ
	 * @param cont
	 * @param file ����
	 * @return
	 * @throws IOException
	 */
	int editContract(GcpContract cont,MultipartFile file)throws IOException;
	/**
	 * ��ѯ��ͬ�б�
	 * @param cont
	 * @param orderBy ����ʽ �磺create_time desc
	 * @return
	 */
	List<GcpContract> searchContList(GcpContract cont,String orderBy);
	/**
	 * ��ѯ������ͬ
	 * @param contractFlow
	 * @return
	 */
	GcpContract searchContByFlow(String contractFlow);
	/**
	 * ɾ����ͬ����
	 * @param contractFlow
	 * @return
	 */
	int delContractFile(String contractFlow);
	/**
	 * ɾ����ͬ
	 * @param contractFlow
	 * @return
	 */
	int delContract(String contractFlow);
	/**
	 * ͳ����Ŀ�ĺ�ͬ������
	 * @param projList
	 * @param contractNo
	 * @return
	 */
	Map<String,Map<String,Object>> countContract(List<PubProj> projList,String contractNo);
	/**
	 * ��ȡһ�����Ѽ�¼����ϸ��Ϣ
	 * @param fundFlow
	 * @return
	 */
    GcpFund readFund(String fundFlow);
    /**
     * ����һ��������Ϣ
     * @param gcpFund
     * @return
     */
    int saveFund(GcpFund gcpFund);
    /**
     * ͳ����Ŀ�ܾ��ѵ��˺�֧��
     * @param projList
     * @return
     */
    Map<String,Map<String,Object>> countFund(List<PubProj> projList);
    /**
     * ����������ѯĳ��Ŀ�����о�����Ϣ
     * @param gcpFund
     * @return
     */
    List<GcpFund> searchFundList(GcpFund gcpFund);
    /**
     * ��ѯ����Ŀ�б���ÿ����Ŀ�ľ�����ϸ
     * @param projList
     * @return
     */
    Map<String,List<GcpFund>> fundMap(List<PubProj> projList);
	/**
	 * ɾ������������ϸ
	 * @param fundFlow
	 * @return
	 */
    int delFund(String fundFlow);
    /**
     * ����ͳ�ƾ����ܺ�
     * @param fund
     * @return
     */
    BigDecimal searchSumFund(GcpFund fund);
    /**
     * ���ݺ�ͬ��Ų�ѯ��ͬ
     * @param cont
     * @return
     */
    GcpContract searchContByNo(String contractNo);
    
    /**
     * �������������ѯ��ͬ��Ϣ
     * @param proj
     * @param gcpContract
     * @return
     */
    List<GcpContractExt> searchContractList(PubProj proj,GcpContract gcpContract);
    
    /**
     * ��ѯ��ͬ
     * @return
     */
	List<GcpContract> searchContractList();
	
	/**
	 * ����projFlowList��ѯ��ͬ
	 * @param projFlowList
	 * @return
	 */
	List<GcpContract> searchContractList(List<String> projFlowList);
}
