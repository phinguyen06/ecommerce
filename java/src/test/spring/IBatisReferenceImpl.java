package test.spring;

import java.util.List;

import test.spring.IBatisReference;
import test.spring.IBatisSqlMap;
import com.ebiz.data.Status;

public class IBatisReferenceImpl extends IBatisSqlMap implements IBatisReference {	
	public Status[] getStatus() throws Exception
	{
		List<Status> statuses = (List<Status>) sqlMap.queryForList("getStatus");
		Status[] rets = new Status[statuses.size()];
		int i=0;
		for( Status status : statuses){
			rets[i++] = status;
		}
		return rets;
		
	}
}
