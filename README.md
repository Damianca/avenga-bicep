## Bicep

**Bicep** es un **Lenguaje Específico de Dominio (DSL)** de Microsoft, diseñado para simplificar la **Infraestructura como Código (IaC)** en Azure.

Actúa como una capa de abstracción sobre las complejas plantillas JSON de Azure Resource Manager (ARM), haciendo que el código de infraestructura sea mucho más **legible**, **conciso** y fácil de mantener.

---

## Características Clave

* **Sintaxis Concisa:** Bicep elimina la complejidad del formato JSON (menos llaves, corchetes y comas), lo que reduce la posibilidad de errores y mejora la experiencia del desarrollador.
* **Modularidad:** Permite organizar grandes infraestructuras en **módulos** pequeños y reutilizables. Esto promueve la práctica de "No te Repitas" (*Don't Repeat Yourself* o DRY).
* **Transpilación a ARM:** Bicep no reemplaza a ARM. Cuando se despliega, el código Bicep se **compila** (transpila) directamente en una plantilla JSON de ARM, que es el formato que Azure ejecuta.
* **Integración Nativva:** Tiene soporte de primera clase en Azure CLI, Azure PowerShell y Visual Studio Code (con *IntelliSense* avanzado).

Bicep fue lanzado inicialmente en **mayo de 2020** y alcanzó la **Disponibilidad General (GA)** en **abril de 2021**, convirtiéndose en el estándar de Microsoft para la gestión declarativa de Azure.
