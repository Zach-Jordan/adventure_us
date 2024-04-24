Rails.configuration.stripe = {
  publishable_key: ENV['pk_test_51P8uaqG3PBAJvQWNcKYp6ukaIcNWMBF0ilQPAuxKaxBrcYhZ2lFu1TexYDRRsEhLVpAa9eSvLutmn9dh5sN75H0f003yHqKMYk'],
  secret_key: ENV['sk_test_51P8uaqG3PBAJvQWNSHMuLXTUVDCka6wm2orJCzFw6Q2W5uEI3MLa3jqtWOlkZaE31BxGGokVQ5JrbWw9hmjfzhHt00xW2aUw54']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]