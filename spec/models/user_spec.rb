# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'association' do
    it { is_expected.to have_one :account }
  end
end
