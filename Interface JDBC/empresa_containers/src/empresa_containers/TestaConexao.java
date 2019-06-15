package empresa_containers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.hsqldb.DatabaseManager;

public class TestaConexao {

	public static void main(String[] args) throws SQLException {

		Connection connection = Database.getConnection();
		connection.close();
		
		System.out.println("Foi '-'");
		
	}

}
