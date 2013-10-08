Feature: Sign out
	In order to protect my account from unauthorized user
	A signed in user
	Should be able to sign out

	Scenario: User sign out
		Given I am logged in
		When I sign out
		Then I should see a signed out message
		When I return to the site
		Then I should be signed out