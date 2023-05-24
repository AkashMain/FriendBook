FactoryBot.define do
    factory :user do
      fname { 'Johnny' }
      email { 'john@example.com' }
      password { 'password' }

      trait :admin do                    #admin_user = FactoryBot.create(:user, :admin)
        role {admin}
      end

      trait :active do 
        status {active} 
      end
    end

    factory :post do 
      body {'LOL'}
    end

    factory :comment do 
      content {'OLA'}
    end
end


# trait
# child factorie