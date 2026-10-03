@IsTest
private class VenueStatusHelperTest {

    @IsTest
    static void testConfirmedEventReservesVenue() {

        Venue__c venue = new Venue__c(
            Name = 'Test Venue',
            Availability_Status__c = 'Available'
        );
        insert venue;

        Event__c eventRecord = new Event__c(
            Name = 'Test Event',
            Venue__c = venue.Id,
            Event_Date__c = Date.today().addDays(10),
            Event_Status__c = 'Confirmed'
        );

        Test.startTest();

        VenueStatusHelper.updateVenueStatus(
            new List<Event__c>{ eventRecord }
        );

        Test.stopTest();

        Venue__c updatedVenue = [
            SELECT Id, Availability_Status__c
            FROM Venue__c
            WHERE Id = :venue.Id
        ];

        System.assertEquals(
            'Reserved',
            updatedVenue.Availability_Status__c
        );
    }


    @IsTest
    static void testCanceledEventMakesVenueAvailable() {

        Venue__c venue = new Venue__c(
            Name = 'Test Venue',
            Availability_Status__c = 'Reserved'
        );
        insert venue;

        Event__c eventRecord = new Event__c(
            Name = 'Test Event',
            Venue__c = venue.Id,
            Event_Date__c = Date.today().addDays(10),
            Event_Status__c = 'Canceled'
        );

        Test.startTest();

        VenueStatusHelper.updateVenueStatus(
            new List<Event__c>{ eventRecord }
        );

        Test.stopTest();

        Venue__c updatedVenue = [
            SELECT Id, Availability_Status__c
            FROM Venue__c
            WHERE Id = :venue.Id
        ];

        System.assertEquals(
            'Available',
            updatedVenue.Availability_Status__c
        );
    }
}