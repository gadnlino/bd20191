package empresa_containers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class TestaListagem {
	
	/**
	 * Lista uma linha desejada do nome da tabela recebido
	 * @param connection Conexao ja aberta com o banco de dados
	 * @param table Nome da tabela
	 * @param numeroLinha Numero da linha da tabela que se deseja receber os dados (comecando em 1)
	 * @return Retorna uma String com linhas no formato "NomeDaColuna: Valor"
	 * @throws SQLException
	 */
	static String listaTupla (Connection connection, String table, int numeroLinha) throws SQLException {
		String str = "";
		String sql = "SELECT * FROM " + table;
		Statement statement = connection.createStatement();
		statement.execute(sql);
		ResultSet resultSet = statement.getResultSet();
		
		for (int i = 0; i < numeroLinha; i++)
			resultSet.next();
		
		int contagemColuna = resultSet.getMetaData().getColumnCount();
		for (int i = 1; i <= contagemColuna; i++)
		{
			String string = resultSet.getString(i);
			String nomeColuna = resultSet.getMetaData().getColumnName(i);
			str = str + nomeColuna + ": " + string + "\n";
		}
		
		resultSet.close();
		statement.close();
		
		return str;
	}
	
	public static void main(String[] args) throws SQLException {
		Connection connection = Database.getConnection();
		String str;
		// listaTupla (Conexao, Nome da Tabela, Numero Da Linha);
		str = listaTupla(connection, "Seguradora", 101);
		System.out.println(str);
		
		connection.close();
	}


	
}
