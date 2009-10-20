# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_connectiproxy_session',
  :secret      => 'c3de70aaea887b94438108ba4dca82a30081ae248940cf4c822a3d859ab67cc314d3a8c551dd3fc749301ce3e5ea38c9b2a02542cf8d9483df4e5b5b75f4201c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
