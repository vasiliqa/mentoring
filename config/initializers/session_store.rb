# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :cookie_store, key: '_mentoring_session'
# @see: https://github.com/redis-store/redis-rails
Rails.application.config.session_store :redis_store,
  servers: ["redis://redis:6379/0/session"],
  expire_after: 90.minutes,
  key: "_#{Rails.application.class.parent_name.downcase}_mentoring_session",
  threadsafe: false