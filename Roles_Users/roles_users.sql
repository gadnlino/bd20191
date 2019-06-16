DROP ROLE IF EXISTS 'remote_mysql_dev';
CREATE ROLE 'remote_mysql_dev';
GRANT ALL ON remote_mysql.* TO 'remote_mysql_dev';

DROP ROLE IF EXISTS 'remote_mysql_read';
CREATE ROLE 'remote_mysql_read';
GRANT SELECT ON remote_mysql.* TO 'remote_mysql_read';

DROP ROLE IF EXISTS 'remote_mysql_write';
CREATE ROLE 'remote_mysql_write';
GRANT SELECT,UPDATE,DELETE ON remote_mysql.* TO 'remote_mysql_write';

CREATE USER IF NOT EXISTS dev@localhost IDENTIFIED BY 'dev$$dev';
GRANT 'remote_mysql_dev' TO dev@localhost;

CREATE USER IF NOT EXISTS cliente@localhost IDENTIFIED BY 'cliente$$cliente';
GRANT 'remote_mysql_read' TO cliente@localhost;

CREATE USER IF NOT EXISTS funcionario@localhost IDENTIFIED BY 'funcionario$$funcionario';
GRANT 'remote_mysql_write' TO funcionario@localhost;

CREATE USER IF NOT EXISTS seguradora@localhost IDENTIFIED BY 'seguradora$$seguradora';
GRANT 'remote_mysql_read' TO seguradora@localhost;

CREATE USER IF NOT EXISTS gerente@localhost IDENTIFIED BY 'gerente$$gerente';
GRANT 'remote_mysql_write' TO gerente@localhost;
