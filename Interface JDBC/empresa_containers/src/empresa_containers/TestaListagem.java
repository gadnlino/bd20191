package empresa_containers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class TestaListagem {
	
	static void listaTupla (Connection connection, String table, int numeroLinha) throws SQLException {
		
		Statement statement = connection.createStatement();
		boolean result = statement.execute("SELECT * FROM " + table);
		ResultSet resultSet = statement.getResultSet();
		
		for (int i = 0; i < numeroLinha; i++)
			resultSet.next();
		
		int contagemColuna = resultSet.getMetaData().getColumnCount();
		for (int i = 1; i <= contagemColuna; i++)
		{
			String string = resultSet.getString(i);
			System.out.println(string);
		}
		
		resultSet.close();
		statement.close();
		
		return;
	}
	
	public static void main(String[] args) throws SQLException {
		Connection connection = Database.getConnection();
		
		// listaTupla (Conexao, Nome da Tabela, Numero Da Linha);
		listaTupla(connection, "Container", 1);
		
		connection.close();
	}


	
}
