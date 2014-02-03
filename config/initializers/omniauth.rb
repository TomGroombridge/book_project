Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "MRGkZBIRnw7QVQtUbrI9KA", "uEjxc1Qf8HYDgONlJTSvLoiXDY9XuIrNdf4cCRhU4I",
    {
      :secure_image_url => 'true',
      :image_size => 'original',
      :authorize_params => {
        :force_login => 'true',
        :lang => 'pt'
      }
    }
end