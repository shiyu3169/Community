/**
 * 
 */
package edu.neu.ccs.community;
import java.time.ZonedDateTime;
/**
 * @author Zhenhuan
 *
 */
public class Forum {
	private int forumID;
	private int parentID;
	private String forumName;
    private User owner;
    private String catagory;
    private String description;
    
    private ZonedDateTime creationTime;
    private ZonedDateTime lastPostTime;
    
    private boolean isVerified;
}
