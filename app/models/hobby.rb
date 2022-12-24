# frozen_string_literal: true

class Hobby < ApplicationRecord
  validates :hobby_name, presence: true, length: { within: 3..50 }

  has_many :account_hobbies, dependent: :destroy
  has_many :account, through: :account_hobbies

  has_many :group_hobbies, dependent: :destroy
  has_many :group, through: :group_hobbies

  def self.new_hobby(params)
    hobby = find_by(hobby_name: params[:hobby_name])
    return hobby if hobby

    new(hobby_name: params[:hobby_name])
  end
end
