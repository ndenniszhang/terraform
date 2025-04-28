output "name" {
  description = "Name of the DNS record"
  value       = cloudflare_dns_record.dns.name
}