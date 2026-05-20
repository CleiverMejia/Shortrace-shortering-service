# Shortrace Shortening Service

Servicio de acortador de URLs basado en AWS Lambda, API Gateway y DynamoDB.

## Descripción

Este proyecto implementa un servicio de acortamiento de URLs con una arquitectura simple:

- `app/src/handler.ts`: punto de entrada AWS Lambda.
- `app/src/application/use-cases/shorten-url.ts`: caso de uso que genera el código corto y guarda la URL original.
- `app/src/domain/entities/short-url.ts`: entidad de dominio `ShortUrl`.
- `app/src/domain/services/short-code-generation.ts`: generador aleatorio de códigos cortos.
- `app/src/infrastructure/database/dynamodb-url-repository.ts`: repositorio que persiste en DynamoDB.
- `terraform/`: infraestructura como código para desplegar la API Gateway, Lambda y DynamoDB.

## Arquitectura

1. El endpoint HTTP POST `/shorten` recibe un cuerpo JSON con `url`.
2. Lambda parsea el body y ejecuta el caso de uso `ShortenUrl`.
3. Se genera un código corto aleatorio y se persistente el par `{ shortCode, originalUrl }` en DynamoDB.
4. Lambda responde con la URL corta construida usando `BASE_URL` y el código corto.

## Requisitos

- Node.js
- npm
- Terraform

## Dependencias del servicio

Las dependencias del proyecto están en `app/package.json`:

- `@aws-sdk/client-dynamodb`
- `@aws-sdk/lib-dynamodb`
- `esbuild`
- `@types/node` (dev)

## Comandos de desarrollo

Desde la carpeta `app`:

```bash
cd app
npm install
npm run build
```

Esto generará el archivo `app/dist/handler.js` que se usa para el despliegue Lambda.

## Despliegue con Terraform

Desde la carpeta raíz del proyecto:

```bash
cd terraform
terraform init
terraform apply
```

### Variables importantes

- `aws_region`: región AWS (por defecto `us-east-1`).
- `project_name`: prefijo para los recursos.
- `base_url`: URL base para las URLs cortas, por ejemplo `https://miweb.com`.
- `short_id_length`: longitud del código corto (por defecto `6`).

Terraform también expone la salida:

- `api_url`: URL invocable del endpoint `/shorten`.

## Configuración de Lambda

La función Lambda usa estas variables de entorno:

- `DYNAMODB_TABLE`: nombre de la tabla DynamoDB.
- `BASE_URL`: dominio base para la URL corta.
- `ID_LENGTH`: longitud del identificador corto.

## Consumo de la API

Realiza una petición POST a `/shorten` con JSON:

```json
{
  "url": "https://ejemplo.com"
}
```

Respuesta exitosa:

```json
{
  "shortUrl": "https://miweb.com/abc123"
}
```
