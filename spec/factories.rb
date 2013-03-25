FactoryGirl.define do
  factory  :user do
    vorname  "Klaus"
    nachname  "Mustermann"
    email "mustermann@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
 end