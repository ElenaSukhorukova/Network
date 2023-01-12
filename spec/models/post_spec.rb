# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post do
  let(:post) { create(:post) }

  it 'returns post\'s body' do
    expect(post.body).to eq('Post\'s body')
    expect(post.body).to be_an_instance_of(String)
  end

  describe 'validation' do
    it 'returns true for the post\'s body' do
      expect(post.body.present?).to be true
    end

    it 'returns true for the invalid post' do
      post.body = Faker::Alphanumeric.alpha(number: 2)
      expect(post.invalid?).to be true
    end
  end

  describe 'association' do
    it 'belongs an account' do
      expect(post.author_post).to be_an_instance_of(Account)
    end

    it { is_expected.to have_many :comments }
    it { is_expected.to have_many_attached(:images) }
  end
end
