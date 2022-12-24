# frozen_string_literal: true

module HobbyAdd
  extend ActiveSupport::Concern

  included do
    private

    def hobby_add(model, hobby)
      model.hobbies << hobby unless model.hobbies.find_by(hobby_name: hobby.hobby_name)
    end
  end
end
