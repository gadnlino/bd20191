package empresa_containers;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class TestaRemocao {

	public static void main(String[] args) throws SQLException {

		Connection connection = Database.getConnection();
		Statement statement = connection.createStatement();
		statement.execute("DELETE FROM Seguradora WHERE idSeguradora_PK = 101;");
		
		int count = statement.getUpdateCount();
		
		System.out.println(count + " Linha(s) Alterada(s)");
		
		statement.close();
		connection.close();

	}

}
