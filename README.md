# IFTTT-Xcode
Receive a notification when Xcode has finished building your project. 

## Features
* Receive a push notification to your phone when the project build is complete.
* Notification indicates whether the build was successful or failed.
* Shows how long it took to build the project in the notification.

## Setup
### Creating the Applet on [IFTTT](https://ifttt.com)
1. Choose the `Maker` service for *this*
2. Select `Receive a web request`
  * Set Event Name field to: `Xcode`
3. Choose the `Notification` service for *that*
4. Select `Send a notification`
5. Set Notification field to: `{{EventName}}: {{Value1}} - {{Value2}} [{{Value3}}]`
6. Give it a name, like so `If Maker Event "Xcode", then send a notification`

[Applet Configuration Example](https://github.com/loganisitt/IFTTT-Xcode/blob/master/Applet%20Configuration.png)

### Configure Xcode
1. Clone/Download this Repo
2. Replace KEY with you Maker Key in `xcode_finished.sh`
  * Maker Key can be found in the [Maker Settings](https://ifttt.com/services/maker/settings)
  * The key is the last part of URL
3. In `Xcode -> Preferences -> Behaviors -> Build -> Starts`
  * Enable Run and Choose `xcode_started.sh` script
4. In `Xcode -> Preferences -> Behaviors -> Build -> Succeeds`
  * Enable Run and Choose `xcode_finished.sh` script
5. In `Xcode -> Preferences -> Behaviors -> Build -> Fails`
  * Enable Run and Choose `xcode_finished.sh` script
