# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_simpleclouding_session',
  :secret      => '56b8d17a8377c5fe9215eb508b8f04e422680111881853961e597b95185ca15e33c954a72c6563730aa6b4261b7ff9bf2de5246bc204db253670e285d64d08aa'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
