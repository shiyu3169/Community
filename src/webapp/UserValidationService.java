/**
 * 
 */
package webapp;

/**
 * @author Zhenhuan
 *
 */
public class UserValidationService {
	boolean isValid(String username, String password) {
		return username.equals("username") && password.equals("password");
	}
}
