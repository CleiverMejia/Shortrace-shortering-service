variable "aws_region" {
  description = "Región AWS donde se despliegan los recursos"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefijo común para los nombres de los recursos (e.g. url-shortener)"
  type        = string
  default     = "url-shortener"
}

variable "base_url" {
  description = "URL base del dominio corto (e.g. https://miweb.com)"
  type        = string
}

variable "short_id_length" {
  description = "Longitud del ID aleatorio generado (caracteres)"
  type        = number
  default     = 6
}

variable "common_tags" {
  description = "Mapa de etiquetas aplicadas a todos los recursos"
  type        = map(string)
  default = {
    Project     = "url-shortener"
    Module      = "shorten"
    ManagedBy   = "terraform"
  }
}

output "api_url" {
  value = "${aws_api_gateway_stage.dev.invoke_url}/shorten"
}
