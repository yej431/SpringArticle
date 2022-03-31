package com.spring.web.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.web.commons.paging.Criteria;
import com.spring.web.commons.paging.PageMaker;
import com.spring.web.domain.ArticleVO;
import com.spring.web.service.ArticleService;

@Controller
@RequestMapping("/article")
public class ArticleController {
	
	private static final Logger logger = LoggerFactory.getLogger(ArticleController.class);

	@Autowired
	ArticleService articleService;
	
	@Inject
    public ArticleController(ArticleService articleService) {
        this.articleService = articleService;
    }

	@RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(Model model, Criteria criteria) throws Exception {

        logger.info("paging list() called ...");

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(articleService.countArticles(criteria));

        model.addAttribute("articles", articleService.listCriteria(criteria));
        model.addAttribute("pageMaker", pageMaker);

        return "article/list";
    }

    @RequestMapping(value = "/write", method = RequestMethod.GET)
    public String writeGET() {

        logger.info("paging writeGET() called...");

        return "article/write";
    }

    @RequestMapping(value = "/write", method = RequestMethod.POST)
    public String writePOST(ArticleVO articleVO,
                            RedirectAttributes redirectAttributes) throws Exception {

        logger.info("paging writePOST() called...");

        articleService.create(articleVO);
        redirectAttributes.addFlashAttribute("msg", "regSuccess");

        return "redirect:/article/list";
    }

    @RequestMapping(value = "/read", method = RequestMethod.GET)
    public String read(@RequestParam("article_no") int article_no,
                       @ModelAttribute("criteria") Criteria criteria,
                       Model model) throws Exception {

        logger.info("paging read() called ...");
        model.addAttribute("article", articleService.read(article_no));

        return "article/read";
    }

    @RequestMapping(value = "/modify", method = RequestMethod.GET)
    public String modifyGET(ArticleVO articleVO,@ModelAttribute("criteria") Criteria criteria,
    		Model model) throws Exception {
        logger.info("paging modifyGet() called ...");
        model.addAttribute("article", articleService.read(articleVO.getArticle_no()));

        return "article/modify";
    }

    @RequestMapping(value = "/modify", method = RequestMethod.POST)
    public String modifyPOST(ArticleVO articleVO, Criteria criteria,
        	RedirectAttributes redirectAttributes) throws Exception {

        logger.info("paging modifyPOST() called ...");
        articleService.update(articleVO);
        redirectAttributes.addAttribute("page", criteria.getPage());
        redirectAttributes.addAttribute("perPageNum", criteria.getPerPageNum());
        redirectAttributes.addFlashAttribute("msg", "modSuccess");

        return "redirect:/article/list";
    }

    @RequestMapping(value = "/remove", method = RequestMethod.POST)
    public String remove(ArticleVO articleVO, Criteria criteria,
        		RedirectAttributes redirectAttributes) throws Exception {

    	logger.info("normal remove() ...");
        articleService.delete(articleVO.getArticle_no());
        redirectAttributes.addFlashAttribute("msg", "delSuccess");

        return "redirect:/article/list";
    }
}
