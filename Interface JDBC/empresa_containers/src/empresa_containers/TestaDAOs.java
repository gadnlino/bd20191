package empresa_containers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import empresa_containers.dao.ClienteDAO;
import empresa_containers.dao.ContainerDAO;
import empresa_containers.modelo.Cliente;
import empresa_containers.modelo.Container;

public class TestaDAOs {

	public static void main(String[] args) throws SQLException {
		
		try(Connection conn = new ConnectionPool().getConnection()){
			
			ClienteDAO dao = new ClienteDAO(conn);
			
			List<Cliente> produtos = dao.lista();
			for (Cliente p : produtos) {
				System.out.println(p);
			}
		
		}

	}
	
}