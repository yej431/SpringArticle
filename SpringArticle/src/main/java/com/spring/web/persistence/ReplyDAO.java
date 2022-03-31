package com.spring.web.persistence;

import java.util.List;

import com.spring.web.commons.paging.Criteria;
import com.spring.web.domain.ReplyVO;

public interface ReplyDAO {

	List<ReplyVO> list(Integer article_no) throws Exception;

    void create(ReplyVO reply_vo) throws Exception;

    void update(ReplyVO reply_vo) throws Exception;

    void delete(Integer reply_no) throws Exception;

    List<ReplyVO> listPaging(Integer article_no, Criteria criteria) throws Exception;

    int countReplies(Integer article_no) throws Exception;

    int getArticleNo(Integer reply_no) throws Exception;
}
