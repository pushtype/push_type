module PushType
  module Admin
    class AssetsTest < ActiveSupport::TestCase

      let(:assets) { PushType::Admin::Assets.new }
      
      it { assets.javascripts.must_be_instance_of Array }
      it { assets.stylesheets.must_be_instance_of Array }

      describe '#<<' do
        before(:all) { assets.javascripts << 'foo' }
        it { assets.javascripts.must_include 'foo' }
      end

      describe '#+=' do
        before(:all) { assets.stylesheets += ['bar', 'baz'] }
        it { assets.stylesheets.must_include 'bar' }
        it { assets.stylesheets.must_include 'baz' }
      end

      describe '#register' do
        before(:all) { assets.register 'mylib' }
        it { assets.javascripts.must_include 'mylib' }
        it { assets.stylesheets.must_include 'mylib' }
      end

    end
  end
end