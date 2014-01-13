require "spec_helper"

feature "Membeers" do
	
	context "act as member user" do
		before :each do
			@member = create(:free_user1)
			log_in(@member.email, @member.password)
		end

		it "direct to dashboard" do
			visit "/dashboard"
			page.current_path.should eq dashboard_path
		end

		it "should have hello" do
			visit "/dashboard"
			page.should have_content "Hello"
		end
	end

	context "act as guest user" do
		it "cannot visit dashboard" do
			visit "/dashboard"
			page.current_path.should eq new_member_session_path
		end

	end


end
