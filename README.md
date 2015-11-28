# Eventerator
Event Session Rating App based on a simple schema of events, sessions, and rating batches. The schema is implemented in Salesforce as a backend with the app using the Salesforce Mobile SDK for auth and CRUD operations, plus SwiftyJSON for elegant JSON handling.

![reference app overview](https://github.com/quintonwall/Eventerator/blob/master/schema.png?raw=true)

Eventerator is designed to allow multiple docents to stand at the exit of session holding the app on an ipad, and allow departing audience members to quickly and easily tap a 1-5 rating. Because there will be multiple docents per session, eventerator persists everying locally using core data, and syncs to the cloud as related items, or batches, to the session record in Salesforce. By storing everying in core data, Eventerator can work offline in venues where wifi is poor, and also avoids the issue of lost session ratings should a crash occur, or the docent incorrectly exists the app.

The following list of enhancements are planned:

- Clean up UI and add better graphics, color schemes etc.
- Implement per app stats: all time ratings collected, time open etc.
- Update settings to allow further configuration options.

## Getting Started

### Install the Eventerator Schema
Install the Eventerator schema into your instance of Salesforce using ![this unmanaged package](https://login.salesforce.com/packaging/installPackage.apexp?p0=04tG0000000TcQz).

###Create a Connected App Endpoint
Within Salesforce Setup, navigate to Create->Apps->Connected Apps, and click New. Give your app a name, contact email, and check API(Enable OAuth Settings).
For the OAuth settings set the callback url to mobile://success, and the Manage and access your data(api) permission. Then save.
Once your app has been saved, copy the consumer key to the clipboard. We will need that in a minute to configure our app.

###Configure the app
Clone this repo and open Eventerator.xcworkspace in XCode. Navigate to AppDelegate.swift and replace the consumer key with the value from your clipboard. Save your change, and you are ready to go! Just remember to add some Sessions to your app via Salesforce. Eventerator does not provide the ability to create new sessions from the mobile app, only add ratings to existing session.
