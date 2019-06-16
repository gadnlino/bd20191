package empresa_containers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import empresa_containers.modelo.Container;
import empresa_containers.modelo.Container.StatusContainer;

public class TestaInsercaoDeContainer {

	public static void main(String[] args) throws SQLException {
		StatusContainer sc = StatusContainer.Disponivel;
		Container novoContainer = new Container(301, "2019-06-16", 8.0, 3.0, 3.0, 72.0, sc, 120, 0, 10, true);

		salva(novoContainer);

	}

	private static void salva(Container novoContainer) throws SQLException {

		try (Connection conn = new ConnectionPool().getConnection()) {

			String sql = Insercao.preparedStatementPreForm_Insertion("Container", 11);

			try (PreparedStatement stmt = conn.prepareStatement(sql)) {

				stmt.setInt(1, novoContainer.getIdContainer_PK());
				stmt.setString(2, novoContainer.getDataAquisicao());
				stmt.setDouble(3, novoContainer.getComprimento());
				stmt.setDouble(4, novoContainer.getAltura());
				stmt.setDouble(5, novoContainer.getLargura());
				stmt.setDouble(6, novoContainer.getCapacidade());
				stmt.setString(7, novoContainer.getStatusContainer().toString());
				stmt.setInt(8, novoContainer.getVidaUtil());
				stmt.setInt(9, novoContainer.getLotacaoAtual());
				stmt.setInt(10, novoContainer.getIdLote_FK());
				stmt.setBoolean(11, novoContainer.isDisponibilidade());
				
				stmt.execute();

				/*try (ResultSet result = stmt.getGeneratedKeys()) {
					result.next();
					int id = result.getInt("id");
					novoContainer.setIdContainer_PK(id);

				}
				*/
			}

		}

	}
}