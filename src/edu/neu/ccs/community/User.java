/**
 * 
 */
package edu.neu.ccs.community;

import java.time.ZonedDateTime;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * @author Zhenhuan
 *
 */
public class User {
	// Integer userID;
	String username;
	String password;
	String email;
	// String registerationIpAddress;
	String loginIpAddress;

	Timestamp registerationTime;
	Timestamp lastLoginTime;
	Timestamp lastPostTime;

	boolean isAdministrator;
	boolean isBanned;
	int newMessages;
	//Constructor
	public User(String username, String password, String email, String loginIpAddress, Timestamp registerationTime,
			Timestamp lastLoginTime, Timestamp lastPostTime, boolean isAdministrator, boolean isBanned) {
		super();
		// this.userID = userID;
		this.username = username;
		this.password = password;
		this.email = email;
		// this.registerationIpAddress = registerationIpAddress;
		this.loginIpAddress = loginIpAddress;
		this.registerationTime = registerationTime;
		this.lastLoginTime = lastLoginTime;
		this.lastPostTime = lastPostTime;
		this.isAdministrator = isAdministrator;
		this.isBanned = isBanned;
		this.newMessages = 0;
	}
	//Constructor without time
	public User(String username, String password, String email, String loginIpAddress, boolean isAdministrator,
			boolean isBanned, int newMessages) {
		super();
		// this.userID = null;
		this.username = username;
		this.password = password;
		this.email = email;
		// this.registerationIpAddress = registerationIpAddress;
		this.loginIpAddress = loginIpAddress;
		this.registerationTime = new Timestamp(System.currentTimeMillis());
		this.lastLoginTime = new Timestamp(System.currentTimeMillis());
		this.lastPostTime = null;
		this.isAdministrator = isAdministrator;
		this.isBanned = isBanned;
		this.newMessages = newMessages;
	}
	
	//getter and setter
	public String getUsername() {
		return username;
	}

	public void setUserName(String userName) {
		this.username = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String eMail) {
		this.email = eMail;
	}

	public String getLoginIpAddress() {
		return this.loginIpAddress;
	}

	public void setLoginIpAddress(String loginIpAddress) {
		this.loginIpAddress = loginIpAddress;
	}

	public Timestamp getRegisterationTime() {
		return this.registerationTime;
	}

	public void setRegisterationTime(Timestamp registerationTime) {
		this.registerationTime = registerationTime;
	}

	public Timestamp getLastLoginTime() {
		return this.lastLoginTime;
	}

	public void setLastLoginTime(Timestamp lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public Timestamp getLastPostTime() {
		return this.lastPostTime;
	}

	public void setLastPostTime(Timestamp lastPostTime) {
		this.lastPostTime = lastPostTime;
	}

	public boolean isAdministrator() {
		return isAdministrator;
	}

	public void setAdministrator(boolean isAdministrator) {
		this.isAdministrator = isAdministrator;
	}

	public boolean isBanned() {
		return isBanned;
	}

	public void setBanned(boolean isBanned) {
		this.isBanned = isBanned;
	}
	/**
	 * @return the newMessages
	 */
	public int getNewMessages() {
		return newMessages;
	}
	/**
	 * @param newMessages the newMessages to set
	 */
	public void setNewMessages(int newMessages) {
		this.newMessages = newMessages;
	}
	/**
	 * @param username the username to set
	 */
	public void setUsername(String username) {
		this.username = username;
	}

}
