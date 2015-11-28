# Eventerator
Event Session Rating App based on a simple schema of events, sessions, and rating batches. The schema is implemented in Salesforce as a backend with the app using the Salesforce Mobile SDK for auth and CRUD operations, plus SwiftyJSON for elegant JSON handling.

![reference app overview](https://github.com/quintonwall/Eventerator/blob/master/schema.png?raw=true)

Eventerator is designed to allow multiple docents to stand at the exit of session holding the app on an ipad, and allow departing audience members to quickly and easily tap a 1-5 rating. Because there will be multiple docents per session, eventerator persists everying locally using core data, and syncs to the cloud as related items, or batches, to the session record in Salesforce. By storing everying in core data, Eventerator can work offline in venues where wifi is poor, and also avoids the issue of lost session ratings should a crash occur, or the docent incorrectly exists the app.

The following list of enhancements are planned:

- Clean up UI and add better graphics, color schemes etc.
- Implement per app stats: all time ratings collected, time open etc.
- Update settings to allow further configuration options.
