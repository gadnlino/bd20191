package empresa_containers;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;

public class Relatorios {
	
	public static void gerar_Todos_Relatorios() throws SQLException, IOException {
		relatorio_Clientes();
		relatorio_Containers();
		relatorio_Funcionarios();
	}
	
	public static void relatorio_Containers() throws SQLException, IOException {
		
		String cabecalho = "Relatório de Containers: \n\n\n";
		String S1 = "Número total de containers: ";
		String S2 = "Número de containers Disponíveis: ";
		String S3 = "Número de containers em uso: ";
		String S4 = "Número de containers em manutenção: ";
		String S5 = "Número de containers desmobilizados: ";
		String S6 = "Número de containers que passaram da meia-vida: ";
		String S7 = "Número de containers no último ano de utilização: ";
		String FIM = "\n\nRelatório gerado dia ";
		
		String R1, R2, R3, R4, R5, R6, R7 , RFIM;
		
		
		R1 = execute_SQL("SELECT count(*) FROM \r\n" + 
				"	Container;");
		
		R2 = execute_SQL("SELECT count(*) FROM \r\n" + 
				"	(SELECT * FROM Container WHERE Container.statusContainer = 'Disponível') as Containers_Disponiveis;");
		
		R3 = execute_SQL("SELECT count(*) FROM \r\n" + 
				"	(SELECT * FROM Container WHERE Container.statusContainer = 'Em uso') as Containers_Disponiveis;");
		
		R4 = execute_SQL("SELECT count(*) FROM \r\n" + 
				"	(SELECT * FROM Container WHERE Container.statusContainer = 'Em manutenção') as Containers_Disponiveis;");
		
		R5 = execute_SQL("SELECT count(*) FROM \r\n" + 
				"	(SELECT * FROM Container WHERE Container.statusContainer = 'Desmobilizado') as Containers_Disponiveis;");
		
		R6 = execute_SQL("SELECT count(*) FROM \r\n" + 
				"	(SELECT * FROM Container c WHERE c.vidaUtil < 60 ) as Containers_Passaram_Meia_Vida;");
		
		R7 = execute_SQL("SELECT count(*) FROM \r\n" + 
				"	(SELECT * FROM Container c WHERE c.vidaUtil <= 12 ) as Containers_Passaram_Meia_Vida;");
		
		
		LocalDate hoje = LocalDate.now();
		DateTimeFormatter formatadorBarra = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		RFIM = hoje.format(formatadorBarra);
		
		
		
		List<String> lines = Arrays.asList(cabecalho, S1 + R1, S2 + R2, S3 + R3, S4 + R4, S5 + R5, S6 + R6, S7 + R7, FIM + RFIM);
		 
		Files.write(Paths.get("Relatorio_Containers.txt"),
		                lines,
		                StandardCharsets.UTF_8,
		                StandardOpenOption.CREATE,
		                StandardOpenOption.TRUNCATE_EXISTING);
		
		
		
		
	}
	
	public static void relatorio_Funcionarios() throws SQLException, IOException {
		
		String cabecalho = "Relatório dos Funcionários: \n\n\n";
		String S1 = "Número total de funcionários: ";
		String S2 = "Número de dias do funcionário mais antigo na empresa: ";
		String S3 = "Número de capitães: ";
		String S4 = "Número de motoristas: ";
		String S5 = "Número de maquinistas: ";
		String S6 = "Número de estoquistas: ";
		String S7 = "Média salarial: R$";
		String S8 = "Folha salarial mensal: R$";
		String FIM = "\n\nRelatório gerado dia ";
		
		String R1, R2, R3, R4, R5, R6, R7 , R8, RFIM;
		
		
		R1 = execute_SQL("SELECT count(*) FROM \r\n" + 
				"	Funcionario;");
		
		R2 = execute_SQL("SELECT DATEDIFF(NOW(),  MIN(f.dataContratacao))  FROM Funcionario f;");
		
		R3 = execute_SQL("SELECT count(*) FROM \r\n" + 
				"	Capitao;");
		
		R4 = execute_SQL("SELECT count(*) FROM \r\n" + 
				"	Motorista;");
		
		R5 = execute_SQL("SELECT count(*) FROM \r\n" + 
				"	Maquinista;");
		
		R6 = execute_SQL("SELECT count(*) FROM \r\n" + 
				"	Estoquista;");
		
		R7 = execute_SQL("SELECT AVG(salario) FROM \r\n" + 
				"	Funcionario;");
		
		R8 = execute_SQL("SELECT SUM(salario) FROM \r\n" + 
				"	Funcionario;");
		
		
		LocalDate hoje = LocalDate.now();
		DateTimeFormatter formatadorBarra = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		RFIM = hoje.format(formatadorBarra);
		
		
		
		List<String> lines = Arrays.asList(cabecalho, S1 + R1, S2 + R2, S3 + R3, S4 + R4, S5 + R5,
				S6 + R6, S7 + R7 + ",00", S8 + R8 + ",00", FIM + RFIM);
		 
		Files.write(Paths.get("Relatorio_Funcionarios.txt"),
		                lines,
		                StandardCharsets.UTF_8,
		                StandardOpenOption.CREATE,
		                StandardOpenOption.TRUNCATE_EXISTING);
		
		
		
		
	}
	
	public static void relatorio_Clientes() throws SQLException, IOException {
		
		String cabecalho = "Relatório de Clientes: \n\n\n";
		String S1 = "Número de clientes: ";
		String S2 = "Número de clientes reincidentes: ";
		String S3 = "Média de pedidos por cliente ";
		String S4 = "Porcentagem dos clientes que voltam a empresa: ";
		String FIM = "\n\nRelatório gerado dia ";
		
		String R1, R2, R3, RFIM;
		
		
		R1 = execute_SQL("SELECT count(*) FROM Cliente;\r\n");
		
		R2 = execute_SQL("SELECT count(ncp.nome) FROM (SELECT c.nome, count(p.idCliente_FK) as n_pedidos "
				+ "FROM Cliente c INNER JOIN Pedido p ON c.idCliente_PK = p.idCliente_FK GROUP BY c.nome) as ncp\r\n" + 
				" WHERE ncp.n_pedidos > 1; \r\n");
		
		R3 = execute_SQL_Double("SELECT AVG(n_pedidos) as media FROM (SELECT c.nome, count(p.idCliente_FK) as n_pedidos "
				+ "FROM Cliente c INNER JOIN Pedido p ON c.idCliente_PK = p.idCliente_FK GROUP BY c.nome)\r\n" + 
				" as nome_numeroPedidos;");
		
		Double R4 = (Double.parseDouble(R2)/Double.parseDouble(R1)) * 100;
		
		
		
		LocalDate hoje = LocalDate.now();
		DateTimeFormatter formatadorBarra = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		RFIM = hoje.format(formatadorBarra);
		
		
		
		List<String> lines = Arrays.asList(cabecalho, S1 + R1, S2 + R2, S3 + R3, S4 + R4 + "%",FIM + RFIM);
		 
		Files.write(Paths.get("Relatorio_Clientes.txt"),
		                lines,
		                StandardCharsets.UTF_8,
		                StandardOpenOption.CREATE,
		                StandardOpenOption.TRUNCATE_EXISTING);
		
		
		
		
	}

	private static String execute_SQL(String sql) throws SQLException {
		String R1 = "";
		try(Connection conn = new ConnectionPool().connect()){
			
			try(Statement statement = conn.createStatement()){
				
				
				
				statement.execute(sql);
				
				try(ResultSet result = statement.getResultSet()){
					
					while(result.next()) {
						int resultado = result.getInt(1);
						R1 = Integer.toString(resultado);
						
					}
					
					return R1;
					
				}
				
				
			}
			
		}
	}
	
	private static String execute_SQL_Double(String sql) throws SQLException {
		String R1 = "";
		try(Connection conn = new ConnectionPool().connect()){
			
			try(Statement statement = conn.createStatement()){
				
				
				
				statement.execute(sql);
				
				try(ResultSet result = statement.getResultSet()){
					
					while(result.next()) {
						double resultado = result.getDouble(1);

						resultado = BigDecimal.valueOf(resultado)
						    .setScale(2, RoundingMode.HALF_UP)
						    .doubleValue();
						
						R1 = Double.toString(resultado);
						
					}
					
					return R1;
					
				}
				
				
			}
			
		}
	}

}
