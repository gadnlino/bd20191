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
		
		String cabecalho = "Relat�rio de Containers: \n\n\n";
		String S1 = "N�mero total de containers: ";
		String S2 = "N�mero de containers Dispon�veis: ";
		String S3 = "N�mero de containers em uso: ";
		String S4 = "N�mero de containers em manuten��o: ";
		String S5 = "N�mero de containers desmobilizados: ";
		String S6 = "N�mero de containers que passaram da meia-vida: ";
		String S7 = "N�mero de containers no �ltimo ano de utiliza��o: ";
		String FIM = "\n\nRelat�rio gerado dia ";
		
		String R1, R2, R3, R4, R5, R6, R7 , RFIM;
		
		
		R1 = execute_SQL("SELECT count(*) FROM \r\n" + 
				"	Container;");
		
		R2 = execute_SQL("SELECT count(*) FROM \r\n" + 
				"	(SELECT * FROM Container WHERE Container.statusContainer = 'Dispon�vel') as Containers_Disponiveis;");
		
		R3 = execute_SQL("SELECT count(*) FROM \r\n" + 
				"	(SELECT * FROM Container WHERE Container.statusContainer = 'Em uso') as Containers_Disponiveis;");
		
		R4 = execute_SQL("SELECT count(*) FROM \r\n" + 
				"	(SELECT * FROM Container WHERE Container.statusContainer = 'Em manuten��o') as Containers_Disponiveis;");
		
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
		
		String cabecalho = "Relat�rio dos Funcion�rios: \n\n\n";
		String S1 = "N�mero total de funcion�rios: ";
		String S2 = "N�mero de dias do funcion�rio mais antigo na empresa: ";
		String S3 = "N�mero de capit�es: ";
		String S4 = "N�mero de motoristas: ";
		String S5 = "N�mero de maquinistas: ";
		String S6 = "N�mero de estoquistas: ";
		String S7 = "M�dia salarial: R$";
		String S8 = "Folha salarial mensal: R$";
		String FIM = "\n\nRelat�rio gerado dia ";
		
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
		
		String cabecalho = "Relat�rio de Clientes: \n\n\n";
		String S1 = "N�mero de clientes: ";
		String S2 = "N�mero de clientes reincidentes: ";
		String S3 = "M�dia de pedidos por cliente ";
		String S4 = "Porcentagem dos clientes que voltam a empresa: ";
		String FIM = "\n\nRelat�rio gerado dia ";
		
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
