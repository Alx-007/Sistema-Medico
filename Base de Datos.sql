CREATE DATABASE DiagnosticoMedico;

USE DiagnosticoMedico;

CREATE TABLE Pacientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  edad INT,
  genero VARCHAR(10),
  direccion VARCHAR(255),
  ocupacion VARCHAR(100),
  estado_civil VARCHAR(50),
  enfermedad_diagnosticada VARCHAR(100),
  fecha_hora DATETIME
);
