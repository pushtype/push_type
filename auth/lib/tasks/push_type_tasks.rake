require 'highline/import'

namespace :push_type do
  desc 'Create confirmed and authenticated user account'
  task create_user: :environment do
    say 'Creating user. Please answer questions...'

    user = PushType::User.new({
      name:         ask("Full name:\t"),
      email:        ask("Email address:\t"),
      password:     ask("Password:\t") { |q| q.echo = '*' },

      confirmation_sent_at: Time.zone.now,
      confirmed_at:         Time.zone.now,
      confirmation_token:   'Generated account'
    })

    if user.save
      say 'User successfully created'
    else
      say 'Error:'
      user.errors.full_messages.each { |e| say "\t#{e}" }
      say 'Please try again...'
    end
  end
end