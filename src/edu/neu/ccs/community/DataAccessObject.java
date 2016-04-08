/**
 * 
 */
package edu.neu.ccs.community;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

/**
 * @author Zhenhuan
 *
 */
public class DataAccessObject {
	/** The name of the MySQL account to use (or empty for anonymous) */
	private final String userName = "root";

	/** The password for the MySQL account (or empty for anonymous) */
	private final String password = "cliff92711";

	/** The name of the computer running MySQL */
	private final String serverName = "localhost";

	/** The port of the MySQL server (default is 3306) */
	private final int portNumber = 3306;

	/**
	 * The name of the database we are testing with (this default is installed
	 * with MySQL)
	 */
	private final String dbName = "community";

	/*
	 * public Connection getConnection() {
	 * Class.forName("com.mysql.jdbc.Driver").newInstance(); String
	 * connectionUrl = ""; return null; }
	 */
	public Connection getConnection() throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection connection = null;
		Properties connectionProps = new Properties();
		connectionProps.put("user", this.userName);
		connectionProps.put("password", this.password);

		connection = DriverManager.getConnection(
				"jdbc:mysql://" + this.serverName + ":" + this.portNumber + "/" + this.dbName,
				connectionProps);

		return connection;
	}

	/** Create User 
	 * @throws ClassNotFoundException 
	 * @throws IllegalAccessException 
	 * @throws InstantiationException 
	 * @throws SQLException */
	public void create(User user) throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
		String sql = "CALL create_user(?,?,?,?,?,?,?,?)";
		
		try (
			Connection connection = this.getConnection(); 
			PreparedStatement statement = connection.prepareStatement(sql))
		{
			statement.setString(1, user.getUsername());
			statement.setString(2, user.getPassword());
			statement.setString(3, user.getEmail());
			statement.setString(4, user.getLoginIpAddress());
			statement.setBoolean(5, user.isAdministrator());
			statement.setBoolean(6, user.isBanned());
			statement.setDate(7, user.getRegisterationTime());
			statement.setDate(8, user.getLastLoginTime());
			statement.execute();
			
		}
	}
}
