package com.lee.myapp.service;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.persistence.AdminDAO;
import com.lee.myapp.utils.UploadFileUtils;

@Service
public class AdminServiceImpl implements AdminService{
	
	@Inject
	AdminDAO adminDAO;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@Override
	public int write(BoardVO board) throws Exception {
		// TODO Auto-generated method stub
		return adminDAO.write(board);
	}

	/*
	 * 이미지 업로드 및 이미지 경로 return
	 */
	@Override
	public String imageUpload(MultipartFile file) throws Exception{
		if(file != null) {
			String imgUploadPath = uploadPath + "/" + "imgUpload";
			String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
			
			return "/" + "imgUpload" + ymdPath + "/" + UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		}else {
			return "none";
		}
	}
	
	/*
	 * 이미지 업로드 후 DB에 배너 등록
	 */
	@Override
	public int bannerRegist(BannerVO banner, MultipartFile file) throws Exception {
		// TODO Auto-generated method stub		
		return adminDAO.bannerRegist(banner.setBannerurl(imageUpload(file)));
	}

	@Override
	public List<BannerVO> bannerList(String parameter) throws Exception {
		// TODO Auto-generated method stub
		return adminDAO.bannerList(parameter);
	}

	@Override
	public int bannerStatusUpdate(BannerVO banner) throws Exception {
		// TODO Auto-generated method stub
		return adminDAO.bannerStatusUpdate(banner);
	}

	@Override
	public BannerVO bannerView(int bno) throws Exception {
		// TODO Auto-generated method stub
		return adminDAO.bannerView(bno);
	}

	@Override
	public int bannerUpdate(BannerVO banner, MultipartFile file) throws Exception {
		// TODO Auto-generated method stub
		return adminDAO.bannerUpdate(banner.setBannerurl(imageUpload(file)));
	}

	@Override
	public int bannerDelete(int bno) throws Exception {
		// TODO Auto-generated method stub
		return adminDAO.bannerDelete(bno);
	}

	//Category list
	@Override
	public List<CategoryVO> categoryList() throws Exception {
		// TODO Auto-generated method stub
		return adminDAO.categoryList();
	}

	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return adminDAO.mainBannerList(area);
	}
}