# Estudio de Servicios de Agua por medio del Muestreo Aleatorio Estratificado (MAE)

**Autor:** Forero Martínez Nelson David  
**Institución:** Universidad Distrital Francisco José de Caldas  
**Facultad:** Facultad de Ciencias y Educación  
**Asignatura:** Análisis Estadístico Utilizando RStudio (Electiva)  
**Docente:** Pedro Rocha Salamanca  

---

## Descripción del Proyecto
Este proyecto de investigación implementa la técnica de **Muestreo Aleatorio Estratificado (MAE)** para realizar un análisis comparativo sobre los costos de servicios públicos de agua que pagan los ciudadanos en cuatro ciudades principales de Colombia (Bogotá, Cali, Medellín y Cartagena).

El objetivo principal es evaluar la precisión del estimador global mediante una asignación óptima que considera tanto el tamaño poblacional como la variabilidad interna y los costos asociados por encuesta en cada estrato.

## Tecnologías Utilizadas
* **R / RStudio:** Procesamiento analítico de la base de datos `gastoH2O.xlsx`, estimación de varianzas y cálculo de la asignación de tamaño muestral.
* **LaTeX (Overleaf):** Composición editorial del informe académico definitivo, graficación matemática e integración de fórmulas.

## Métricas Estadísticas Evaluadas
Dentro del script y el informe técnico adjunto se desarrollan los cálculos automatizados para:
* Estimación de la Media y la Varianza del Estimador Global en el MAE.
* Determinación del tamaño óptimo de muestra $n$ bajo restricciones de costo por estrato.
* Intervalos de Confianza para la media poblacional.
* Estimación del total poblacional, proporciones muestrales y sus respectivas cotas de error.

## Archivos Destacados del Repositorio
* `R_Muestreo_Estratificado_Servicios_de_Agua.R`: Script lógico que automatiza las funciones vectorizadas para procesar los estratos.
* `main.tex`: Código fuente en LaTeX que estructura el reporte académico formal.
* `Muestreo Aleatorio Estratificado Aplicado a Costes de Servicios de Agua.pdf`: Documento final compilado listo para su lectura.
