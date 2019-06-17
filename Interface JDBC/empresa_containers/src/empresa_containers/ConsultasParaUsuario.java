package empresa_containers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import empresa_containers.modelo.Cliente;

public class ConsultasParaUsuario {
	
	
	public static void id_Dos_Produtos_PF(String cpf) throws SQLException {
		
		ArrayList<Integer> lista = new ArrayList<>();
		
		try(Connection connection = new ConnectionPool().getConnection()){
			
			int idMaximo;
			
			String sql = "select idProduto_PK from Produto\r\n" + 
					"where idPedido_FK in (select idPedido_PK from Pedido \r\n" + 
					"                        where idCliente_FK in (select idCliente_PK from Cliente\r\n" + 
					"                                                where idCliente_PK in (select idCliente_SPK from PessoaFisica\r\n" + 
					"                                                                        where cpf = '" + cpf +"')));";
			
			try(Statement statement = connection.createStatement()){
				
				statement.execute(sql);
				
				try(ResultSet result = statement.getResultSet()){
					
					while(result.next())
					{
						int id = result.getInt(1);
						lista.add(id);
					}
					
					
				}
				
			}
			
			
		}
		
		System.out.println(lista.toString());

		return ;
	}
	
	public static void id_Dos_Produtos_PJ(String cnpj) throws SQLException {
		
		ArrayList<Integer> lista = new ArrayList<>();
		
		try(Connection connection = new ConnectionPool().getConnection()){
			
			int idMaximo;
			
			String sql = "select idProduto_PK from Produto\r\n" + 
					"where idPedido_FK in (select idPedido_PK from Pedido \r\n" + 
					"                        where idCliente_FK in (select idCliente_PK from Cliente\r\n" + 
					"                                                where idCliente_PK in (select idCliente_SPK from PessoaJuridica\r\n" + 
					"                                                                        where cnpj = '" + cnpj + "')));";
			
			try(Statement statement = connection.createStatement()){
				
				statement.execute(sql);
				
				try(ResultSet result = statement.getResultSet()){
					
					while(result.next())
					{
						int id = result.getInt(1);
						lista.add(id);
					}
					
					
				}
				
			}
			
			
		}
		
		System.out.println(lista.toString());

		return ;
	}
	
	public static void cliente_E_Pedidos_Afetados_Por_Acidente(String acidente) throws SQLException {
		
		try(Connection connection = new ConnectionPool().getConnection()){
			
			int idMaximo;
			
			String sql = "select nome, idPedido_PK from Cliente c, Pedido p, Cobre co\r\n" + 
					"where c.idCliente_PK = p.idCliente_FK and p.idPedido_PK = co.idPedido_SPK and co.idAcidente_SPK = " + acidente + ";";
			
			try(Statement statement = connection.createStatement()){
				
				statement.execute(sql);
				
				try(ResultSet result = statement.getResultSet()){
					
					while(result.next())
					{
						String nome = result.getString(1);
						int id = result.getInt(2);
						System.out.println("[" + nome + ", " + id + "]");
					}
					
					
				}
				
			}
			
			
		}

		return ;
	}
	
	public static void proc_Insere_Pedido(String str1, String str2, String str3, String str4) throws SQLException {
		
		try(Connection connection = new ConnectionPool().getConnection()){
			
			int idMaximo;
			
			String sql = "CALL PROC_inserePedido( '" + str1 +"', '" + str2 +"', '" + str3 +"', '" + str4 +"')";
			
			
			try(Statement statement = connection.createStatement()){
				
				statement.execute(sql);
				
				System.out.println("Pedido Inserido com sucesso!");
			}
			
			
		}
		
		return ;
		
	}

}
