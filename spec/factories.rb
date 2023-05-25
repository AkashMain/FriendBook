FactoryBot.define do
    factory :user do

      # transient do 
      #   # admin {''}
      #   capitalize
      # end
      # user nil
      fname { 'Johnny' }
      email { 'john@example.com' }
      password { 'password' }

      # after(:create) do |user, evaluator|
      #   user.fname.upcase! if evaluator.capitalize
      # end

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

#trait :courses_with 