require "rails_helper"

RSpec.describe Organization, type: :model do
  it {should have_many(:donations).dependent(:destroy)}

  describe "Searching" do
    before do
      @organization =
          Organization.create(
              name: Faker::Company::name,
              cause: Organization.causes.first.first,
              location: "#{Faker::Address.city}, IL"
          )
    end

    it "return results if there are matches " do
      name_result = PgSearch.multisearch(@organization.name)
      cause_result = PgSearch.multisearch(@organization.cause)
      location_result = PgSearch.multisearch(@organization.location)

      expect(name_result.present?).to be true
      expect(name_result.map(&:searchable).include?(@organization)).to be true
      expect(name_result.first.searchable.name).to eq @organization.name
      allow(@organization).to receive(:cause).and_return("animals")

      search_result_cause = cause_result.first.searchable.cause
      expect(search_result_cause).to eq @organization.cause
      expect(location_result.first.searchable.location).to eq @organization.location
      expect(location_result.first.searchable.id).to eq @organization.id
      expect(name_result.present?).to be true
      expect(name_result.map(&:searchable).include?(@organization)).to be true

      expect(cause_result.present?).to be true
      expect(cause_result.map(&:searchable).include?(@organization)).to be true

      expect(location_result.present?).to be true
      expect(location_result.map(&:searchable).include?(@organization)).to be true
    end

    it "does NOT return results if there are no matches" do
      result = PgSearch.multisearch("Not There")

      expect(result.empty?).to be true
    end
  end
end
