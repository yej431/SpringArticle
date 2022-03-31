package com.spring.web;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.web.domain.ReplyVO;
import com.spring.web.persistence.ReplyDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class ReplyDAOTest {

    private static final Logger logger = LoggerFactory.getLogger(ReplyDAOTest.class);

    @Inject
    private ReplyDAO replyDAO;

    @Test
    public void testReplyCreate() throws Exception {

        for (int i = 1; i <= 100; i++) {
            ReplyVO replyVO = new ReplyVO();
            replyVO.setArticle_no(1);
            replyVO.setReply_text(i+"번째 댓글입니다..");
            replyDAO.create(replyVO);
        }

    }

    @Test
    public void testReplyList() throws Exception {

        logger.info(replyDAO.list(1000).toString());

    }

    @Test
    public void testReplyUpdate() throws Exception {

        ReplyVO replyVO = new ReplyVO();
        replyVO.setArticle_no(2);
        replyVO.setReply_text(2+"번째 댓글 수정...");
        replyDAO.update(replyVO);

    }

    @Test
    public void testReplyDelete() throws Exception {

        replyDAO.delete(3);

    }
}