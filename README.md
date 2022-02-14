# Pillager

Management solutions for the modern Viking:
- plan your seagoing voyages by creating "raid" projects
- update & track the details of your projects in real time
- assign Vikings from your team and use chat to discuss winds, waves, and strategies

### Create Profile
![register](https://user-images.githubusercontent.com/76253881/153860749-3d008fd1-bb3e-460c-9c16-6742ca4130d2.gif)


### Sign In
![sign_in](https://user-images.githubusercontent.com/76253881/153860261-84e2c409-f8ac-4a48-8810-31478501517f.gif)


### Create a New Raid
![new_raid](https://user-images.githubusercontent.com/76253881/153859561-6ace88a4-3bca-4333-9c11-e03b2a8ee1fb.gif)

### View, Edit & Delete
![expandable](https://user-images.githubusercontent.com/76253881/153859691-852624cc-dec5-497c-8350-04604881a091.gif)

### Chat With Your Team
![raid_chat](https://user-images.githubusercontent.com/76253881/153859720-fedaacf7-79ac-425b-b5b4-08de569956bb.gif)

### Customize Account Settings
![edit_profile](https://user-images.githubusercontent.com/76253881/153859824-6cf015c0-26e4-4eb9-8f37-fb2189484e01.gif)


## Under the Hood

Pillager is a vaguely viking-themed social project management app. It authenticates users and performs crud operations on a NoSQL database in the cloud. It uses the following technologies:

- Flutter web (front end application)
- Firebase (back end application)
  - email/pwd authentication
  - cloud firestore database
  - single page app hosting
- BLoC pattern state management (via the [flutter_bloc](https://pub.dev/packages/flutter_bloc "flutter_bloc") package)

## Current Project Status
To view the current deployment, click here:
[Pillager Web App](https://pillager-af9ef.web.app/#/)
