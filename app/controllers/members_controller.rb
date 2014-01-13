class MembersController < ApplicationController

	before_filter :authenticate_member!

	def dashboard
		@member = Member.find(current_member)
	end

end
