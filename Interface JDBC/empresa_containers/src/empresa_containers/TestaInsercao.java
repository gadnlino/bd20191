package empresa_containers;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class TestaInsercao {

	public static void main(String[] args) throws SQLException {
		Connection connection = Database.getConnection();
		
		Statement statement = connection.createStatement();
		boolean result = statement.execute("INSERT INTO Seguradora "
				+ "VALUES ('101', 'contato@vaique.com.br', '54781230257580', 'Vai Que S/A', 'Vai Que.. Seguradora', '21978445120')");
		
		int count = statement.getUpdateCount();
		
		System.out.println(count + " Linha(s) Alterada(s)");

		statement.close();
		connection.close();

	}

}

/*
 * 
		statement.execute("INSERT INTO Seguradora (emailSeguradora, cnpj, razaoSocial, nome, telefone) "
				+ "VALUES ('contato@vaique.com.br', '54781230257580', 'Vai Que S/A', 'Vai Que.. Seguradora', '21978445120')",
				statement.RETURN_GENERATED_KEYS);
		
		ResultSet resultSet = statement.getGeneratedKeys();
		
		while(resultSet.next()) {
			String id = resultSet.getString("id");
			System.out.println(id + " gerado");
		}
		
 * 
 * 
 */