@isTest
public class ParkingSpaceControllerTest {   
@isTest
 public static void getParkingLoactionTest(){
    String cities = 'Bangalore';
    String place = 'koramangala';
    Parking_Loaction__c plocation = new Parking_Loaction__c();
        plocation.Name = 'Testlocation';
        plocation.City__c = cities;
        plocation.Landmark__c = place;
        insert plocation;
    List<Parking_Loaction__c> parkinglocation = ParkingSpaceController.getParkingLoaction(cities,place);
    System.assertEquals(parkinglocation.size(),1);
 }

  
 @isTest
 public static void getTimeSlotTest(){
     date myDate = date.newInstance(2023, 12, 10);
    String selectedDate =String.valueOf(myDate);
    String timeSlot = '1PM to 2PM';
    Time_Slot__c tslot = new Time_Slot__c();
    tslot.Name = 'test';
    insert tslot;
    List<Time_Slot__c> bookedSlot = ParkingSpaceController.getTimeSlot(tslot.Id,selectedDate,timeSlot);
  
 }

 @isTest
 public static void bookSlotsTest(){
    String id = 'f123';
    String email = 'test@gmail.com';
    String numval = '12346';
    String name = 'test';
    Time_Slot__c slotbook = new Time_Slot__c();
    slotbook.Name = name;
    insert slotbook;
    
   
    ParkingSpaceController.bookSlots(slotbook.Id,email,numval,name);
   
 }
}