package com.common.dao;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
 
import com.common.dao.AbstractDAO;
 
@Repository("sampleDAO")
public class SampleDAO extends AbstractDAO{

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectBoardList(String string) throws Exception{
        return (List<Map<String, Object>>)selectList("select_Sql.selectBoardList", string);
    }
}
