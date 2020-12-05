# NYTimes

//About The App //
This new york application gets data from the API and fills this data in a table view controller which is divided to cells 
and in each each cell has details about the articles including picture and other data.

// NewyorkTests //

NewyorkTests has 2 simple functions:

func testPeriod: 
detects if PERIOD number if different than “1” , “7” or “30” ( these are the available period). 
By changing the number of PERIOD to 2 for example and we run the NewyorkTests an error will occur.

func testKey: 
just to check the API key. if we try to change the API key  and we run the NewyorkTests an error will occur too. 



// NewyorkUITests //

NewyorkUITests has 2 simple functions:

func testProgressSpinnerIsHiddenOnError:  
during process of retrieving data from the API, a spinner shows, until call finishes. 
If an error occurred during the call (No internet, error in data, etc..), a popup shows with a message, 
and after the user presses on the "OK" button, the spinner must be hidden.
the function testProgressSpinnerIsHiddenOnError checks if the spinner is hidden when the “OK” button is pressed, 
if not it will throw an error when NewyorkUITests is running.
(for testing just command spinner.stopAnimating() in addalert() function)


testSearchMissingCredentialAlertIsShown:
When the user clicks on search button, an alert shows that has an input field and search button, 
after the user clicks on the search, a function is triggered to validate the input if empty or not, 
and shows error if empty. testSearchMissingCredentialAlertIsShown is a function that ensures to show analert if input is empty, and if alert is not shown, an error will occur.
