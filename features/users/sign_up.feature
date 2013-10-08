Feature: Sign up
	In order to get access to protected section od the site
	As a user
	I want to be able to sign up

	Background:
		Given I am not logged in

	Scenario: User signs up with valid data
		When I sign up with valid user data
		Then I should see a successful sign up message

	Scenario: User signs up with invalid email
		When I sign up with invalid email
		Then I should see an invalid email message

	Scenario: User signs up without password
		When I sign up without password
		Then I should see a missing password missing message

	Scenario: User signs up without password confirmation
		When I sign up without password confirmation
		Then I should see a missing password confirmation message

	Scenario: User signs up with mismatched password and confirmation
		When I sign up with a mismatched password confirmation
		Then I should see a mismatched password message