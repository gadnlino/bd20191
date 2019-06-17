package empresa_containers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import empresa_containers.Insercao;
import empresa_containers.modelo.Container;

public class ContainerDAO {
	
	private Connection conn;

	public ContainerDAO(Connection conn) {
		this.conn = conn;
	}

	public void salva(Container novoContainer) throws SQLException {

		String sql = "INSERT INTO Container (dataAquisicao, comprimento, altura, largura, capacidade, statusContainer, " +
				"vidaUtil, lotacaoAtual, idLote_FK, disponibilidade) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

			stmt.setString(1, novoContainer.getDataAquisicao());
			stmt.setDouble(2, novoContainer.getComprimento());
			stmt.setDouble(3, novoContainer.getAltura());
			stmt.setDouble(4, novoContainer.getLargura());
			stmt.setDouble(5, novoContainer.getCapacidade());
			stmt.setString(6, novoContainer.getStatusContainer());
			stmt.setInt(7, novoContainer.getVidaUtil());
			stmt.setInt(8, novoContainer.getLotacaoAtual());
			stmt.setInt(9, novoContainer.getIdLote_FK());
			stmt.setBoolean(10, novoContainer.isDisponibilidade());

			stmt.execute();
			
			try(ResultSet rs = stmt.getGeneratedKeys()){
				
				if(rs.next()) {
					int id = rs.getInt("id");
					novoContainer.setIdContainer_PK(id);
				}
				
			}
			
		}
		
	}
	
	public List<Container> lista() throws SQLException {
		String sql = "SELECT * FROM Container";
		try (PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.execute();
			ResultSet resultSet = stmt.getResultSet();
			ArrayList<Container> containers = new ArrayList<>();
			while(resultSet.next()) {
				String at2 = resultSet.getString(2);
				double at3 = resultSet.getDouble(3);
				double at4 = resultSet.getDouble(4);
				double at5 = resultSet.getDouble(5);
				double at6 = resultSet.getDouble(6);
				String at7 = resultSet.getString(7);
				int at8 = resultSet.getInt(8);
				int at9 = resultSet.getInt(9);
				int at10 = resultSet.getInt(10);
				boolean at11 = resultSet.getBoolean(11);
				int id = resultSet.getInt(1);
				

				Container c = new Container(at2, at3, at4, at5, at6, at7, at8, at9, at10, at11);
				c.setIdContainer_PK(id);
				containers.add(c);
			}
			return containers;
		}
	}
	

}
