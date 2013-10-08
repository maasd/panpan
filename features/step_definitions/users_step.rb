# Utility Method
def create_visitor
	@visitor ||= { :name => "Mac User", :email => "example@example.com", :password => "changeme", :password_confirmation => "changeme"}
end

def find_user
	@user = User.where(:email => @visitor[:email]).first
end

def create_unconfirmed_user
	create_visitor
	delete_user
	sign_up
	visit '/users/sign_out'
end

def create_user
	create_visitor
	delete_user
	@user = FactoryGirl.create(:user, @visitor)
end

def delete_user
	@user ||= User.where(:email => @visitor[:email]).first
	@user.destroy unless @user.nil?
end

def sign_up
	delete_user
	visit '/users/sign_up'
	fill_in "user_name", :with => @visitor[:name]
	fill_in "user_email", :with => @visitor[:email]
	fill_in "user_password", :with => @visitor[:password]
	fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
	click_button "Sign Up"
	find_user
end

def sign_in
	visit '/users/sign_in'
	fill_in "user_email", :with => @visitor[:email]
	fill_in "user_password", :with => @visitor[:password]
	click_button "Sign in"
end

# Given
Given /^I am not logged in$/ do
	visit '/users/sign_out'
end

Given /^I do not exist as a user$/ do
	create_visitor
	delete_user
end

Given /^I exist as a user$/ do
	create_user
end

Given /^I am logged in$/ do
	create_user
	sign_in
end

# When
When /^I sign in with valid credentials$/ do
	create_visitor
	sign_in
end

When /^I return to the site$/ do
	visit '/'
end

When /^I sign in with a wrong email$/ do
	@visitor = @visitor.merge(:email => "wrong@example.com")
	sign_in
end

When /^I sign in with a wrong password$/ do
	@visitor = @visitor.merge(:password => "wrongpassword")
	sign_in
end

When /^I sign out$/ do
	visit '/users/sign_out'
end

# Then
Then /^I see an invalid login message$/ do
	page.should have_content "Invalid email or password."
end

Then /^I should be signed out$/ do
	page.should have_content "Sign Up"
	page.should have_content "Login"
	page.should_not have_content "Logout"
end

Then /^I see a successful login message$/ do
	page.should have_content "Signed in successfully"
end

Then /^I should be signed in$/ do
	page.should have_content "Logout"
	page.should_not have_content "Sign Up"
	page.should_not have_content "Login"
end

Then /^I should see a signed out message$/ do
	page.should have_content "Signed out successfully"
end

When(/^I sign up with valid user data$/) do
  create_visitor
  sign_up
end

Then(/^I should see a successful sign up message$/) do
  page.should have_content "Welcome! You have signed up successfully"
end

When(/^I sign up with invalid email$/) do
  create_visitor
  @visitor = @visitor.merge(:email => "invalid@example")
  sign_up
end

Then(/^I should see an invalid email message$/) do
  page.should have_content "Email is invalid"
end

When(/^I sign up without password$/) do
  create_visitor
  @visitor = @visitor.merge(:password => "", :password_confirmation => "")
  sign_up
end

Then(/^I should see a missing password missing message$/) do
  page.should have_content "Password can't be blank"
end

When(/^I sign up without password confirmation$/) do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

Then(/^I should see a missing password confirmation message$/) do
  page.should have_content "Password doesn't match confirmation"
end

When(/^I sign up with a mismatched password confirmation$/) do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "mismatched")
  sign_up
end

Then(/^I should see a mismatched password message$/) do
  page.should have_content "Password doesn't match confirmation"
end

When(/^I edit my account details$/) do
  click_link "Edit Account"
  fill_in "user_name", :with => "newname"
  fill_in "user_password", :with => "newpassword"
  fill_in "user_password_confirmation", :with => "newpassword"
  fill_in "user_current_password", :with => @visitor[:password]
  click_button "Update"
end

Then(/^I should see an account edited message$/) do
  page.should have_content "You updated your account successfully"
end

When(/^I look at the list of users$/) do
  visit '/'
end

Then(/^I should see my name$/) do
  page.should have_content @user[:name]
end