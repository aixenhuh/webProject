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

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Object signUpDao(HashMap hashmap) {
		return insert("select_Sql.signUpDao", hashmap);
	}
	
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public Object writeBoardOne(HashMap hashmap) throws Exception{
        return insert("select_Sql.writeNotice", hashmap);
    }
}
