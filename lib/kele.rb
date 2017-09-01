require 'httparty'
require 'json'
class Kele
  include HTTParty
  base_uri "https://www.bloc.io/api/v1"
  def initialize(email, password)
    auth_hash = {email: email, password: password}
    response = self.class.post('/sessions', body: auth_hash)
    @auth_token = response["auth_token"]
  end
  def get_me
    response = self.class.get("https://www.bloc.io/api/v1/users/me", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end
  def get_mentor_availability(mentor_id)
    response = self.class.get("https://www.bloc.io/api/v1/mentors/529277/student_availability", headers: { "authorization" => @auth_token })
    JSON.generate(response)
  end
  def get_roadmap(roadmap_id)
    response = self.class.get("https://www.bloc.io/api/v1/roadmaps/31", headers: { "authorization" => @auth_token })
    p response
  end

end
