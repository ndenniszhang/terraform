output "kubernetes_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.primary.endpoint
  description = "GKE Cluster Host"
}

output "kubernetes_namespace" {
  value       = kubernetes_namespace.app.metadata[0].name
  description = "Kubernetes Namespace"
}

output "kubernetes_service_url" {
  value       = kubernetes_service.app.status.cluster_ip
  description = "The URL of the Kubernetes service"
}

output "persistent_volume_claim" {
  value       = kubernetes_persistent_volume_claim.app_pvc.metadata[0].name
  description = "PVC Name"
}
