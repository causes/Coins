# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_chips_session',
  :secret      => '02b61d6898c28605d36f4c11335e82636f9d8d770b1e7cc3ff513274418ce3007f7839e5d0b4dd8a4c5b9910d4ad244c15dca4d9438fd53b64f8573a50ac55b3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
