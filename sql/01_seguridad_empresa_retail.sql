-- Seguridad de la base de datos empresa-retail-db 

USE `empresa-retail-db`;

-- Procedimientos de consulta para el rol de marta
CREATE PROCEDURE sp_conversiones_por_tipo(IN p_tipo VARCHAR(20))
  SELECT con_id_conversion, con_tipo, con_valor, con_fecha, cliente_cli_id_cliente
  FROM conversion
  WHERE con_tipo = p_tipo;

CREATE PROCEDURE sp_resumen_conversiones()
  SELECT con_tipo, COUNT(*) AS total, SUM(con_valor) AS valor_total
  FROM conversion
  GROUP BY con_tipo;

-- 6. Usuarios
CREATE USER 'ana_crm'@'localhost'         IDENTIFIED BY 'Retail2026!Caja';
CREATE USER 'pedro_mkt'@'localhost'       IDENTIFIED BY 'Retail2026!Stock';
CREATE USER 'marta_auditoria'@'localhost' IDENTIFIED BY 'Retail2026!Admin';

-- 7. Roles
CREATE ROLE rol_ana;
CREATE ROLE rol_pedro;
CREATE ROLE rol_marta;

-- Ana: leer y escribir en cliente e interaccion
GRANT SELECT, INSERT, UPDATE, DELETE ON `empresa-retail-db`.`cliente`     TO rol_ana;
GRANT SELECT, INSERT, UPDATE, DELETE ON `empresa-retail-db`.`interaccion` TO rol_ana;

-- Pedro: maneja canal y campania, de cliente solo puede leer
GRANT SELECT, INSERT, UPDATE, DELETE ON `empresa-retail-db`.`canal`    TO rol_pedro;
GRANT SELECT, INSERT, UPDATE, DELETE ON `empresa-retail-db`.`campania` TO rol_pedro;
GRANT SELECT ON `empresa-retail-db`.`cliente` TO rol_pedro;

-- Marta: solo lee conversion y ejecuta los procedimientos
GRANT SELECT  ON `empresa-retail-db`.`conversion` TO rol_marta;
GRANT EXECUTE ON PROCEDURE `empresa-retail-db`.`sp_conversiones_por_tipo` TO rol_marta;
GRANT EXECUTE ON PROCEDURE `empresa-retail-db`.`sp_resumen_conversiones`  TO rol_marta;

-- Asignar cada rol a su usuario
GRANT rol_ana   TO 'ana_crm'@'localhost';
GRANT rol_pedro TO 'pedro_mkt'@'localhost';
GRANT rol_marta TO 'marta_auditoria'@'localhost';

-- Activar el rol por defecto al iniciar sesión
SET DEFAULT ROLE rol_ana   FOR 'ana_crm'@'localhost';
SET DEFAULT ROLE rol_pedro FOR 'pedro_mkt'@'localhost';
SET DEFAULT ROLE rol_marta FOR 'marta_auditoria'@'localhost';

-- Confirma que estás conectado como root
SELECT CURRENT_USER();


-- Muestra qué rol tiene asignado cada usuario
SELECT * FROM mysql.roles_mapping
WHERE User IN ('ana_crm','pedro_mkt','marta_auditoria');

-- Punto 7: permisos de rol_ana (debe tener SELECT, INSERT, UPDATE, DELETE
-- solo sobre cliente e interaccion)
SHOW GRANTS FOR rol_ana;

-- Permisos de rol_pedro (todo sobre canal y campania, solo SELECT sobre cliente)
SHOW GRANTS FOR rol_pedro;

-- Permisos de rol_marta (SELECT sobre conversion y EXECUTE sobre los procedimientos)
SHOW GRANTS FOR rol_marta;

-- Comprueba que los 2 procedimientos de consulta existen
SHOW PROCEDURE STATUS WHERE Db = 'empresa-retail-db';

-- Revisa los valores del campo con_tipo (Compra, Registro, Suscripcion)
SHOW COLUMNS FROM `empresa-retail-db`.conversion;


-- PETER FERNANDEZ -KEVIN COCA
