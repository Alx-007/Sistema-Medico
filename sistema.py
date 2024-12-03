import mysql.connector
from pyswip import Prolog
import datetime

# Conexión a la base de datos
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="DiagnosticoMedico"
)
cursor = db.cursor()

prolog = Prolog()
prolog.consult("enfermedades.pl")

def registrar_paciente_db(datos_paciente, enfermedad):
    sql = """
        INSERT INTO Pacientes (
            nombre, edad, genero, direccion, ocupacion, estado_civil, enfermedad_diagnosticada, fecha_hora
        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """
    valores = (
        datos_paciente["nombre"], datos_paciente["edad"], datos_paciente["genero"],
        datos_paciente["direccion"], datos_paciente["ocupacion"], datos_paciente["estado_civil"],
        enfermedad, datos_paciente["fecha_hora"]
    )
    cursor.execute(sql, valores)
    db.commit()
    print("Registro guardado en la base de datos.")

def registrar_paciente():
    nombre = input("Nombre completo del paciente: ")
    edad = input("Edad: ")
    genero = input("Género: ")
    direccion = input("Dirección: ")
    ocupacion = input("Ocupación: ")
    estado_civil = input("Estado civil: ")

    paciente = {
        "nombre": nombre,
        "edad": edad,
        "genero": genero,
        "direccion": direccion,
        "ocupacion": ocupacion,
        "estado_civil": estado_civil,
        "fecha_hora": datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    }

    sintomas = input("Ingrese los síntomas del paciente separados por comas: ").lower().split(",")
    sintomas = [s.strip() for s in sintomas]
    resultado = list(prolog.query(f"deducir_enfermedad({sintomas}, E)"))
    enfermedad = resultado[0]['E'] if resultado else "No detectada"

    print(f"La enfermedad diagnosticada es: {enfermedad}")

    registrar_paciente_db(paciente, enfermedad)

def mostrar_registros():
    cursor.execute("SELECT * FROM Pacientes")
    registros = cursor.fetchall()
    print("Registros en la base de datos:")
    for registro in registros:
        print(f"""
        ID: {registro[0]}
        Nombre: {registro[1]}
        Edad: {registro[2]}
        Género: {registro[3]}
        Dirección: {registro[4]}
        Ocupación: {registro[5]}
        Estado Civil: {registro[6]}
        Enfermedad Diagnosticada: {registro[7]}
        Fecha y Hora: {registro[8]}
        """)

# Menu
def mostrar_menu():
    print("*****************************")
    print("Sistema de Diagnóstico Médico")
    print("Alumnos: \nEmiliano Villa Tovar - No° Control: 220110371\nJorge Alejandro Moreno Gonzalez - No° Control:220110354\n ")
    print("*****************************")
    print("1. Solicitar información del paciente")
    print("2. Verificar si existe un síntoma")
    print("3. Verificar si existe una enfermedad")
    print("4. Ver todas las enfermedades")
    print("5. Ver todos los síntomas")
    print("6. Ver de qué síntomas está compuesta una enfermedad")
    print("7. Solicitar síntomas para deducir la enfermedad")
    print("8. Mostrar registros de pacientes")
    print("9. Salir")
    print("*****************************")


def main():
    while True:
        mostrar_menu()
        opcion = input("Seleccione una opción: ")
        if opcion == "1":
            registrar_paciente()
        elif opcion == "2":
            sintoma = input("Ingrese el nombre del síntoma: ").lower()
            resultado = list(prolog.query(f"es_sintoma({sintoma})"))
            if resultado:
                print(f"El síntoma '{sintoma}' existe en el sistema.")
            else:
                print(f"El síntoma '{sintoma}' no existe en el sistema.")
        elif opcion == "3":
            enfermedad = input("Ingrese el nombre de la enfermedad: ").lower()
            resultado = list(prolog.query(f"es_enfermedad({enfermedad})"))
            if resultado:
                print(f"La enfermedad '{enfermedad}' existe en el sistema.")
            else:
                print(f"La enfermedad '{enfermedad}' no existe en el sistema.")
        elif opcion == "4":
            enfermedades = list(prolog.query("enfermedad(E, _)"))
            print("Lista de enfermedades:")
            for e in enfermedades:
                print(f"- {e['E']}")
        elif opcion == "5":
            sintomas = set()
            for resultado in prolog.query("enfermedad(_, S)"):
                sintomas.update(resultado["S"])
            print("Lista de síntomas:")
            for s in sintomas:
                print(f"- {s}")
        elif opcion == "6":
            enfermedad = input("Ingrese el nombre de la enfermedad: ").lower()
            resultado = list(prolog.query(f"enfermedad({enfermedad}, S)"))
            if resultado:
                print(f"Síntomas de '{enfermedad}': {', '.join(resultado[0]['S'])}")
            else:
                print(f"No se encontró la enfermedad '{enfermedad}'.")
        elif opcion == "7":
            sintomas = input("Ingrese los síntomas separados por comas: ").lower().split(",")
            sintomas = [s.strip() for s in sintomas]
            resultado = list(prolog.query(f"deducir_enfermedad({sintomas}, E)"))
            if resultado:
                print(f"La enfermedad más probable es: {resultado[0]['E']}")
            else:
                print("No se pudo deducir una enfermedad con los síntomas proporcionados.")
        elif opcion == "8":
            mostrar_registros()
        elif opcion == "9":
            print("Saliendo del sistema. ¡Gracias!")
            break
        else:
            print("Opción no válida. Intente de nuevo.")

if __name__ == "__main__":
    main()
