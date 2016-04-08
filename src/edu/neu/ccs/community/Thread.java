/**
 * 
 */
package edu.neu.ccs.community;
import java.time.ZonedDateTime;
/**
 * @author Zhenhuan
 *
 */
public class Thread {
	int threadID;
    Forum forum;
    String title;
    User author;
    
    ZonedDateTime lastUpdator;    
    ZonedDateTime creationTime;
    ZonedDateTime lastPostTime;
    
    boolean isSticky;
    boolean isDeleted;
}
