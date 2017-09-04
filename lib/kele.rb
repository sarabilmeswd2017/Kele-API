require 'httparty'
require 'json'
require './lib/roadmap'
class Kele
  include HTTParty
  include Roadmap
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

  def get_messages(page_number = 1)
    response = self.class.get("https://www.bloc.io/api/v1/message_threads?page=#{page_number}", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, subject, stripped_text)
    options = {
      body: {
        "sender": sender,
        "recipient_id": recipient_id,
        "subject": subject,
        "stripped-text": stripped_text
     },
     headers: { "authorization" => @auth_token }
   }
    response = self.class.post("https://www.bloc.io/api/v1/messages", options)
    JSON.parse(response.body)
  end

  def create_submissions(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollement_id)
    options = {
      body: {
        "checkpoint_id": checkpoint_id,
        "assignment_branch": assignment_branch,
        "assignment_commit_link": assignment_commit_link,
        "comment": comment,
        "enrollement_id": enrollement_id
      },
      headers: { "authorization" => @auth_token }
    }
    response = self.class.post("https://www.bloc.io/api/v1/checkpoint_submissions", options)
    JSON.parse(response.body)
  end
end
