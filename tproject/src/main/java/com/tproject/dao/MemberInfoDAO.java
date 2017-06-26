package com.tproject.dao;

import java.util.List;

import com.tproject.dto.MemberInfoDTO;

public interface MemberInfoDAO {
	public List<MemberInfoDTO> getMemberInfo(String username);
}
