package com.lee.myapp.persistence;

import java.util.List;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.QuestionsVO;

public interface CustomerDAO {
	public void questionRegist(QuestionsVO question) throws Exception;

	//Header banner
	public List<BannerVO> mainBannerList(String area) throws Exception;
}