## Introducción

Este es un proyecto de una aplicación de gestión de hoteles desarrollada en Flutter. La aplicación permite a los usuarios realizar operaciones básicas de creación, lectura, actualización y eliminación de hoteles. Es una herramienta esencial para administrar la información de hoteles y mantenerla actualizada.

## Funcionalidades

- **Listado de Hoteles**: La aplicación muestra una lista de hoteles registrados con detalles básicos como nombre, ubicación y calificación.

- **Creación de Hoteles**: Los usuarios pueden agregar nuevos hoteles proporcionando información como nombre, ubicación, calificación, precio base, descripción y servicios.

- **Actualización de Hoteles**: Se permite la edición de la información de un hotel existente, lo que incluye cambiar cualquiera de los detalles mencionados anteriormente.

- **Eliminación de Hoteles**: Los usuarios pueden eliminar hoteles que ya no son relevantes o están duplicados.

## Capturas de Pantalla

![Captura](https://firebasestorage.googleapis.com/v0/b/examenmoviles-c1e55.appspot.com/o/2023-09-05%2015_31_23-Android%20Emulator%20-%20Pixel_3a_API_28_5554.png?alt=media&token=aaf7c832-48e8-45a3-bf8a-c3011677bda4)
![Captura](https://firebasestorage.googleapis.com/v0/b/examenmoviles-c1e55.appspot.com/o/2023-09-05%2015_31_51-Android%20Emulator%20-%20Pixel_3a_API_28_5554.png?alt=media&token=ebc7e717-38cf-4444-b8f2-01dbbd93621c)
![Captura](https://firebasestorage.googleapis.com/v0/b/examenmoviles-c1e55.appspot.com/o/2023-09-05%2015_32_15-Android%20Emulator%20-%20Pixel_3a_API_28_5554.png?alt=media&token=a41b0fb9-3d22-4c1c-97bc-c51138801935)

## Caracteristicas

- **Firebase Firestore:** Utiliza Firestore de Firebase para almacenar y recuperar datos de hoteles en tiempo real.
- **Firebase Storage:** Almacena imágenes de hoteles en Firebase Storage y las carga en la aplicación.
- **Pantallas Navegables:** Navega entre diferentes pantallas para ver, agregar, editar y eliminar hoteles.
- **Formularios de Edición:** Utiliza formularios para ingresar y editar información detallada del hotel, como nombre, ubicación, calificación, precio base, descripción y servicios.
- **Subida de Imágenes:** Permite a los usuarios cargar imágenes para cada hotel desde su dispositivo y las almacena en Firebase Storage.
- **Validación de Datos:** Realiza validaciones en los formularios para garantizar que los datos ingresados sean correctos.
- **Lista de Hoteles:** Muestra una lista de hoteles con información resumida y proporciona acceso a detalles y opciones de edición/eliminación.
- **Ubicación desde API REST:** La información de ubicación (provincias y ciudades) se obtiene de una API REST que proporciona datos actualizados del Ecuador.

## Requisitos de Instalación

- Asegúrate de tener Flutter y Dart instalados en tu sistema con la versión adecuada para el proyecto. Si no, sigue las [instrucciones de instalación](https://flutter.dev/docs/get-started/install).

- **Versión Flutter:** 3.10.6

- **Versión Dart:** 3.0.6

- Clona este repositorio en tu máquina local.

- Ejecuta `flutter pub get` para obtener las dependencias necesarias.
