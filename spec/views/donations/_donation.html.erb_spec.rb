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

  describe "with comment" do
    before do
      donation.comment = "Hello"

      render partial: "donations/donation", locals: { donation: donation }
    end

    it "shows the comment" do
      expect(rendered).to have_content "Hello"
    end
  end

  describe "anonymous" do
    before do
      donation.is_anonymous = true
      render partial: "donations/donation", locals: { donation: donation }
    end

    it "does not show the user's name" do
      expect(rendered).to_not have_content("Joe Bloggs")
    end

    it "does not show the user's initials" do
      expect(rendered).to_not have_content("JB")
    end
    
    it "says 'Anonymous Donor'" do

      expect(rendered).to have_content("Anonymous Donor")
    end
  end


end

