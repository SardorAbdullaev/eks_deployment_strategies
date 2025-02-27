resource "kubernetes_namespace" "udacity" {
  metadata {
    name = local.name
  }
  depends_on = [
    module.project_eks
  ]
}

#resource "kubernetes_service" "blue" {
#  metadata {
#    name      = "blue-svc"
#    namespace = local.name
#    annotations = {
#      "service.beta.kubernetes.io/aws-load-balancer-type"            = "nlb"
#      "service.beta.kubernetes.io/aws-load-balancer-nlb-target-type" = "ip"
#    }
#  }
#  spec {
#    selector = {
#      app = "blue"
#    }
#
#    port {
#      port        = 80
#      target_port = 80
#    }
#
#    type = "LoadBalancer"
#  }
#
#  depends_on = [
#    module.project_eks
#  ]
#}

resource "kubernetes_service" "green" {
  metadata {
    name      = "green-svc"
    namespace = local.name
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type"            = "nlb"
      "service.beta.kubernetes.io/aws-load-balancer-nlb-target-type" = "ip"
    }
  }
  spec {
    selector = {
      app = "green"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }

  depends_on = [
    module.project_eks
  ]
}

resource "kubernetes_service" "grafana-external" {
  metadata {
    name      = "grafana-external"
    namespace = "monitoring"
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type"            = "nlb"
      "service.beta.kubernetes.io/aws-load-balancer-nlb-target-type" = "ip"
    }
  }
  spec {
    selector = {
      "app.kubernetes.io/name"="grafana"
    }

    port {
      port        = 80
      target_port = 3000
    }

    type = "LoadBalancer"
  }

  depends_on = [
    module.project_eks
  ]
}
