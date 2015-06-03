MyDrive Solutions Challenge for iOS
MyDrive Solutions sales employees travel very often, and they will need an application to assist them with the currency exchange rate for each country they visit. The task is to create an iOS application to assist them with currency conversions.

Requirements / Results

The app should get the latest exchange rates from this endpoint: https://raw.githubusercontent.com/mydrive/code-tests/master/iOS-currency-exchange-rates/rates.json
The user should be able to select which currency to convert from and to.
The app should calculate the exchange rate after the user has selected the "from" and "to" currencies
Write the unit tests wherever you see fit
Code should be uploaded to an online code repository that MyDrive staff can be given access to. e.g. Github, bitbucket or equivalent.
Use as much time you need to create this app. The recommended time is 3 hours
Please let us know how long this task took you.
Bonus / Nice to have

Document the development process for this app (Decisions, libraries, etc).
Demonstrate good practices in source code management.
Offline capabilities.
Example response

GET http://www.mydrivesolutions.com/tests/iOS/currencyTest/api/currencies

Sample response:

{
"conversions": [
{
"from": "USD",
"to": "GBP",
"rate": 0.66
},
{
"from": "USD",
"to": "EUR",
"rate": 0.52
}
]
}
Additional questions
How do you keep up with the latest iOS development practices?
List some of your favourite iOS libraries including a brief description of each.
What are the top 5 tools that you could not normally live without?