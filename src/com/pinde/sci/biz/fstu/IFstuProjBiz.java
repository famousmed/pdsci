package com.pinde.sci.biz.fstu;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.mo.FstuProj;

public interface IFstuProjBiz {
	public List<FstuProj> search(FstuProj proj);
	public FstuProj findByFlow(String projFlow);
	int save(FstuProj proj);
	int saveProjAndFile(FstuProj proj, MultipartFile file) throws IOException;
}
