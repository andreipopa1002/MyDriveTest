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




Response:
I've spent about two days to complete this task. The algorithm that is doing the conversions is not optimal, and will not find the best conversion rate, in order to achieve that it will need to be improved.

I've decided to use AFNetworking to interact with the web api because it is the most heavily tested third party framework and makes working with REST APIs easier.
For the conversion algorithm I've decided to go for a in depth recursive approach that will go towards the end of the possible path and see if it is a valid.

Additional questions
How do you keep up with the latest iOS development practices?
I try to keep up with the latest iOS development practices by attending various meetups like NSLondon, Swift London, watch the WWDC videos and read the blog post NSHipster.

List some of your favourite iOS libraries including a brief description of each.
    AFNetworking - makes interacting with the network a lot easier 
    Fabric - complete solution for crash reporting, beta distribution analytics and some other features that I did not, yet, had the chance to use. 
What are the top 5 tools that you could not normally live without?
    SourceTree
    Kdiff3
    Pixelstick
    TotalTerminal
    Alcatraz.io

    