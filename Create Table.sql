/* ===========================================================
   PASO 1 — Crear tablas (estructura base + buenas prácticas)
   En este bloque definimos la estructura mínima necesaria
   para modelar medicamentos y su dosificación en recetas.

   Decisiones de estilo que explicamos a los estudiantes:
   - Usamos nombres en singular (MEDICAMENTO, DOSIS).
   - Prefijos semánticos: "cod_" para claves primarias naturales
     y "id_" para claves foráneas (FK).
   - Tipos de datos y NOT NULL explícitos para dejar claro
     qué atributos son obligatorios.
   - Dejamos las PK/FK para un ALTER posterior, porque así
     facilitamos re-ejecuciones y depuración por bloques.
   =========================================================== */

/* MEDICAMENTO: entidad operativa.
   Aquí definimos las columnas y su intención.
   Aún no declaramos la PK; la agregaremos con ALTER (Paso 2). */
CREATE TABLE MEDICAMENTO (
    cod_medicamento       NUMBER(7)    NOT NULL,   -- Identificador del medicamento. Será la PK (la añadimos con ALTER).
    nombre                VARCHAR2(25) NOT NULL,   -- Nombre corto y obligatorio.
    stock_disponible      NUMBER(3)    NOT NULL,   -- Stock actual (entero pequeño).
    id_tipo_medicamento   NUMBER(3)    NOT NULL,   -- FK: referencia a TIPO_MEDICAMENTO (la creamos en el Paso 2).
    id_via_administra     NUMBER(3)    NOT NULL    -- FK: referencia a VIA_ADMINISTRACION (la creamos en el Paso 2).
);
/* Cómo funciona CREATE TABLE:
   - Oracle crea un objeto tabla con las columnas y tipos declarados.
   - NOT NULL obliga a que el valor sea proporcionado en cada INSERT.
   - Aún no hay integridad referencial; por eso podemos cargar datos
     en cualquier orden mientras no definamos las FK. */

/* DOSIS: detalle que relaciona una RECETA con un MEDICAMENTO.
   Definimos las columnas y su semántica. La PK será compuesta. */
CREATE TABLE DOSIS (
    id_medicamento        NUMBER(7)    NOT NULL,   -- FK a MEDICAMENTO (se define en el Paso 2).
    id_receta             NUMBER(7)    NOT NULL,   -- FK a RECETA (se define en el Paso 2).
    unidades_medicamento  NUMBER(2)    NOT NULL,   -- Cantidad de unidades por toma.
    descripcion_dosis     VARCHAR2(25) NOT NULL,   -- Texto breve (por ejemplo, "cada 8 horas").
    dias_tratamiento      NUMBER(2)    NOT NULL    -- Duración total en días.
);
/* Por qué PK compuesta en DOSIS:
   - El par (id_medicamento, id_receta) identifica un detalle único.
   - Esto evita duplicados del mismo medicamento en la misma receta
     y respeta la semántica de "detalle de receta". */
