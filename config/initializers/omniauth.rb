Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, '9efa312c3919e0147623', '6608695cb6fd0b0f85db9d6a992c635b1f67e8ed'
end
