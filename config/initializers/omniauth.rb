Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['763881975103-0306ukvav9hnvpkb834jjlcjq89uvuo3.apps.googleusercontent.com'], ENV['MfqjvNVMFlIX0A3j1pbEe5h6']
end