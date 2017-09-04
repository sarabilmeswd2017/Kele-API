require 'httparty'
require 'json'
#require 'lib/roadmap'
class Kele
  include HTTParty
  #include Roadmap
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
    response
    JSON.parse(response.body)
  end
  def get_checkpoint(checkpoint_id)
    response = self.class.get("https://www.bloc.io/api/v1/checkpoints/" + checkpoint_id.to_s, headers: { "authorization" => @auth_token })
    response
    JSON.parse(response.body)
  end

  def get_messages(page_number = 1)
    response = self.class.get("https://www.bloc.io/api/v1/message_threads", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, token = "762d2d62-6e11-45c0-b265-7ae073b59304", subject, stripped_text)
    response = self.class.get("https://www.bloc.io/api/v1/messages", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end
end
