-- Migración: agrega a la tabla `contacts` (compartida con el CRM/WhatsApp)
-- las columnas que necesita el formulario de seguros.
-- Ejecutar en: Supabase > SQL Editor
--
-- No se toca name / email / phone / tenant_id / avatar_url / birthday /
-- policy_number / notes / tags / created_at / updated_at / id: son de uso
-- compartido con el resto del sistema (conversations, messages, etc.).
-- El nodo de n8n mapea nombre->name, correo->email, celular->phone y el
-- resto de los campos va directo a las columnas nuevas de abajo.

ALTER TABLE contacts
  ADD COLUMN IF NOT EXISTS numero_identidad           TEXT,
  ADD COLUMN IF NOT EXISTS direccion                   TEXT,
  ADD COLUMN IF NOT EXISTS producto                    TEXT,
  ADD COLUMN IF NOT EXISTS canal_adquisicion           TEXT,

  -- Autos / Moto
  ADD COLUMN IF NOT EXISTS placas                      TEXT,
  ADD COLUMN IF NOT EXISTS modelo                      TEXT,
  ADD COLUMN IF NOT EXISTS marca                       TEXT,
  ADD COLUMN IF NOT EXISTS linea                       TEXT,
  ADD COLUMN IF NOT EXISTS ciudad_circulacion          TEXT,

  -- Hogar
  ADD COLUMN IF NOT EXISTS direccion_inmueble          TEXT,
  ADD COLUMN IF NOT EXISTS tipo_inmueble               TEXT,
  ADD COLUMN IF NOT EXISTS estrato                     TEXT,
  ADD COLUMN IF NOT EXISTS valor_inmueble               NUMERIC,
  ADD COLUMN IF NOT EXISTS metros_cuadrados            NUMERIC,
  ADD COLUMN IF NOT EXISTS anio_construccion           INTEGER,

  -- Vida Individual
  ADD COLUMN IF NOT EXISTS fecha_expedicion_documento  DATE,
  ADD COLUMN IF NOT EXISTS fecha_nacimiento            DATE,
  ADD COLUMN IF NOT EXISTS genero                      TEXT,
  ADD COLUMN IF NOT EXISTS enfermedades_preexistentes  TEXT,
  ADD COLUMN IF NOT EXISTS valor_seguro_deseado        NUMERIC,

  -- Vida Grupo
  ADD COLUMN IF NOT EXISTS nit_empresa                 TEXT,
  ADD COLUMN IF NOT EXISTS nombre_empresa              TEXT,
  ADD COLUMN IF NOT EXISTS codigo_ciiu                 TEXT,
  ADD COLUMN IF NOT EXISTS numero_empleados            INTEGER,
  ADD COLUMN IF NOT EXISTS arl                         TEXT,

  -- Viajes
  ADD COLUMN IF NOT EXISTS destino                     TEXT,
  ADD COLUMN IF NOT EXISTS pais_salida                 TEXT,
  ADD COLUMN IF NOT EXISTS fecha_salida                DATE,
  ADD COLUMN IF NOT EXISTS fecha_regreso               DATE,
  ADD COLUMN IF NOT EXISTS numero_viajeros             INTEGER,
  ADD COLUMN IF NOT EXISTS edades_viajeros             TEXT,

  -- Otros
  ADD COLUMN IF NOT EXISTS descripcion_bien            TEXT,
  ADD COLUMN IF NOT EXISTS valor_aproximado            NUMERIC;

-- Índices útiles para filtrar las solicitudes del formulario
CREATE INDEX IF NOT EXISTS idx_contacts_producto   ON contacts (producto);
CREATE INDEX IF NOT EXISTS idx_contacts_email       ON contacts (email);
