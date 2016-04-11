/**
 * 
 */
package edu.neu.ccs.community;

import java.sql.Timestamp;

public class Post {
	public Post(Integer postID, int threadID, Integer replyToPost, String author, String content,
			Timestamp creationTime, Timestamp lastModificationTime, boolean isDeleted) {
		super();
		this.postID = postID;
		ThreadID = threadID;
		ReplyToPost = replyToPost;
		this.author = author;
		this.content = content;
		CreationTime = creationTime;
		this.lastModificationTime = lastModificationTime;
		this.isDeleted = isDeleted;
	}
	public Post(int threadID, String author, String content, boolean isDeleted) {
		super();
		this.postID = null;
		ThreadID = threadID;
		ReplyToPost = null;
		this.author = author;
		this.content = content;
		CreationTime = new Timestamp(System.currentTimeMillis());
		this.lastModificationTime = null;
		this.isDeleted = isDeleted;
	}
	Integer postID;
    int ThreadID;
    Integer ReplyToPost;
    
    String author;
    //String LastModifier;
    
    String content;
    
    Timestamp CreationTime;
    Timestamp lastModificationTime;
    
    boolean isDeleted;

	/**
	 * @return the postID
	 */
	public Integer getPostID() {
		return postID;
	}

	/**
	 * @param postID the postID to set
	 */
	public void setPostID(Integer postID) {
		this.postID = postID;
	}

	/**
	 * @return the threadID
	 */
	public int getThreadID() {
		return ThreadID;
	}

	/**
	 * @param threadID the threadID to set
	 */
	public void setThreadID(int threadID) {
		ThreadID = threadID;
	}

	/**
	 * @return the replyToPost
	 */
	public Integer getReplyToPost() {
		return ReplyToPost;
	}

	/**
	 * @param replyToPost the replyToPost to set
	 */
	public void setReplyToPost(Integer replyToPost) {
		ReplyToPost = replyToPost;
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
	 * @return the content
	 */
	public String getContent() {
		return content;
	}

	/**
	 * @param content the content to set
	 */
	public void setContent(String content) {
		this.content = content;
	}

	/**
	 * @return the creationTime
	 */
	public Timestamp getCreationTime() {
		return CreationTime;
	}

	/**
	 * @param creationTime the creationTime to set
	 */
	public void setCreationTime(Timestamp creationTime) {
		CreationTime = creationTime;
	}

	/**
	 * @return the lastModificationTime
	 */
	public Timestamp getLastModificationTime() {
		return lastModificationTime;
	}

	/**
	 * @param lastModificationTime the lastModificationTime to set
	 */
	public void setLastModificationTime(Timestamp lastModificationTime) {
		this.lastModificationTime = lastModificationTime;
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
