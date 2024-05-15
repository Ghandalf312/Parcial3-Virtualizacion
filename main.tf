provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context = "minikube"
}

# Recurso para la implementación de la aplicación backend
resource "kubernetes_deployment" "pyhton_api" {
  metadata {
    name = "python-api"
    labels = {
      app = "python-api"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "python-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "python-api"
        }
      }

      spec {
        container {
          name  = "python-api"
          image = "ghandalf02/python-api:latest"
          port {
            container_port = 5050
          }
        }
      }
    }
  }
}

# Servicio para exponer la aplicación backend
resource "kubernetes_service" "pyhton_api" {
  metadata {
    name = "python-api-service"
  }

  spec {
    selector = {
      app = "python-api"
    }

    port {
      port        = 5050
      target_port = 5050
    }
  }
}

# Recurso para la implementación de frontend
resource "kubernetes_deployment" "nginx_html" {
  metadata {
    name = "nginx-html"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "nginx-html"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx-html"
        }
      }

      spec {
        container {
          image = "ghandalf02/nginx-html:latest"
          name  = "nginx-html"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# Servicio para exponer aplicacion
resource "kubernetes_service" "nginx_html" {
  metadata {
    name = "nginx-html-service"
  }

  spec {
    selector = {
      app = "nginx-html"
    }

    port {
      port        = 8080
      target_port = 80
    }
  }
}

# Despliegue de MongoDB
resource "kubernetes_deployment" "mongodb" {
  metadata {
    name = "mongodb"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "mongodb"
      }
    }

    template {
      metadata {
        labels = {
          app = "mongodb"
        }
      }

      spec {
        container {
          image = "mongo:4.4"
          name  = "mongodb"

          port {
            container_port = 27017
          }

          volume_mount {
            mount_path = "/data/db"
            name       = "mongo-storage"
          }
        }

        volume {
          name = "mongo-storage"

          empty_dir {}
        }
      }
    }
  }
}

# recurso para exponer el servicio de Mongo
resource "kubernetes_service" "mongodb_service" {
  metadata {
    name = "mongodb-service"
  }

  spec {
    selector = {
      app = "mongodb"
    }

    port {
      port        = 27017
      target_port = 27017
    }
  }
}

