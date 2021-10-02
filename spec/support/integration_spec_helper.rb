module IntegrationSpecHelper

    def login_as_user
        user = FactoryBot.create(:user)
        sign_in user
    end

    def login_as_admin
        user = FactoryBot.create(:user, :admin)
        sign_in user
    end

end

