# IFTTT-Xcode
Receive a notification when Xcode completes a build of your project.

## Features
* Sends a push notification using IFTTT to your phone when a project finishes building
* Notification includes the project name, whether it was a success or failure, and build time
* Only sends a notification if you computer has been idle for 60+ seconds
* Supports multiple projects building at the same time
* Logs build times

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

## Logging
Your username, project name, date, and build time will be logged to `buildlog.csv` for each build.

Using `builds.sh`, you can see the total, average, and longest build times in `buildlog.csv`.

The log can be filtered using the project name and the date.

Examples:

* Build times for every build in the log
> ./builds.sh

* Build times for SomeProject
> ./builds.sh -p SomeProject

* Build times on March 5, 2017
> ./builds.sh -d 2017-03-05

* Build times for SomeProject on March 5, 2017
> ./builds.sh -p SomeProject -d 2017-03-05
