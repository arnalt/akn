FactoryGirl.define do
  factory :work do
    id 30
    date "28.03.2013"
    week "14"
    day "Montag"
    start_at "07:30"
    end_at "16:00"
    pause "00:30"
    working_hours 8.0
    client_id 1
    user_id 2
    task_id 6
  end
  factory :user do
    id 2
    email "mustermann@example.com"
    password "foobar"
    password_confirmation "foobar"
    firstname "Klaus"
    lastname "Mustermann"
  end
  factory :task do |t|
    t.id 6
    t.name "Task'1001"
    t.description "some task description"
  end
  factory :client do
    id 1
    name "client"
    description "client"
  end
end




def sign_in(user)
  visit login_path

  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  cookies[:remember_token] = user.remember_token
end