package com.kh.msg.edoc.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.msg.edoc.model.vo.EdocSrch;
import com.kh.msg.edoc.model.vo.Jstree;
import com.kh.msg.edoc.model.vo.JstreeMem;

@Repository
public class EdocDAOImpl implements EdocDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<Jstree> selectJstree() {
		return sqlSession.selectList("edoc.jstree");
	}

	@Override
	public JstreeMem selectJstreeMem(String id) {
		Map map = new HashMap<String, String>();
		map.put("empNo", id);
		return sqlSession.selectOne("edoc.jstreeMem", map);
	}

	@Override
	public List<EdocSrch> selectList(int cPage, int numPerPage, String srchWord, String srchType) {
		int offset = (cPage-1)*numPerPage;
		int limit = numPerPage;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		Map<String, String> map = new HashMap<>();
		map.put("srchWord", srchWord);
		map.put("srchType", srchType);
		
		return sqlSession.selectList("edoc.srchList", map, rowBounds);
	}

	@Override
	public int selectEdocTotalContents(String srchWord, String srchType) {
		Map<String, String> map = new HashMap<>();
		map.put("srchWord", srchWord);
		map.put("srchType", srchType);
		
		return sqlSession.selectOne("edoc.selectEdocTotalContents", map);
	}

	@Override
	public List<EdocSrch> selectMyList(int cPage, int numPerPage, Map<String, String> map) {
		int offset = (cPage-1)*numPerPage;
		int limit = numPerPage;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return sqlSession.selectList("edoc.myList", map, rowBounds);
	}

	@Override
	public int selectMyEdocTotalContents(Map<String, String> map) {
		return sqlSession.selectOne("edoc.selectMyEdocTotalContents", map);
	}

	@Override
	public String newEdocId() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("edoc.newEdocId");
	}
	
	
}
