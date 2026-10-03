@IsTest
private class PreventDoubleBookingTest {

    @IsTest
    static void testDuplicateVenueAndDateIsPrevented() {

        Venue__c venue = new Venue__c(
            Name = 'Test Venue',
            Availability_Status__c = 'Available'
        );
        insert venue;

        Date eventDate = Date.today().addDays(15);

        Event__c firstEvent = new Event__c(
            Name = 'First Event',
            Venue__c = venue.Id,
            Event_Date__c = eventDate,
            Event_Status__c = 'Confirmed'
        );

        insert firstEvent;

        Event__c secondEvent = new Event__c(
            Name = 'Second Event',
            Venue__c = venue.Id,
            Event_Date__c = eventDate,
            Event_Status__c = 'Confirmed'
        );

        Test.startTest();

        Database.SaveResult result = Database.insert(
            secondEvent,
            false
        );

        Test.stopTest();

        System.assertEquals(
            false,
            result.isSuccess()
        );

        System.assert(
            result.getErrors()[0]
                .getMessage()
                .contains('This Venue is already booked on this date.')
        );
    }


    @IsTest
    static void testDifferentDatesAreAllowed() {

        Venue__c venue = new Venue__c(
            Name = 'Another Test Venue',
            Availability_Status__c = 'Available'
        );
        insert venue;

        Event__c firstEvent = new Event__c(
            Name = 'First Event',
            Venue__c = venue.Id,
            Event_Date__c = Date.today().addDays(20),
            Event_Status__c = 'Confirmed'
        );

        insert firstEvent;

        Event__c secondEvent = new Event__c(
            Name = 'Second Event',
            Venue__c = venue.Id,
            Event_Date__c = Date.today().addDays(21),
            Event_Status__c = 'Confirmed'
        );

        Test.startTest();

        Database.SaveResult result = Database.insert(
            secondEvent,
            false
        );

        Test.stopTest();

        System.assertEquals(
            true,
            result.isSuccess()
        );
    }
}