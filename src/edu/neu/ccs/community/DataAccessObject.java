/**
 * 
 */
package edu.neu.ccs.community;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

/**
 * @author Zhenhuan
 *
 */
public class DataAccessObject {
	/** The name of the MySQL account to use (or empty for anonymous) */
	private final String userName = "root";

	/** The password for the MySQL account (or empty for anonymous) */
	private final String password = "hpahzGSYCl05116";

	/** The name of the computer running MySQL */
	private final String serverName = "localhost";

	/** The port of the MySQL server (default is 3306) */
	private final int portNumber = 3306;

	/**
	 * The name of the database we are testing with (this default is installed
	 * with MySQL)
	 */
	private final String dbName = "community";
	public static void main(String[] args){
		DataAccessObject dao = new DataAccessObject();
		try {
			dao.searchForumByName("cat");
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/*
	 * public Connection getConnection() {
	 * Class.forName("com.mysql.jdbc.Driver").newInstance(); String
	 * connectionUrl = ""; return null; }
	 */
	public Connection getConnection()
			throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection connection = null;
		Properties connectionProps = new Properties();
		connectionProps.put("user", this.userName);
		connectionProps.put("password", this.password);

		connection = DriverManager.getConnection(
				"jdbc:mysql://" + this.serverName + ":" + this.portNumber + "/" + this.dbName, connectionProps);

		return connection;
	}
<<<<<<< HEAD
	
	/** Create User*/
	public void create(User user) throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
=======

	public void create(User user)
			throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
>>>>>>> refs/remotes/wuzhenh/master
		String sql = "SELECT create_user(?,?,?,?,?,?,?,?)";

		try (Connection connection = this.getConnection();
				PreparedStatement statement = connection.prepareStatement(sql)) {
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
		;
	}
<<<<<<< HEAD
/*	*//** Delete User*//*
	public void delete(User user) throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
=======

	public void delete(User user)
			throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
>>>>>>> refs/remotes/wuzhenh/master
		String sql = "CALL delete_user(?)";

		try (Connection connection = this.getConnection();
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, user.getUsername());

			statement.execute();

		}
		;

<<<<<<< HEAD
	}*/
/*	*//** Delete user by name*//*
	public void deleteUser(String username) throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
=======
	}

	public void deleteUser(String username)
			throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
>>>>>>> refs/remotes/wuzhenh/master
		String sql = "CALL delete_user(?)";

		try (Connection connection = this.getConnection();
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, username);

			statement.execute();
		}
<<<<<<< HEAD
	}*/
	
	/** Create forum*/
	public void create(Forum forum) throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
=======
	}

	public void create(Forum forum)
			throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
>>>>>>> refs/remotes/wuzhenh/master
		String sql = "SELECT create_forum(?,?,?,?,?,?,?)";

		try (Connection connection = this.getConnection(); PreparedStatement statement = connection.prepareCall(sql)) {
			if (forum.getParentID() == null)
				statement.setNull(1, Types.INTEGER);
			else
				statement.setInt(1, forum.getParentID());
			statement.setString(2, forum.getForumName());
			statement.setString(3, forum.getOwner());
			statement.setString(4, forum.getCatagory());
			statement.setString(5, forum.getDescription());
			statement.setDate(6, forum.getCreationTime());
			statement.setBoolean(7, forum.isVerified());

			statement.execute();
		}
	};

	public List<Forum> searchForumByName(String name) throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
		String sql = "CALL search_forum_by_name(?)";
		ArrayList<Forum> result = new ArrayList<Forum>();
		try (
				Connection connection = this.getConnection(); 
				PreparedStatement statement = connection.prepareCall(sql))
			{
				statement.setString(1, name);
				ResultSet rs = statement.executeQuery();
				while (rs.next()) {
					int forumID = rs.getInt("ForumID");
					Integer parentID = rs.getInt("ParentID");
					String forumName = rs.getString("ForumName");
					String owner = rs.getString("Forum_Owner");
					String catagory = rs.getString("Forum_Catagory");
					String description = rs.getString("Forum_Description");
					Date creationTime = rs.getDate("Forum_CreationTime");
					Date lastPostTime = rs.getDate("Forum_LastPostTime");
					boolean isVerified = rs.getBoolean("Forum_IsVerified");
					result.add(new Forum(forumID, parentID, forumName, owner, 
							catagory, description, creationTime, lastPostTime, isVerified));
					System.out.println(forumName);	// **TEST**		
				}
			}
			
		return result;		
	}

}
