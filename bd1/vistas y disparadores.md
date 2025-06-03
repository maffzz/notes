# vistas: tablas virtuales →

```sql
-- crea una vista para los promedios de evaluación de cada album por artista
CREATE VIEW albumEval AS
SELECT album, artista, FLOOR(AVG(eval)) AS prom, COUNT(eval) AS num
FROM evaluacion
GROUP BY album, artista;
```

```sql
SELECT prom
FROM albumEval
WHERE artista="rex"
	    AND album="who cares";
DROP VIEW albumEval;
```
## vistas actualizables →

<aside> ☝ si los valores que no se actualizan en la vista eran llaves o not null en la tabla base, la vista no se puede actualizar
</aside>

```sql
INSERT INTO albumEval VALUES (...);
```
### usos →

- reducir la complejidad de consultas, evitando repeticiones de patrones comunes
- se puede dar acceso a una vista un subconjunto de datos y no a todos los datos
## vistas materializadas →

```sql
CREATE MATERIALIZED VIEW albumEval
SELECT album, artista, FLOOR(AVG(eval)) AS prom, COUNT(eval) AS num
FROM evaluacion
GROUP BY album, artista;
```

```sql
REFRESH MATERIALIZED VIEW albumEval;
```
# disparadores →

<aside> ☝ evento, condición y acción
</aside>

```sql
CREATE TRIGGER serAmigable
AFTER UPDATE OF prom ON albumEval
REFERENCING
	OLD ROW AS tuplaAntigua
	NEW ROW AS tuplaNueva
FOR EACH ROW
	WHEN (tuplaAntigua.prom > tuplaNueva.prom)
	SET tuplaNueva.prom = tuplaAntigua.prom;
```

```sql
CREATE TRIGGER actualizarPM
	AFTER INSERT OR UPDATE ON evaluacion
	REFERENCING NEW ROW AS TN
		FOR EACH ROW
			BEGIN
				IF EXISTS
					(SELECT * FROM albumEval A
					 WHERE A.album = TN.album
								 AND A.artista = TN.artista)
				THEN
					UPDATE albumEval
					SET pm=P.pm, num=P.num
					FROM 
						(SELECT AVG(E.eval) AS pm, COUNT(E.eval) AS num
						 FROM evaluacion E,
						 WHERE E.album = TN.album
									 AND E.artista = Tn.artista) P;
				ELSE
					INSERT INTO albumEval (album, artista, pm, num)
					SELECT E.album, E.artista, 
								 AVG(E.eval) AS pm, COUNT(E.eval) AS num
					FROM evaluacion E
					WHERE E.eval = TN.album AND E.artista = TN.artista
				END IF;
			END; 
```

### disparadores + vistas materializadas →

```sql
--------------------------------------------------------------------------------
CREATE MATERIALIZED VIEW albumEval AS
	SELECT album, artista, FLOOR(AVG(eval)) AS pm, COUNT(eval) as num
	FROM evaluacion
	GROUP BY album, artista;
--------------------------------------------------------------------------------
CREATE FUNCTION updateVMpm() RETURNS TRIGGER AS $$
BEGIN
	REFRESH MATERIALIZED VIEW albumEval;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;
--------------------------------------------------------------------------------
```
# ejercicio →

```sql
CREATE TABLE Lugar(
    idLugar INT PRIMARY KEY,
    zipcode VARCHAR(10) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NOT NULL
);

CREATE TABLE Cliente (
    username VARCHAR(8) PRIMARY KEY,
    password VARCHAR(8) NOT NULL,
    telefono VARCHAR(9) NOT NULL,
    correo VARCHAR(50) NOT NULL,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Paquete (
    idTracker INT PRIMARY KEY,
    estado VARCHAR(10) NOT NULL DEFAULT 'en proceso',
    peso FLOAT NOT NULL,
    alto FLOAT NOT NULL,
    largo FLOAT NOT NULL,
    ancho FLOAT NOT NULL,
    fechaEnvio DATE NOT NULL,
    fechaLlegada DATE NOT NULL,
    idLugarDestino INT REFERENCES Lugar(idLugar) NOT NULL,
    idLugarLlegada INT REFERENCES Lugar(idLugar) NOT NULL,
    username VARCHAR(10) REFERENCES Cliente(username) NOT NULL,
    CHECK (peso > 0),
    CHECK ((alto, largo, ancho) > (0, 0, 0)),
    CHECK (estado IN ('en proceso', 'recibido')),
    CHECK (fechaLlegada > fechaEnvio)
);

ALTER TABLE Cliente
ADD COLUMN idLugar INT REFERENCES Lugar(idLugar) NOT NULL DEFAULT 0;

ALTER TABLE Cliente
ADD COLUMN totalpaquetes INT DEFAULT 0;

SELECT * FROM cliente;

INSERT INTO Lugar (idLugar, zipcode, pais, departamento, ciudad, direccion) VALUES
(1, '15001', 'Perú', 'Lima', 'Lima', 'Av. Arequipa 123'),
(2, '15036', 'Perú', 'Lima', 'San Isidro', 'Calle Los Olivos 345'),
(3, '15067', 'Perú', 'Lima', 'Miraflores', 'Av. Larco 999'),
(4, '11001', 'Perú', 'Ica', 'Ica', 'Jr. Grau 456'),
(5, '20001', 'Perú', 'Piura', 'Piura', 'Av. Sullana 111');
INSERT INTO Cliente (username, password, telefono, correo, nombre, idLugar) VALUES
('carlos1', 'abc12345', '987654321', 'carlos@gmail.com', 'Carlos Ramos', 1),
('luisa22', 'xyz98765', '912345678', 'luisa@hotmail.com', 'Luisa Mendoza', 2),
('mario33', 'pass2468', '923456789', 'mario@yahoo.com', 'Mario Gutiérrez', 3),
('ana4444', 'clave999', '956789123', 'ana@outlook.com', 'Ana López', 4),
('joel555', 'joel4321', '934567891', 'joel@pucp.edu.pe', 'Joel Castillo', 5);
INSERT INTO Paquete (idTracker, estado, peso, alto, largo, ancho, fechaEnvio,
fechaLlegada, idLugarDestino, idLugarLlegada, username) VALUES
(1001, 'recibido', 3.2, 15.0, 20.0, 25.0, '2025-03-01', '2025-03-05', 1, 2, 'carlos1'),
(1002, 'en proceso', 5.5, 30.0, 40.0, 20.0, '2025-02-25', '2025-03-02', 2, 3, 'luisa22'),
(1003, 'recibido', 1.8, 12.0, 18.0, 10.0, '2025-01-10', '2025-01-15', 3, 4, 'mario33'),
(1004, 'en proceso', 7.0, 25.0, 35.0, 22.0, '2025-03-10', '2025-03-14', 4, 5, 'ana4444'),
(1005, 'recibido', 2.4, 14.0, 28.0, 18.0, '2025-03-12', '2025-03-18', 5, 1, 'joel555');

SELECT * FROM PAQUETE;

UPDATE Cliente c
SET totalpaquetes = (
  SELECT COUNT(*)
  FROM Paquete p
  WHERE p.username = c.username AND p.estado = 'recibido');

SELECT * FROM CLIENTE;

CREATE OR REPLACE FUNCTION actualizar_total_paquetes() RETURNS TRIGGER AS $$
BEGIN
  IF NEW.estado = 'finalizado' AND OLD.estado <> 'recibido' 
  THEN
    UPDATE Cliente
    SET totalPaquetes = totalPaquetes + 1
    WHERE username = NEW.username;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_actualizar_total_paquetes
AFTER UPDATE OF estado ON Paquete
FOR EACH ROW
EXECUTE FUNCTION actualizar_total_paquetes();

UPDATE Paquete
SET estado = 'finalizado'
WHERE idTracker = 1002;

SELECT * FROM CLIENTE;
```

---
next: [[dependencia funcional y formas normales]]
tags: [[bd]]