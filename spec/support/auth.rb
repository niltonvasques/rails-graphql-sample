def sign_in_as_admin
  admin = build_stubbed(:user, customer: false, agent: true, admin: true)
  ApplicationController.any_instance.stub(:current_user).and_return(admin)
  admin
end

def sign_in_as_customer
  customer = build_stubbed(:user)
  ApplicationController.any_instance.stub(:current_user).and_return(customer)
  customer
end
