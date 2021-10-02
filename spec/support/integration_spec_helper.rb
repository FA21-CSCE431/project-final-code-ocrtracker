module IntegrationSpecHelper

    def login_as_user
        sign_in users(:user_account)
    end
    
    def login_as_admin
        sign_in users(:admin_account)
    end

end

