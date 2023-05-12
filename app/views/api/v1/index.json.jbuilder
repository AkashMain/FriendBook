json.array! @users do |user|
    json.id user.id
    json.fullname "#{user.fname} #{user.lname}"
    json.email user.email
end