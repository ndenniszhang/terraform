
output "certificate_url" {
  value = acme_certificate.certificate.certificate_url
}

output "certificate_pem" {
  value     = acme_certificate.certificate.certificate_pem
  sensitive = true
}

output "private_key_pem" {
  value     = acme_certificate.certificate.private_key_pem
  sensitive = true
}

output "account_url_original" {
  value = acme_registration.reg.id
}

output "accout_url_current" {
  value = acme_registration.reg.registration_url
}
