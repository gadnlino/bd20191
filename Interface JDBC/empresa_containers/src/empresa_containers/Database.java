package empresa_containers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {

	/**
	 * Abre uma conexao com o banco de dados desejado seguindo os padroes do MySQL.
	 * String de conexao no fortamo "jdbc:mysql://[URL ou localhost]:3306/[Nome do banco]", "username", "password"
	 * @return Retorna um ponto da conecao aberta para se fazer as queries e tudo mais
	 * @throws SQLException
	 */
	static Connection getConnection() throws SQLException {
		Connection connection = DriverManager.getConnection("jdbc:mysql://db4free.net:3306/remote_mysql", "lucas_sql", "180897ll");
		return connection;
	}
	
}
