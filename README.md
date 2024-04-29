# OneSlot
OneSlot is a user-friendly app that streamlines scheduling for groups by helping users identify mutual free times, regardless of their time zones. In this initial version, users input their scheduled events into an in-app calendar. They can also create groups, add members, and view a calendar that highlights times when everyone is free each day, all adjusted to each user's local time zone. This timezone-friendly feature simplifies the process of finding optimal meeting times for all group members, making it easier to coordinate schedules across different regions.

## Table of Contents
- [Main Features](#main-features)
- [Technologies Used](#technologies-used)
- [Services Used](#services-used)
- [Installation](#installation)
- [Contribution Guidelines](#contribution-guidelines)
- [FAQ](#faq)

## Main Features

https://github.com/ahuynh3a/OneSlot/assets/150502695/55da0c42-a43d-4795-8ae8-5ebf3da8c1e5

### Interactive In-App Calendar
Upon signing in, users are greeted with an intuitive in-app calendar. This calendar functions like a conventional one, allowing users to add and manage their events. Days with scheduled events are highlighted with icons for quick visibility, and more details can be accessed by clicking on individual events.

### Collaborative Group Scheduling
Under the "Your Groups" tab in the dashboard dropdown menu, users can create groups and add members. Within each group, users can view a group calendar that displays shared available times, making it easy to identify when everyone is free to meet.

### Overview of Upcoming Events
For users who prefer a list view of their schedule, the "Upcoming Events" tab in the dashboard dropdown menu provides a chronological list of upcoming events, starting with the nearest. This feature helps users stay organized and prepared for future engagements.

### Seamless Time Zone Integration
OneSlot adapts to the geographical diversity of your team by allowing users to set their local time zone. This ensures that the calendar displays events accurately for each user, no matter where they are located, preventing any confusion about timing.


## Limitations

* **No Calendar Integration:** Users currently need to manually input their schedules as OneSlot does not yet support integration with other calendar systems. Future updates will aim to include this feature to streamline event management.
* **Open Access to User Directory:** At present, users can add any OneSlot account holder to their groups. We plan to enhance privacy and control by introducing a feature where users can accept or deny group invitations, improving user experience and security.
* **Limited Notification Options:** Currently, the app may not support customizable notifications for events or group activities. Implementing more personalized notification settings could enhance user engagement and ensure users are better informed about upcoming events or changes.
* **No Recurring Event Feature:** Users might be unable to set recurring events in the calendar, which can be inconvenient for regular meetings or activities. Future releases could include this functionality to improve scheduling efficiency.
* **Lack of Offline Access:** The app may offer limited options for users to customize the appearance or layout of their calendars and group interfaces. Expanding customization options could provide a more personalized and enjoyable user experience.

## Technologies Used
* Rails 7
* Bootstrap 5
* Simple Calendar Gem

## Services Used
* AWS S3
  
## Configuration
To configure your application to use AWS S3 and OpenAI API services, follow these detailed steps:

**1. Generate a Master Key**
If you do not already have a master.key file, you can generate one by running:
```
EDITOR="code --wait" rails credentials:edit
```
This command will open the credentials file in Visual Studio Code (replace "code --wait" with your preferred editor), and a new master.key file will be generated automatically if it does not exist.

**2. Add Service API Tokens**
Inside the opened credentials file, add your API tokens and other sensitive configuration variables in a structured format. For example:
```
aws:
  access_key_id: YOUR_AWS_ACCESS_KEY_ID
  secret_access_key: YOUR_AWS_SECRET_ACCESS_KEY
```
Save and close the file. The changes will be encrypted and saved securely, accessible only via the master.key.

**3. Ensure the Security of the Master Key**
Never commit your master.key or the credentials file to version control. Add the master.key to your .gitignore file to prevent it from being accidentally pushed to your repository:

```
echo 'config/master.key' >> .gitignore
```
## Installation
### Current Main Branch: rails 7 + esbuild
* clone the repository and switch to the main branch
* run the following commands

```
bundle install
rails db:migrate
rake sample_data
bin/dev
```
After running the above commands five users with preset events, groups, and members will be generated. Sign in with:

* Email: ```sally@example.com```
* Password:  ```password```


## Entity Relationship Diagram
<img width="1274" alt="Screenshot 2024-04-26 at 11 49 04 AM" src="https://github.com/ahuynh3a/OneSlot/assets/150502695/1f5ab232-2688-43ab-bcc9-2734d254831c">

## Contribution Guidelines

### Introduction
Thank you for your interest in contributing to OneSlot. This document provides guidelines and instructions on how to contribute to the project.

### How to Contribute

1. **Setup your environment:** Follow the installation instructions above.
2. **Find an issue to work on:** In the Projects tab, check out our issues, at times I may have some issues labeled "good first issue".

### Coding Conventions
We adhere to the Ruby community style guide, and we expect all contributors to follow suit. Here are key conventions specific to our project:

* **Code Style:** Follow the <a href="https://rubystyle.guide/">Ruby Style Guide</a>, which provides detailed guidelines on the coding style preferred by the Ruby community.
  
* **Naming Conventions:**
  - Use ```snake_case``` for variables, methods, and file names.
  - Use ```PascalCase``` for class and module names.
  - Reflect domain concepts accurately in naming. For instance, if you are working within an event within a calendar, prefer names like usesr_event over vague terms like data_entry.

* **Design Principles:** Focus on Domain-Driven Design (DDD):
  - Organize code to reflect the domain model clearly.
  - Use service objects, decorators, and other design patterns that help isolate domain logic from application logic.

* **Testing Conventions:**
  - Write tests for all new features and bug fixes.
  - Use RSpec for testing, adhering to the <a href="https://rspec.rubystyle.guide/">RSpec Style Guide.</a>
  - Ensure test names clearly describe their purpose, reflecting domain-specific terminology.

### Comments and Documentation

* **Comment your code** where necessary to explain "why" something is done, not "what" is done—source code should be self-explanatory regarding the "what".
* **Document methods and classes** thoroughly, focusing on their roles within the domain model, especially for public APIs.

### Version Control Practices
* Commit messages should be clear and follow best practices, such as those outlined in<a href="https://cbea.ms/git-commit/"> How to Write a Git Commit Message.</a>
* Keep commits focused on a single issue to simplify future maintenance and troubleshooting.

### Branch Naming Conventions
Please use the following naming conventions for your branches:
* ```<issue#-description>``` (i.e 31-added-ransack-search)

### Pull Request Process
1. **Creating a Pull Request:** Provide a detailed PR description, referencing the issue it addresses.
2. **Review Process:** PRs require review from at least one maintainer.

### Community and Communication
Join our [Discord] to communicate with other contributors and maintainers.

### Acknowledgment of Contributors
Contributors who make significant contributions will be listed in our [README/CONTRIBUTORS] file.
Thank you for contributing to **OneSlot**!

### FAQ

## AWS S3 Bucket Setup

* To setup your AWS S3 bucket, sign up for an account here: <a href="https://aws.amazon.com/">Sign Up for AWS Account</a>
* For more setup help, see this guide: <a href="https://medium.com/@emmanuelnwright/create-iam-users-and-s3-buckets-in-aws-264e78281f7f">AWS S3 Bucket and IAM User Setup Guide</a>

## Master Key Errors

* Be sure to follow the <a href="https://github.com/amandaag39/vitals?tab=readme-ov-file#configuration">Configuration Instructions</a>if you encounter an issue when setting up the project.

## Ruby Version Errors

* The project is written using Ruby 3.1.1, if you encounter issues upon cloning, make sure you have Ruby version 3.1.1 in your environment.




























