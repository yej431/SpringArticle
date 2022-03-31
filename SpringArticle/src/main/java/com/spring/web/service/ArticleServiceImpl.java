package com.spring.web.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.web.commons.paging.Criteria;
import com.spring.web.domain.ArticleVO;
import com.spring.web.persistence.ArticleDAO;

@Service
public class ArticleServiceImpl implements ArticleService {
	
	@Autowired
	ArticleDAO articleDAO;
	
	@Inject
	public ArticleServiceImpl(ArticleDAO articleDAO) {
		this.articleDAO = articleDAO;
	}
	
	@Override
    public void create(ArticleVO articleVO) throws Exception {
        articleDAO.create(articleVO);
    }

    @Override
    public ArticleVO read(Integer articleNo) throws Exception {
        return articleDAO.read(articleNo);
    }

    @Override
    public void update(ArticleVO articleVO) throws Exception {
        articleDAO.update(articleVO);
    }

    @Override
    public void delete(Integer articleNo) throws Exception {
        articleDAO.delete(articleNo);
    }

    @Override
    public List<ArticleVO> listAll() throws Exception {
        return articleDAO.listAll();
    }

	@Override
	public List<ArticleVO> listCriteria(Criteria criteria) throws Exception {
	    return articleDAO.listCriteria(criteria);
	}
	
	@Override
	public int countArticles(Criteria criteria) throws Exception {
	    return articleDAO.countArticles(criteria);
	}
}
