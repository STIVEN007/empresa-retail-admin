-- Selecciona la base y muestra el usuario y rol activo
-- ANA_Crm
USE `empresa-retail-db`;
SELECT CURRENT_USER(), CURRENT_ROLE();

-- DEBE FUNCIONAR: ana puede leer clientes
SELECT * FROM cliente;

-- DEBE FUNCIONAR: ana puede leer interacciones
SELECT * FROM interaccion;

-- DEBE FUNCIONAR: ana puede modificar clientes
-- (asigna el mismo valor, así no cambia ningún dato)
UPDATE cliente SET cli_nombre = cli_nombre WHERE cli_id_cliente = 1;




-- PEDRO_Mkr
-- Selecciona la base y muestra el usuario y rol activo
USE `empresa-retail-db`;
SELECT CURRENT_USER(), CURRENT_ROLE();

-- DEBE FUNCIONAR: pedro gestiona canales
SELECT * FROM canal;

-- DEBE FUNCIONAR: pedro gestiona campañas
SELECT * FROM campania;

-- DEBE FUNCIONAR: pedro puede ver clientes
SELECT * FROM cliente;




-- CONEXION MARTA AUDITORIA
-- Selecciona la base y muestra el usuario y rol activo
USE `empresa-retail-db`;
SELECT CURRENT_USER(), CURRENT_ROLE();

-- DEBE FUNCIONAR: marta puede ver conversiones
SELECT * FROM conversion;

-- DEBE FUNCIONAR: procedimiento con el resumen por tipo
CALL sp_resumen_conversiones();

-- DEBE FUNCIONAR: procedimiento que filtra por tipo
-- (cambia 'Compra' por un valor real de tu ENUM si sale vacío)
CALL sp_conversiones_por_tipo('Compra');



