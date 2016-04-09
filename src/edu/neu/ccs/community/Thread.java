/**
 * 
 */
package edu.neu.ccs.community;
import java.sql.Timestamp;
/**
 * @author Zhenhuan
 *
 */
public class Thread {
	Integer threadID;
    int forumID;
    String title;
    String author;
    String lastUpdator;
    
    Timestamp creationTime;
    Timestamp lastPostTime;
    
    boolean isSticky;
    boolean isDeleted;
	/**
	 * @param threadID
	 * @param forumID
	 * @param title
	 * @param author
	 * @param lastUpdator
	 * @param creationTime
	 * @param lastPostTime
	 * @param isSticky
	 * @param isDeleted
	 */
	public Thread(Integer threadID, int forumID, String title, String author, String lastUpdator,
			Timestamp creationTime, Timestamp lastPostTime, boolean isSticky, boolean isDeleted) {
		super();
		this.threadID = threadID;
		this.forumID = forumID;
		this.title = title;
		this.author = author;
		this.lastUpdator = lastUpdator;
		this.creationTime = creationTime;
		this.lastPostTime = lastPostTime;
		this.isSticky = isSticky;
		this.isDeleted = isDeleted;
	}
	/**
	 * @param forumID
	 * @param title
	 * @param author
	 * @param isSticky
	 * @param isDeleted
	 */
	public Thread(int forumID, String title, String author, boolean isSticky, boolean isDeleted) {
		super();
		//this.threadID = null;
		this.forumID = forumID;
		this.title = title;
		this.author = author;
		this.lastUpdator = author;
		this.creationTime = new Timestamp(System.currentTimeMillis());
		this.lastPostTime = new Timestamp(System.currentTimeMillis());
		this.isSticky = isSticky;
		this.isDeleted = isDeleted;
	}
	/**
	 * @return the threadID
	 */
	public Integer getThreadID() {
		return threadID;
	}
	/**
	 * @param threadID the threadID to set
	 */
	public void setThreadID(Integer threadID) {
		this.threadID = threadID;
	}
	/**
	 * @return the forumID
	 */
	public int getForumID() {
		return forumID;
	}
	/**
	 * @param forumID the forumID to set
	 */
	public void setForumID(int forumID) {
		this.forumID = forumID;
	}
	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * @return the author
	 */
	public String getAuthor() {
		return author;
	}
	/**
	 * @param author the author to set
	 */
	public void setAuthor(String author) {
		this.author = author;
	}
	/**
	 * @return the lastUpdator
	 */
	public String getLastUpdator() {
		return lastUpdator;
	}
	/**
	 * @param lastUpdator the lastUpdator to set
	 */
	public void setLastUpdator(String lastUpdator) {
		this.lastUpdator = lastUpdator;
	}
	/**
	 * @return the creationTime
	 */
	public Timestamp getCreationTime() {
		return creationTime;
	}
	/**
	 * @param creationTime the creationTime to set
	 */
	public void setCreationTime(Timestamp creationTime) {
		this.creationTime = creationTime;
	}
	/**
	 * @return the lastPostTime
	 */
	public Timestamp getLastPostTime() {
		return lastPostTime;
	}
	/**
	 * @param lastPostTime the lastPostTime to set
	 */
	public void setLastPostTime(Timestamp lastPostTime) {
		this.lastPostTime = lastPostTime;
	}
	/**
	 * @return the isSticky
	 */
	public boolean isSticky() {
		return isSticky;
	}
	/**
	 * @param isSticky the isSticky to set
	 */
	public void setSticky(boolean isSticky) {
		this.isSticky = isSticky;
	}
	/**
	 * @return the isDeleted
	 */
	public boolean isDeleted() {
		return isDeleted;
	}
	/**
	 * @param isDeleted the isDeleted to set
	 */
	public void setDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
	}
    
}
