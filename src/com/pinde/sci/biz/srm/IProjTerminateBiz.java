package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;

public interface IProjTerminateBiz {
		/**
		 * ��ѯ�е���λ��Ŀ�б�
		 * 
		 * @param proj
		 * @param currUser
		 */
		public List<PubProj> searchLocalProj(PubProj proj, String recTypeId);

		/**
		 * ��ѯ���ܵ�λ��Ŀ�б�
		 * 
		 * @param proj
		 * @param currUser
		 */
		public List<PubProj> searchChargeProj(PubProj proj, String recTypeId);

		/**
		 * ��ѯ������Ŀ�б�
		 * 
		 * @param proj
		 * @param currUser
		 */
		public List<PubProj> searchGlobalProj(PubProj proj, String recTypeId);
}
