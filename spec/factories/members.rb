# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :free_user1, class: Member do
		sequence(:email){|n| "free_user#{n}@gmail.com"}
		password "password"
		password_confirmation "password"
	end
end
