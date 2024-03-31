# Unislot - v1
Unislot(v1) simplifies scheduling for groups of people by enabling users to pinpoint mutual free times. In this first version, users input their own schedules into a personal calendar within the app. Users can create and join groups, where they can share their schedules and access a calendar that consolidates other members of the group's schedules. This feature effortlessly highlights shared available slots, streamlining the process of finding an ideal meeting time for all group members.

## Table of Contents
- Features
- Limitations
- Technologies Used
- Installation

## Main Feature

### Add schedule to personal calendar
Once users sign up, they can start adding their schedule to their personal calendar by clicking new event.
### Create Group
Users can create a group and add other users.
### View Consolidated Calendar
Once a group is established, every user in the group will be  able to see a consolidated calendar.
## Limitations

Version 1 of the app comes with a number of constraints. A notable limitation is the automatic consolidation of a user's schedule upon being added to a group, without an opt-in choice. A key stretch goal for future updates is to enhance privacy by introducing a feature that enables users to decide whether they wish to join a group upon invitation. This will ensure users have control over sharing their schedule with group members.

## Technologies Used
- Rails 7
- Bootstrap 5
  
## Installation
To install and run, please use the following commands:
```
bundle install
rails db:create
rails db:migrate
bin/dev

```
















