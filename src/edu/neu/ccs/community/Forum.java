/**
 * 
 */
package edu.neu.ccs.community;
import java.sql.Date;
/**
 * @author Zhenhuan
 *
 */
public class Forum {
	private int forumID;
	private int parentID;
	private String forumName;
	private String owner;
    //private User owner;
    private String catagory;
    private String description;
    
    private Date creationTime;
    private Date lastPostTime;
    
    private boolean isVerified;
}
