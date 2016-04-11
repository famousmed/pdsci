package com.pinde.sci.dao.gcp;

import java.math.BigDecimal;

import com.pinde.sci.model.mo.GcpFund;

public interface GcpFundExtMapper {
	BigDecimal selectSum(GcpFund fund);
}
