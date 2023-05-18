FactoryBot.define do
    factory :user do
      fname { 'John' }
      email { 'john@example.com' }
      password { 'password' }
    end
end