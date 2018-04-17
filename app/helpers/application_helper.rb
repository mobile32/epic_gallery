module ApplicationHelper
  def full_name(user = nil)
    user.first_name.to_s + ' ' + user.last_name.to_s
  end

  def oauth_provider_name(provider)
    case provider
    when :google_oauth2
      'Google'
    else
      OmniAuth::Utils.camelize(provider)
    end
  end
end
