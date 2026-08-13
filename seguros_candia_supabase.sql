-- Tabla principal: recibe todos los campos del formulario
-- Ejecutar en: Supabase > SQL Editor

CREATE TABLE solicitudes (
  id                        UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at                TIMESTAMPTZ DEFAULT NOW(),

  -- Datos personales (siempre presentes)
  nombre                    TEXT        NOT NULL,
  numero_identidad          TEXT        NOT NULL,
  celular                   TEXT        NOT NULL,
  correo                    TEXT        NOT NULL,
  direccion                 TEXT        NOT NULL,
  producto                  TEXT        NOT NULL,
  canal_adquisicion         TEXT,

  -- Autos / Moto
  placas                    TEXT,
  modelo                    TEXT,
  marca                     TEXT,
  linea                     TEXT,
  ciudad_circulacion        TEXT,

  -- Hogar
  direccion_inmueble        TEXT,
  tipo_inmueble             TEXT,
  estrato                   TEXT,
  valor_inmueble            NUMERIC,
  metros_cuadrados          NUMERIC,
  anio_construccion         INTEGER,

  -- Vida Individual
  fecha_expedicion_documento DATE,
  fecha_nacimiento          DATE,
  genero                    TEXT,
  enfermedades_preexistentes TEXT,
  valor_seguro_deseado      NUMERIC,

  -- Vida Grupo
  nit_empresa               TEXT,
  nombre_empresa            TEXT,
  codigo_ciiu               TEXT,
  numero_empleados          INTEGER,
  arl                       TEXT,

  -- Viajes
  destino                   TEXT,
  pais_salida                TEXT,
  fecha_salida               DATE,
  fecha_regreso              DATE,
  numero_viajeros             INTEGER,
  edades_viajeros             TEXT,

  -- Otros
  descripcion_bien           TEXT,
  valor_aproximado            NUMERIC
);

-- Índices útiles para filtrar por producto y fecha
CREATE INDEX idx_solicitudes_producto   ON solicitudes (producto);
CREATE INDEX idx_solicitudes_created_at ON solicitudes (created_at DESC);
CREATE INDEX idx_solicitudes_correo     ON solicitudes (correo);

-- Row Level Security (recomendado en Supabase)
ALTER TABLE solicitudes ENABLE ROW LEVEL SECURITY;

-- Solo el service_role (n8n) puede insertar y leer
CREATE POLICY "n8n puede insertar" ON solicitudes
  FOR INSERT WITH CHECK (true);

CREATE POLICY "n8n puede leer" ON solicitudes
  FOR SELECT USING (true);
