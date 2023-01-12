# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment do
  let(:comment) { create(:comment) }

  it 'returns comment\'s body' do
    expect(comment.body).to eq('Comment\'s body')
    expect(comment.body).to be_an_instance_of(String)
  end

  describe 'validation' do
    it 'returns true for the post\'s body' do
      expect(comment.body.present?).to be true
    end
  end

  describe 'association' do
    it 'belongs an account' do
      expect(comment.author_comment).to be_an_instance_of(Account)
    end

    it 'belongs a post' do
      expect(comment.commentable).to be_an_instance_of(Post)
    end
  end
end
