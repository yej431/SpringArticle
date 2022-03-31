package com.spring.web.service;

import java.util.List;

import com.spring.web.commons.paging.Criteria;
import com.spring.web.domain.ArticleVO;

public interface ArticleService {

	void create(ArticleVO articleVO) throws Exception;

    ArticleVO read(Integer articleNo) throws Exception;

    void update(ArticleVO articleVO) throws Exception;

    void delete(Integer articleNo) throws Exception;

    List<ArticleVO> listAll() throws Exception;

	List<ArticleVO> listCriteria(Criteria criteria) throws Exception;
	int countArticles(Criteria criteria) throws Exception;
}
