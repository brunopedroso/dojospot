# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dojohub_session',
  :secret      => 'bfdc931490ec4ce46baf510d3ee454338ce4898afa6280d9757a85ecedf07613f4d643b1a6ac67982b185435db14ed1f5184e57186c513076cb3096835ff9e9d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
