package com.spring.web.domain;

import java.util.Date;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class ArticleVO {

	private int article_no;
	private String title;
	private String content;
	private String writer;
	private Date regDate;
	private int viewCnt;
}
