class AuthorizationHelper

  def self.can_edit_request(request, user)
    user.agent? or request.user_id == user.id
  end

end
