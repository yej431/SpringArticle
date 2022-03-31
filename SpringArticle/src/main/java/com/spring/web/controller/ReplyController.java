package com.spring.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.spring.web.commons.paging.Criteria;
import com.spring.web.commons.paging.PageMaker;
import com.spring.web.domain.ReplyVO;
import com.spring.web.service.ReplyService;

@RestController
@RequestMapping("/reply")
public class ReplyController {

	@Autowired
	ReplyService replyService;
	
	@RequestMapping(value="", method=RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody ReplyVO replyVO){
		ResponseEntity<String> entity = null;
		try {
			replyService.create(replyVO);
			entity = new ResponseEntity<>("regSuccess", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/all/{article_no}", method=RequestMethod.GET)
	public ResponseEntity<List<ReplyVO>> list(@PathVariable("article_no") int article_no){
		ResponseEntity<List<ReplyVO>> entity = null;
		try {
			entity=new ResponseEntity<>(replyService.list(article_no), HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/{reply_no}/{reply_text}", method= {RequestMethod.PUT})
	public ResponseEntity<String> update(@PathVariable("reply_no") int reply_no, 
			@PathVariable("reply_text") String reply_text){
		ResponseEntity<String> entity = null;
		try {
			ReplyVO re = new ReplyVO();
			re.setReply_no(reply_no);
			re.setReply_text(reply_text);
			replyService.update(re);
			entity = new ResponseEntity<>("modSuccess", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/del/{reply_no}", method=RequestMethod.DELETE)
	public ResponseEntity<String> delete(@PathVariable("reply_no") int reply_no){
		ResponseEntity<String> entity = null;
		try {
			replyService.delete(reply_no);
			entity = new ResponseEntity<>("delSuccess", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/{article_no}/{page}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listPaging(@PathVariable("article_no") int article_no,
			@PathVariable("page") int page){
		ResponseEntity<Map<String, Object>> entity = null;
		
		try {
			Criteria criteria = new Criteria();
			criteria.setPage(page);
			
			List<ReplyVO> replies = replyService.getRepliesPaging(article_no, criteria);
			int repliesCount = replyService.countReplies(article_no);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCriteria(criteria);
			pageMaker.setTotalCount(repliesCount);
			
			Map<String, Object> map = new HashMap<>();
			map.put("replies", replies);
			map.put("pageMaker", pageMaker);
			
			entity = new ResponseEntity<>(map, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.OK);
		}
		return entity;
	}
}
