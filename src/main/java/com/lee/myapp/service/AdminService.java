package com.lee.myapp.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.domain.CategoryVO;

public interface AdminService {
	/* Notice */
	public int write(BoardVO board) throws Exception;
	
	/* Banner */
	public String imageUpload(MultipartFile file) throws Exception;
	public int bannerRegist(BannerVO banner, MultipartFile file) throws Exception;
	public List<BannerVO> bannerList(String parameter) throws Exception;
	public int bannerStatusUpdate(BannerVO banner) throws Exception;
	public BannerVO bannerView(int bno) throws Exception;
	public int bannerUpdate(BannerVO banner, MultipartFile file) throws Exception;
	public int bannerDelete(int bno) throws Exception;

	//Category list
	public List<CategoryVO> categoryList() throws Exception;
	
	//Header banner
	public List<BannerVO> mainBannerList(String area) throws Exception;
}
