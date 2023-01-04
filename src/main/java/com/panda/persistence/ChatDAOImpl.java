package com.panda.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.panda.domain.ChatVO;

@Repository
public class ChatDAOImpl implements ChatDAO{
	
	
	private static final Logger logger = LoggerFactory.getLogger(ChatDAOImpl.class);
	
	@Inject
	SqlSession sqlSession;
	
	private final String mapper = "com.panda.mapper.ChatMapper";
	
	public List getRooms(String id) throws Exception{
//		logger.info(sqlSession.selectList(mapper+".getRooms",id).toString());
		return sqlSession.selectList(mapper+".getRooms",id);
	}
	
	public String getRoom(ChatVO vo) throws Exception{
//		logger.info(sqlSession.selectOne(mapper+".getRoom",vo));
		return sqlSession.selectOne(mapper+".getRoom",vo);
	}
	
	public String getRoom(Map<String, Object> hm) throws Exception{
		
		return sqlSession.selectOne(mapper+".getRoom",hm);
	}
	
	public void recordMsg(Map<String, Object> hm) throws Exception{
		sqlSession.insert(mapper+".recordMsg",hm);
	}
	
	public List getMsg(String bang_id) throws Exception{
		return sqlSession.selectList(mapper+".getRecord",bang_id);
	}
}
