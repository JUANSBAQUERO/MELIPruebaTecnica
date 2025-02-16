
# Mercado Libre Mobile Candidate

Este proyecto es una aplicación desarrollada en Swift utilizando SwiftUI que permite a los usuarios buscar productos en Mercado Libre, visualizar los resultados y ver el detalle de un producto.

## 📱 Características
- **Campo de búsqueda:** Permite a los usuarios ingresar términos de búsqueda y obtener resultados desde la API de Mercado Libre.
- **Visualización de resultados:** Muestra una lista de productos con su imagen, nombre y precio.
- **Detalle del producto:** Presenta información detallada sobre un producto seleccionado, incluyendo su imagen, descripción y precio.
- **Manejo de errores:** Implementación de manejo de errores tanto para el usuario como a nivel de desarrollo.
- **Soporte para rotación de pantalla:** La aplicación mantiene el estado de la vista al rotar la pantalla.

## 🛠 Tecnologías utilizadas
- **Lenguaje:** Swift
- **Framework UI:** SwiftUI
- **Gestión de datos:** URLSession para consumo de API REST
- **Arquitectura:** MVVM (Model-View-ViewModel)
- **Manejo de errores:** Logs y mensajes de error para una mejor experiencia de usuario
- **Testing:** Pruebas unitarias con XCTest

## 🔧 Instalación y ejecución
1. Clonar este repositorio:
   ```sh
   git clone https://github.com/JUANSBAQUERO/MELIPruebaTecnica.git
   ```
2. Abrir el proyecto en Xcode:
   ```sh
   cd MELIPruebaTecnica
   open meli.xcodeproj
   ```
3. Compilar y ejecutar en el simulador o dispositivo real.

## 📡 Consumo de API
La aplicación consume la API pública de Mercado Libre para obtener información de productos.
- **Búsqueda de productos:**
  ```sh
  GET https://api.mercadolibre.com/sites/MLA/search?q=iphone
  ```
- **Productos recomendados**
  ```sh
  GET https://api.mercadolibre.com/sites/MLA/search?category=
  ```

## 🛡️ Manejo de errores
- **Errores de conexión:** Se notifica al usuario cuando no hay conexión a Internet.
- **Errores en la API:** Se manejan respuestas HTTP y se presentan mensajes adecuados al usuario.
- **Validaciones de entrada:** Se evita la ejecución de búsquedas vacías o inválidas.

## 🧪 Pruebas
Se implementaron pruebas unitarias con XCTest para garantizar la calidad del código y evitar errores en la lógica de negocio.
- Test de ViewModels
- Test de decodificación de JSON
- Test de llamadas a la API simuladas

## 📌 Consideraciones adicionales
- **Memoria:** Uso eficiente de memoria evitando fugas.
- **Legibilidad:** Código limpio y documentado siguiendo buenas prácticas.
- **Experiencia de usuario:** Diseño fluido y responsivo para distintos dispositivos.

## 📜 Licencia
Este proyecto es de código abierto y se distribuye bajo la licencia MIT.