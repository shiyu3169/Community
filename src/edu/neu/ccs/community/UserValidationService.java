/**
 * 
 */
package edu.neu.ccs.community;

/**
 * @author Zhenhuan
 *
 */
public class UserValidationService {
	boolean isValid(String username, String password) {
		return username.equals("username") && password.equals("password");
	}
}
