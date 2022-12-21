# frozen_string_literal: true

class GroupHobby < ApplicationRecord
  belongs_to :group
  belongs_to :hobby
end
