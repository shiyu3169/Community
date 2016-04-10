/**
 * 
 */
package edu.neu.ccs.community;
import java.sql.Date;
/**
 * @author Zhenhuan
 *
 */
public class Thread {
	int threadID;
    Forum forum;
    String title;
    User author;
    
    Date lastUpdator;    
    Date creationTime;
    Date lastPostTime;
    
    boolean isSticky;
    boolean isDeleted;
}
