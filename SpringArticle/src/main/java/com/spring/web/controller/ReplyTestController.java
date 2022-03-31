package com.spring.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.web.domain.ReplyVO;

@Controller
@RequestMapping("/reply")
public class ReplyTestController {

	@RequestMapping("/test")
	public String replyAjaxTest() {
		return "/tutorial/reply_test";
	}
	
	@RequestMapping(value="/modView", method=RequestMethod.GET)
	public String modView(int reply_no, String reply_text, String reply_writer, Model m) {
		ReplyVO vo = new ReplyVO();
		vo.setReply_no(reply_no);
		vo.setReply_text(reply_text);
		vo.setReply_writer(reply_writer);
		System.out.println(reply_no);
		
		m.addAttribute("reply", vo);
		return "/article/modView";
	}
}
