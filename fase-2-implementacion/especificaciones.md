# Fase 2: Implementación Física y Seguridad

En esta etapa se procede a la creación del esquema físico en el motor MySQL, integrando la lógica de negocio y las políticas de acceso requeridas por la aerolínea.

## Objetivos de Implementación

* **Integridad de Datos:** Creación de tablas respetando claves primarias compuestas y restricciones de integridad referencial.
* **Seguridad de Acceso:** Configuración de tres perfiles de usuario diferenciados (`admin`, `empleado` y `cliente`) con permisos granulares.
* **Lógica de Consultas:** Desarrollo de una vista calculada (`vuelos_disponibles`) para la visualización de disponibilidad en tiempo real, integrando la lógica de sobreventa (overbooking).
* **Protección de Credenciales:** Implementación de almacenamiento de contraseñas mediante funciones de hash MD5.

## Entregables Técnicos

La resolución se compone de dos scripts principales:

1. **`vuelos.sql`**: Contiene la secuencia de sentencias para la creación de la base de datos, tablas, vistas y gestión de usuarios.
2. **`datos.sql`**: Incluye una carga inicial de datos de prueba para realizar consultas significativas y validar la integridad del modelo.

## Verificación de Calidad

Una vez creada la base de datos, la estructura es sometida a un proceso de validación mediante un programa **`.jar` (verificar)** proporcionado por la cátedra. 

Este software realiza un análisis exhaustivo sobre la estructura creada para asegurar que cumpla estrictamente con el modelo relacional propuesto y las reglas de integridad definidas.
