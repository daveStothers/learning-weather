## TechTest by David Stothers

# Approach

Broke the test into tasks and subtasks, based on the requirements:

- Create a list of locations and view to select them on - ideally these would be accessed on an api so as to be live updated
- Create a view to display the weather at a selected location
- Create a class to get the weather (and write appropriate parser tests)
- Integrate the view and class
- Create a view to display the excursions at a selected location
- Store the selected excursions

To stay within the time limit, I have not completed:

- Extensive UI tests
- Networking tests
- Allowing the user to tie an excursion to a day, and display weather for that day
- Sharing the excursions - I would've done this using a popover and the activity view controller
- The optional notification - This could be done with a popover after querying if anything was in the "SavedExcursions" user defaults.

Also of note - the free api I used only allows 5 day forecasting, rather than 7 day unfortunately. Most other data (Locations/Excursion data) is hardcoded and made up

# Use of the app

Coded and executable under Xcode 10.2.
UI was written to display correctly on an iPhone 8 and XR. May not display correctly on larger/smaller devices.

To view a list of locations:
- Click `Select Location`
- Select your location from the scrollable list. 2 buttons will appear

To view the weather in that location:
- Click `View Weather`
- You may need to wait for this to load.

To view excursions:
- Click `View Excursions`
- Select an Excursion, its details will appear below.
- Deselect an excursion by tapping it again.
- If you select multiple excursions, the last one selected will appear below.
- They will be saved and restored when reentering the screen.

To run unit and UI tests, use the standard xcode testing infrastructure (command-u or Product-> Test)

# Notes

I would've preferred to use Appium for the UI tests as it tests as a black box and can be based on ruby.
I would suggest saving the selected excursions online, rather than just in the app and keeping those sourcing in sync with a timestamp system. A database with CoreData would be therefore more appropriate

I would normally use gitflow with appropriate PR reviews but as I'm the only developer for this repository, I have been pushing direct to master
