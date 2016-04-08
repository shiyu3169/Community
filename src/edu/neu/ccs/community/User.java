/**
 * 
 */
package edu.neu.ccs.community;

import java.time.ZonedDateTime;
import java.sql.Date;

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

	Date registerationTime;
	Date lastLoginTime;
	Date lastPostTime;

	boolean isAdministrator;
	boolean isBanned;
	
	//Constructor
	public User(String username, String password, String email, String loginIpAddress, Date registerationTime,
			Date lastLoginTime, Date lastPostTime, boolean isAdministrator, boolean isBanned) {
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
	}
	//Constructor without time
	public User(String username, String password, String email, String loginIpAddress, boolean isAdministrator,
			boolean isBanned) {
		super();
		// this.userID = null;
		this.username = username;
		this.password = password;
		this.email = email;
		// this.registerationIpAddress = registerationIpAddress;
		this.loginIpAddress = loginIpAddress;
		this.registerationTime = new Date(System.currentTimeMillis());
		this.lastLoginTime = new Date(System.currentTimeMillis());
		this.lastPostTime = null;
		this.isAdministrator = isAdministrator;
		this.isBanned = isBanned;
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

	public Date getRegisterationTime() {
		return this.registerationTime;
	}

	public void setRegisterationTime(Date registerationTime) {
		this.registerationTime = registerationTime;
	}

	public Date getLastLoginTime() {
		return this.lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public Date getLastPostTime() {
		return this.lastPostTime;
	}

	public void setLastPostTime(Date lastPostTime) {
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

}
