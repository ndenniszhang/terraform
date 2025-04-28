
output "certificate_url" {
  value = acme_certificate.certificate.certificate_url
}

output "account_url_original" {
  value = acme_registration.reg.id
}

output "accout_url_current" {
  value = acme_registration.reg.registration_url
}
