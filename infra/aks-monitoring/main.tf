terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.35.0"
    }
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  namespace  = "monitoring"
  create_namespace = true

  values = [<<EOF
    alertmanager:
      enabled: true
    server:
      persistentVolume:
        enabled: true
  EOF
  ]
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = "monitoring"
  depends_on = [helm_release.prometheus]
  
  values = [<<EOF
    persistence:
      enabled: true
    adminPassword: "${var.grafana_admin_password}"
    service:
      type: LoadBalancer
  EOF
  ]
}