<<<<<<< HEAD
module IntegrationSpecHelper

    def login_as_user
        sign_in users(:user_account)
    end
    
    def login_as_admin
        sign_in users(:admin_account)
    end

end

=======
# frozen_string_literal: true

module IntegrationSpecHelper
  def login_as_user
    sign_in users(:user_account)
  end

  def login_as_admin
    sign_in users(:admin_account)
  end
end
>>>>>>> 9645f30515eed86ee65f4943cf8cf17dbfec771b
