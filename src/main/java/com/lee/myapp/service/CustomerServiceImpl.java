package com.lee.myapp.service;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.lee.myapp.domain.BannerVO;
import com.lee.myapp.domain.BoardVO;
import com.lee.myapp.domain.CategoryVO;
import com.lee.myapp.domain.CommentCriteria;
import com.lee.myapp.domain.FaqVO;
import com.lee.myapp.domain.QuestionsVO;
import com.lee.myapp.persistence.CustomerDAO;
import com.lee.myapp.utils.UploadFileUtils;

@Service
public class CustomerServiceImpl implements CustomerService{
	
	@Inject
	CustomerDAO customerDAO;

	@Resource(name="uploadPath")
	private String uploadPath;
	
	@Override
	public String imageUpload(MultipartFile[] images) throws Exception{
		// TODO Auto-generated method stub
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		
		String url = "";

		for(int i=0;i<images.length;i++) {
			if(images[i].getOriginalFilename().equals("")) continue;
			
			if(i == 0) {
				url = "/" + "imgUpload" + ymdPath + "/" + UploadFileUtils.fileUpload(imgUploadPath, images[i].getOriginalFilename(), images[i].getBytes(), ymdPath);
				continue;
			}
			url = url + ";" + "/" + "imgUpload" + ymdPath + "/" +UploadFileUtils.fileUpload(imgUploadPath, images[i].getOriginalFilename(), images[i].getBytes(), ymdPath);
		}
		
		if(url.equals("")) url = "none";
		
		return url;
	}
	
	//Questions query
	@Override
	public void questionRegist(QuestionsVO question, MultipartFile[] images) throws Exception {
		// TODO Auto-generated method stub
		customerDAO.questionRegist(question.setImagesurl(imageUpload(images)));
	}

	//Notice list query
	@Override
	public int listCount(String category) throws Exception {
		// TODO Auto-generated method stub
		return customerDAO.listCount(category);
	}

	@Override
	public List<BoardVO> listPaging(CommentCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return customerDAO.listPaging(cri);
	}

	//Notice write query
	@Override
	public int write(BoardVO board) throws Exception {
		// TODO Auto-generated method stub
		return customerDAO.write(board);
	}

	//Notice view query
	@Override
	public BoardVO view(int bno) throws Exception {
		// TODO Auto-generated method stub
		BoardVO board = customerDAO.view(bno);
		
		//Line change processing
		if(board.getContent().contains("\r\n")) {
			board.setContent("<p>"+board.getContent().replace("\r\n","</p><p>"));
		}else {
			board.setContent("<p>"+board.getContent()+"</p>");
		}
		
		return board;
	}

	@Override
	public void viewCount(int bno) throws Exception {
		// TODO Auto-generated method stub
		customerDAO.viewCount(bno);
	}

	//Notice delete query
	@Override
	public void delete(int bno) throws Exception {
		// TODO Auto-generated method stub
		customerDAO.delete(bno);
	}

	//Notice modify query
	@Override
	public void modify(BoardVO board) throws Exception {
		// TODO Auto-generated method stub
		customerDAO.modify(board);
	}

	@Override
	public List<FaqVO> listFAQ(String order) throws Exception {
		// TODO Auto-generated method stub
		return customerDAO.listFAQ(order);
	}

	//Category list
	@Override
	public List<CategoryVO> categoryList() throws Exception {
		// TODO Auto-generated method stub
		return customerDAO.categoryList();
	}
	
	//Header banner
	@Override
	public List<BannerVO> mainBannerList(String area) throws Exception {
		// TODO Auto-generated method stub
		return customerDAO.mainBannerList(area);
	}
}