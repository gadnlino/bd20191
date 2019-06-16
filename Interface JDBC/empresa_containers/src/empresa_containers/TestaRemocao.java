package empresa_containers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class TestaRemocao {
	
	/**
	 * Remove uma ou mais tuplas baseadas na condicao desejada. O SQL formado e no formato
	 * "DELETE FROM table WHERE condition ;"
	 * Note que dessa forma nao e possivel deletar a tabela inteira
	 * @param connection Conexao ja aberta com o banco de dados
	 * @param table Nome da tabela
	 * @param condition Condicao para se deletar uma ou mais tuplas da tabela
	 * @throws SQLException
	 */
	private static void removeTupla(Connection connection, String table, String condition) throws SQLException {
		
		String sql = "DELETE FROM " + table + " WHERE " + condition + ";";
		Statement statement = connection.createStatement();

		statement.execute(sql);
		
		int count = statement.getUpdateCount();
		
		System.out.println(count + " Linha(s) Alterada(s)");
		
		statement.close();
	}

	public static void main(String[] args) throws SQLException {

		Connection connection = new ConnectionPool().getConnection();
		removeTupla(connection, "Seguradora", "idSeguradora_PK = 101" );
		connection.close();

	}



}
