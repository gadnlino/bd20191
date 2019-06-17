package empresa_containers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import empresa_containers.modelo.Cliente;
import empresa_containers.modelo.Container;

public class ClienteDAO {
	
	private Connection conn;

	public ClienteDAO(Connection conn) {
		this.conn = conn;
	}
	
	public void salva(Cliente novoCliente) throws SQLException {
		
		String sql = "INSERT INTO Cliente (cep, emailCliente, nome, endereco, telefone) VALUES (?, ?, ?, ?, ?)";

		try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

			stmt.setString(1, novoCliente.getCep());
			stmt.setString(2, novoCliente.getEmailCliente());
			stmt.setString(3, novoCliente.getNome());
			stmt.setString(4, novoCliente.getEndereco());
			stmt.setString(5, novoCliente.getTelefone());

			stmt.execute();
			
			try(ResultSet rs = stmt.getGeneratedKeys()){
				
				if(rs.next()) {
					int id = rs.getInt("id");
					novoCliente.setIdCliente_PK(id);
				}
				
			}
			
		}
		
	}
	
	public List<Cliente> lista() throws SQLException {
		String sql = "SELECT * FROM Cliente";
		try (PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.execute();
			ResultSet resultSet = stmt.getResultSet();
			ArrayList<Cliente> clientes = new ArrayList<>();
			while(resultSet.next()) {
				String at2 = resultSet.getString(2);
				String at3 = resultSet.getString(3);
				String at4 = resultSet.getString(4);
				String at5 = resultSet.getString(5);
				String at6 = resultSet.getString(6);

				int id = resultSet.getInt(1);
				

				Cliente c = new Cliente(at2, at3, at4, at5, at6);
				c.setIdCliente_PK(id);
				clientes.add(c);
			}
			return clientes;
		}
	}
	

}
