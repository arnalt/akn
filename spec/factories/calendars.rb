# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :calendar do
    datum "2017-12-28"
    wochentage 1
    jahr 1
    arbeitstag 1
    stunden "9.99"
  end
end
