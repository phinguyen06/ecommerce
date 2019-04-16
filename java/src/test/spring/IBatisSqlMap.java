package test.spring;

import com.ibatis.sqlmap.client.SqlMapClient;

public class IBatisSqlMap {
	protected SqlMapClient sqlMap = null;

    public void setSqlMapClient(SqlMapClient sqlMap) {
        this.sqlMap = sqlMap;
    }
}
