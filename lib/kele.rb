require 'httparty'

class Kele
  include HTTParty
  base_uri "https://www.bloc.io/api/v1"
  def initialize(email, password)
    auth_hash = {email: email, password: password}
    response = self.class.post('/sessions', body: auth_hash)
    @auth_token = response["auth_token"]
  end

end
