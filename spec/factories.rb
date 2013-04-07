FactoryGirl.define do
  factory :work do
      id          1
      datum  "28.03.2013"
      kw        "14"
      tag       "Montag"
      von      "07:30"
      bis        "16:00"
      mm      "00:30"
      std       8.0
      client_id    1
      user_id      1
    end
  factory  :user do
    vorname  "Klaus"
    nachname  "Mustermann"
    email "mustermann@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
  end


def sign_in(user)
  visit login_path
  fill_in "Email",       with: user.email
  fill_in "Password",  with: user.password
  click_button "Sign in"
  cookies[:remember_token] = user.remember_token
end