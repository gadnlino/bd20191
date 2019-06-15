package empresa_containers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {

	static Connection getConnection() throws SQLException {
		Connection connection = DriverManager.getConnection("jdbc:mysql://db4free.net:3306/remote_mysql", "lucas_sql", "180897ll");
		return connection;
	}
	
}
