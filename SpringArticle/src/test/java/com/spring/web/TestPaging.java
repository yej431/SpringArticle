package com.spring.web;

import java.util.List;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.spring.web.commons.paging.Criteria;
import com.spring.web.controller.ArticleController;
import com.spring.web.domain.ReplyVO;
import com.spring.web.persistence.ReplyDAO;

public class TestPaging {
	private static final Logger logger = LoggerFactory.getLogger(ArticleController.class);

	@Autowired
	ReplyDAO replyDAO;
	@Test
	public void test() {
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
				.path("/article/read")
				.queryParam("article_no", 12)
				.queryParam("perPageNum", 20)
				.build();
		
		logger.info("/article/read?article_no=12&perPageNum=20");
		logger.info(uriComponents.toString());
	}
	
	@Test
	public void test2() throws Exception{
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
				.path("/{module}/{page}")
				.queryParam("article_no",12)
				.queryParam("perPageNum", 20)
				.build()
				.expand("article", "read")
				.encode();
		
		logger.info("/article/read?article_no=12&perPageNum=20");
		logger.info(uriComponents.toString());
	}

	
}
