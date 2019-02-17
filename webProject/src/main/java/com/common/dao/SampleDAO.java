package com.common.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
 
@Repository("sampleDAO")
public class SampleDAO extends AbstractDAO{

    @SuppressWarnings({ "unchecked", "rawtypes" })
    public List<Map<String, Object>> selectBoardList(HashMap hashmap) throws Exception{
        return (List<Map<String, Object>>)selectList("select_Sql.selectBoardList", hashmap);
    }
    
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public List<Map<String, Object>> loginCheckList(HashMap hashmap) throws Exception{
        return (List<Map<String, Object>>)selectList("select_Sql.loginCheckList", hashmap);
    }

	@SuppressWarnings({ "rawtypes" })
	public Object signUpDao(HashMap hashmap) {
		return insert("select_Sql.signUpDao", hashmap);
	}
	
    @SuppressWarnings({ "rawtypes" })
    public Object writeBoardOne(HashMap hashmap) throws Exception{
        return insert("select_Sql.writeNotice", hashmap);
    }
    
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map<String, Object>> selectReadNotice(HashMap hashmap) {
		return (List<Map<String, Object>>)selectList("select_Sql.selectReadNotice", hashmap);
	}
	
	@SuppressWarnings({ "rawtypes" })
	public Object selectNoticeCnt(HashMap hashmap) {
		return selectList("select_Sql.selectNoticeCnt");
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNoticeInfoAll(HashMap<String, Object> hashmap) {
		return selectList("select_Sql.selectNoticeInfoAll", hashmap);
	}

	public Object passWordReset(HashMap<String, String> hashmap) {
		// TODO Auto-generated method stub
		return update("select_Sql.updatePassWord", hashmap);
	}
}
