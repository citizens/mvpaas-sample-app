require 'openssl'
require 'jwt'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

# Generate a PEM key for testing
def generate_pem
  OpenSSL::PKey::RSA.generate(2048)
end

# Geneate a JWT for testing
def generate_jwt(pem_key, expiration = nil)
  payload = {
    'sub': 123,
    'username': 'mail@example.com',
    'exp': expiration || Time.now.to_i + 4 * 3600
  }
  JWT.encode(payload, pem_key, 'RS256')
end

# Set the MVPaaS URL (for login redirection)
ENV['MVPAAS_URL'] = 'https://example.com'
