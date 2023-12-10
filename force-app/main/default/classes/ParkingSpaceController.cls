public with sharing class ParkingSpaceController {
    @AuraEnabled(cacheable = true)
    public static List<Parking_Loaction__c> getParkingLoaction(String cities, String places) {
        if (String.isNotEmpty(cities) && String.isNotEmpty(places)){
            System.debug('cities => '+cities);
            System.debug('places => '+places);
            return [SELECT Id, Name, City__c, Landmark__c, Address__c, OwnerId FROM Parking_Loaction__c WHERE City__c = : cities and Landmark__c = : places];
        }
        return new List<Parking_Loaction__c>();
    }

    @AuraEnabled(cacheable = true)
    public static List<Time_Slot__c> getTimeSlot(String id,String selectedDate, String timeSlot) {
        if (String.isNotEmpty(selectedDate) && String.isNotEmpty(timeSlot) && String.isNotEmpty(id)) {
            Date dateValue =  Date.valueOf(selectedDate);
            return [SELECT Id, Name, Booking_Date__c, Is_Booked__c, Time_Range__c, From_Time__c, To_Date__c, Paid_Amount__c, Parking_Space__c, User_Name__c, Contact_Number__c, Email__c, Parking_Space__r.Name, Parking_Space__r.Parking_Loaction__c FROM Time_Slot__c WHERE Booking_Date__c = : dateValue AND Time_Range__c = : timeSlot AND Parking_Space__r.Parking_Loaction__c = : id];
        }else{
            System.debug('Error');
        }
        return new List<Time_Slot__c>();
    }
    @AuraEnabled
    public static void bookSlots(String slotId ,String email , String numbervalue ,String name) {
        Time_Slot__c slot = [SELECT Id, Name, Is_Booked__c,  Paid_Amount__c, Parking_Space__c, User_Name__c, Contact_Number__c, Email__c, Parking_Space__r.Name, Parking_Space__r.Parking_Loaction__c,Time_Range__c, Booking_Date__c FROM Time_Slot__c WHERE Id = : slotId];
        slot.Is_Booked__c = true;
        slot.User_Name__c = name;
        slot.Contact_Number__c = numbervalue;
        slot.Email__c = email;
        
        UPDATE slot;

        String emailBody = 'Hi '+ name+', \n Your booking is successfull on '+ String.valueOf(slot.Booking_Date__c) + ' and slot allocated is ' +slot.Time_Range__c +' \n Thanks,\n Team Parking Space';
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new List<String>{email};
        message.optOutPolicy = 'FILTER';
        message.subject = 'Parking Booking Alert';
        message.plainTextBody = emailBody;
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        System.debug('results  => '+results);
    }
}