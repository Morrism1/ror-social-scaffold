require 'rails_helper'
require 'capybara/rspec'

RSpec.describe Comment, type: :model do
  context 'Comment associations tests' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  context 'validation tests' do
    it "Shouldn't save if there's no content" do
      e = Comment.new
      expect(e.save).to eq(false)
    end

    it "Shouldn't save if the content is more than 200 characters" do
      descpt = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
       In consequat auctor arcu, et blandit orci malesuada et.
       Orci varius natoque penatibus et magnis dis parturient montes,
       nascetur ridiculus mus.
       Vestibulum ante ipsum primis in faucibus orci luctus et
       ultrices posuere cubilia curae;
       Pellentesque malesuada felis nec massa rutrum varius.
       Proin in odio accumsan, pretium diam in,
       convallis tellus.'
      e = Comment.new(user_id: 1, post_id: 1, content: descpt)
      expect(e.save).to eq(false)
    end
  end
end
