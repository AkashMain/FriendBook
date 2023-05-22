FactoryBot.define do
    factory :user do
      fname { 'Johnny' }
      email { 'john@example.com' }
      password { 'password' }
    end

    factory :post do 
      body {'LOL'}
    end

    factory :comment do 
    end
end