# EventForce Management System

## Project Overview

EventForce Management System is a Salesforce-based Event Management CRM developed to manage event planning and operations in a centralized platform.

The system helps manage clients, events, vendors, venues, and feedback while automating important business processes such as event reminders, cancellation approvals, venue availability, and prevention of double bookings.

The project was developed and tested in a Salesforce Developer Edition environment.

---

## Objectives

The main objectives of the EventForce Management System are:

- Manage event details and event schedules.
- Manage client information.
- Manage vendor information and services.
- Manage venue details and availability.
- Collect and manage client feedback.
- Automate event reminders.
- Automate event cancellation approval.
- Prevent double booking of venues.
- Automatically update venue availability.
- Automatically mark past events as completed.
- Provide reports and dashboards for event monitoring.
- Implement security using Profiles, Roles, Permission Sets, OWD, and Sharing Rules.

---

## Technologies Used

- Salesforce CRM
- Salesforce Lightning App
- Apex
- Apex Triggers
- Record-Triggered Flow
- Approval Process
- Validation Rules
- Formula Fields
- SOQL
- Custom Objects
- Lookup Relationships
- Master-Detail Relationships
- Reports
- Dashboards
- Profiles
- Roles
- Permission Sets
- Sharing Rules

---

## Custom Objects

The project contains the following custom objects:

| Object | Purpose |
|---|---|
| Event | Stores event details, date, type, status, budget, client, and venue |
| Client | Stores client contact and address information |
| Vendor | Stores vendor service and contact information |
| Venue | Stores venue details, capacity, location, and availability |
| Feedback | Stores client feedback and event ratings |
| EventVendor | Junction object used to connect Events and Vendors |

---

## Main Features

### 1. Event Management

The Event object stores:

- Event Name
- Event Type
- Event Date
- Event Status
- Event Budget
- Client
- Venue

Event types include Wedding, Corporate, Birthday, Anniversary, Festival, Concert, and Other.

---

### 2. Client Management

The Client object stores:

- Email
- Phone
- Address
- Country
- City

---

### 3. Vendor Management

The Vendor object manages vendor information such as:

- Service Type
- Email
- Phone
- Status

---

### 4. Venue Management

The Venue object stores:

- Address
- Location
- Capacity
- Availability Status

Venue availability can be updated automatically based on event status.

---

### 5. Feedback Management

The Feedback object stores:

- Rating
- Comments
- Event
- Client

A Permission Set named `Feedback Manager` was created to provide Feedback object permissions.

---

## Automation

### 3-Day Event Reminder Flow

A record-triggered Flow sends a reminder email to the client three days before a confirmed event.

The reminder contains:

- Client name
- Event name
- Event date
- Venue
- Event type

The Event Owner is also included as a CC recipient.

---

### Event Cancellation Approval

An Approval Process named:

`Event_Cancellation_Process`

was created for events with the status:

`Pending Cancellation`

The approval process contains a Manager Review step.

Approval:

```text
Pending Cancellation
        |
        v
  Manager Review
      /     \
     /       \
Approve     Reject
   |           |
   v           v
Canceled     Rejected