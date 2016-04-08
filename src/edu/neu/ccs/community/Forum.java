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
	private Integer parentID;
	private String forumName;
	private String owner;
    //private User owner;
    private String catagory;
    private String description;
    
    private Date creationTime;
    private Date lastPostTime;
    
    private boolean isVerified;

	/**
	 * @param forumID
	 * @param parentID
	 * @param forumName
	 * @param owner
	 * @param catagory
	 * @param description
	 * @param creationTime
	 * @param lastPostTime
	 * @param isVerified
	 */
	public Forum(int forumID, Integer parentID, String forumName, String owner, String catagory, String description,
			Date creationTime, Date lastPostTime, boolean isVerified) {
		super();
		this.forumID = forumID;
		this.parentID = parentID;
		this.forumName = forumName;
		this.owner = owner;
		this.catagory = catagory;
		this.description = description;
		this.creationTime = creationTime;
		this.lastPostTime = lastPostTime;
		this.isVerified = isVerified;
	}
	

	/**
	 * @param parentID
	 * @param forumName
	 * @param owner
	 * @param catagory
	 * @param description
	 * @param isVerified
	 */
	public Forum(Integer parentID, String forumName, String owner, String catagory, String description,
			boolean isVerified) {
		super();
		this.parentID = parentID;
		this.forumName = forumName;
		this.owner = owner;
		this.catagory = catagory;
		this.description = description;
		this.isVerified = isVerified;
		this.creationTime = new Date(System.currentTimeMillis());
	}


	public int getForumID() {
		return forumID;
	}

	public void setForumID(int forumID) {
		this.forumID = forumID;
	}

	public Integer getParentID() {
		return parentID;
	}

	public void setParentID(int parentID) {
		this.parentID = parentID;
	}

	public String getForumName() {
		return forumName;
	}

	public void setForumName(String forumName) {
		this.forumName = forumName;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public String getCatagory() {
		return catagory;
	}

	public void setCatagory(String catagory) {
		this.catagory = catagory;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getCreationTime() {
		return creationTime;
	}

	public void setCreationTime(Date creationTime) {
		this.creationTime = creationTime;
	}

	public Date getLastPostTime() {
		return lastPostTime;
	}

	public void setLastPostTime(Date lastPostTime) {
		this.lastPostTime = lastPostTime;
	}

	public boolean isVerified() {
		return isVerified;
	}

	public void setVerified(boolean isVerified) {
		this.isVerified = isVerified;
	}
    
    
}
