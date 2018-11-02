require "rails_helper"

describe "donations/_donation.html.erb" do 
  let (:donation) {
    FactoryBot.build_stubbed(:donation,
                             first_name: "Joe",
                             last_name: "Bloggs",
                             amount: 10
                            )
  }
  describe "default" do
    before do
      render partial: "donations/donation", locals: { donation: donation }
    end

    it "shows the donor name" do
      expect(rendered).to have_content "Joe Bloggs"
    end

    it "shows the amount" do
      expect(rendered).to have_content "£10"
    end
  end


end

