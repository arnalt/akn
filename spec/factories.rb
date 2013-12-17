FactoryGirl.define do
 to_create do |instance|
    unless instance.save
      raise "Invalid record: " + instance.errors.full_messages.join(", ")
    end
  end
  factory :work do
    date "28.03.2013"
    week "14"
    day "Montag"
    start_at "07:30"
    end_at "16:00"
    pause "00:30"
    working_hours 8.0
    task
    client
    user
  end
  factory :user do
    sequence(:email){ |n| 'email' + n.to_s + '@example.com' }
    password "foobar"
    password_confirmation "foobar"
    firstname "Klaus"
    lastname "Mustermann"
  end
  factory :task do |t|
    sequence(:name){ |n| 'Task name' + n.to_s }
    sequence(:description){ |n| 'Task description ' + n.to_s }
    client
  end
  factory :client do
    sequence(:name){ |n| 'Client name ' + n.to_s }
    sequence(:project){ |n| 'Project name ' + n.to_s }
  end

end




def sign_in(user)
  visit login_path

  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  cookies[:remember_token] = user.remember_token
end
