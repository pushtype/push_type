FactoryGirl.define do
  factory :confirmed_user, parent: :user do
    confirmation_sent_at  { Time.zone.now }
    confirmed_at          { Time.zone.now }
    confirmation_token    'Generated account'
  end
end