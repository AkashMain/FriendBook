FactoryBot.define do
    factory :user do
      fname { 'Johnny' }
      email { 'john@example.com' }
      password { 'password' }
    end
end