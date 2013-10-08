FactoryGirl.define do
  factory :user do
    name 'Papan User'
    email 'user@papan.com'
    password 'changeme'
    password_confirmation 'changeme'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end