package com.tproject.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import com.tproject.dto.MemberInfoDTO;

@Repository("memberinfodao")
public class MemberInfoDAOImpl implements MemberInfoDAO{
	@Autowired
	private MongoTemplate mongoTemplate;
	
	private String collectionname = "memberdb";

	@Override
	public List<MemberInfoDTO> getMemberInfo(String username) {
		List<MemberInfoDTO> userinfo = new ArrayList<MemberInfoDTO>();
		
		System.out.println("security dao call");
		
		//몽고디비에서 사용자 이름을 조건으로 해서 정보를 검색//
		Query query = new Query(new Criteria().andOperator(
				Criteria.where("username").is(username)
		));
		
		return mongoTemplate.find(query, MemberInfoDTO.class, collectionname);
	}

}
