package com.spring.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.web.commons.paging.Criteria;
import com.spring.web.domain.ReplyVO;
import com.spring.web.persistence.ArticleDAO;
import com.spring.web.persistence.ReplyDAO;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Autowired
	ReplyDAO replyDAO;

    @Autowired
    ArticleDAO articleDAO;

    @Override
    public List<ReplyVO> list(Integer article_no) throws Exception {
        return replyDAO.list(article_no);
    }

    @Override
    public void create(ReplyVO replyVO) throws Exception {
        replyDAO.create(replyVO);
    }

    @Override
    public void update(ReplyVO replyVO) throws Exception {
        replyDAO.update(replyVO);
    }

    @Override
    public void delete(Integer reply_no) throws Exception {
        replyDAO.delete(reply_no);
    }

    @Override
    public List<ReplyVO> getRepliesPaging(Integer article_no, Criteria criteria) throws Exception {
        return replyDAO.listPaging(article_no, criteria);
    }

    @Override
    public int countReplies(Integer article_no) throws Exception {
        return replyDAO.countReplies(article_no);
    }
}
