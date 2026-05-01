-- Tabla principal: recibe todos los campos del formulario
-- Ejecutar en: Supabase > SQL Editor

CREATE TABLE solicitudes (
  id                        UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at                TIMESTAMPTZ DEFAULT NOW(),

  -- Datos personales (siempre presentes)
  nombre                    TEXT        NOT NULL,
  numero_identidad          TEXT        NOT NULL,
  fecha_nacimiento          DATE,
  celular                   TEXT        NOT NULL,
  correo                    TEXT        NOT NULL,
  direccion                 TEXT        NOT NULL,
  producto                  TEXT        NOT NULL,

  -- Autos
  placas                    TEXT,
  modelo                    TEXT,
  marca                     TEXT,
  linea                     TEXT,
  ciudad_circulacion        TEXT,

  -- Hogar
  tipo_inmueble             TEXT,
  tenencia                  TEXT,
  valor_inmueble            NUMERIC,
  ciudad_inmueble           TEXT,

  -- Viajes
  pais_origen               TEXT,
  pais_destino              TEXT,
  fecha_salida              DATE,
  fecha_regreso             DATE,
  numero_personas           INTEGER,

  -- Vida Individual
  ocupacion                 TEXT,
  fecha_expedicion_documento DATE,
  pago_mensual              NUMERIC,

  -- Vida Grupo
  nit_empresa               TEXT,
  codigo_ciu                TEXT,
  numero_empleados          INTEGER,
  arl                       TEXT,

  -- Empresariales
  empresa_nombre            TEXT,
  empresa_actividad         TEXT
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
