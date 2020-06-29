require "rails_helper"

RSpec.describe UserFavoriteCause, type: :model do
  subject { described_class.new(user_id: user.id) }

  let(:user) { users(:bob_user) }

  it { should belong_to(:user) }

  it { should validate_uniqueness_of(:user_id).scoped_to(:cause) }
end
