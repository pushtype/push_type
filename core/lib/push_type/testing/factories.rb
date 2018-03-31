require 'factory_bot_rails'

FactoryBot.define do

  sequence :title do |n|
    "Foo Bar #{n}"
  end

  sequence :slug do |n|
    "foo-bar-#{n}"
  end

  factory :node, class: 'PushType::Node' do
    title   'Foo bar'
    slug    { generate :slug }

    factory :published_node do
      status 'published'
    end
  end

  sequence :email do |n|
    "joe-#{n}@example.com"
  end

  factory :user, class: 'PushType::User' do
    name    'Joe Bloggs'
    email   { generate :email }
  end

  factory :asset, class: 'PushType::Asset' do
    file    { Rack::Test::UploadedFile.new(PushType::Core::Engine.root.join('test', 'files/image.png')) }
    factory :image_asset do
    end
    factory :audio_asset do
      file  { Rack::Test::UploadedFile.new(PushType::Core::Engine.root.join('test', 'files/audio.m3u')) }
    end
    factory :video_asset do
      file  { Rack::Test::UploadedFile.new(PushType::Core::Engine.root.join('test', 'files/video.mp4')) }
    end
    factory :document_asset do
      file  { Rack::Test::UploadedFile.new(PushType::Core::Engine.root.join('test', 'files/document.pdf')) }
    end
  end
  
end