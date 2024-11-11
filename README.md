### Steps to Run the App
- Clone the repository.
- Open FetchRecipes.xcodeproj in Xcode.
- Select the appropriate simulator or connect your iOS device.
- build and run the app or press Command + R.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

## User Interface and Usability
- Developed clean and user-friendly UI for displaying recipes and cuisines.
- As someone obsessed with customer satisfaction, I chose to focus on the UI (except the details page, due to time constraints :p) 
because that's what the user is concerned with. Not the backend, it's the frontend that will matter the most to the user. 

## Network Handling and Error Management
- Network handling must be robust because this is how the users gets a seamless experience of the app.
As a user of many apps :), I wouldn't want to wait more than 2 seconds for the page to load its contents.
- Also, I wouldn't want to see empty screens if an error has occured, rather beautiful pages explaining what has happened.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
- I spent about 3 hours. I would work on it during breaks in class and after dinner to relax.
- I spent about 30 mins to plan the layout (took inspiration from current Fetch app and a few Food apps), 2 hours coding everything out, 
and about 30 mins on this documentation.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
- I used Kingfisher for Image caching, instead of Custom Image Caching (even-though i thought about it), is because it's really straight-forward and efficient.
Writing custom logic to cache images would have taken additional time and efforts for a feature that Kingfisher handles really well.
- I also decided to not create separate ViewModels for each view, since this was a really small-scale project. So, I implemented simple state management in views directly to avoid 
unneccessary comlpexities.

### Weakest Part of the Project: What do you think is the weakest part of your project?
- I don't really like how the Detail View of each dish looks. But I had a few constraints that I had to work with. I know I can do better ;p.
- Also, I think since I didn't include ViewModels, it might get a little difficult to scale without refactoring.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
- Kingfisher: for image downloading and caching
- Combine: for managing async network calls

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
- I used MockProtocol to create mock network responses, for reliable unit tests.
