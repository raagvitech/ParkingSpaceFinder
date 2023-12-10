@isTest
public class RegistrationAndLoginControllerTest
{
    @isTest(SeeAllData=true)	
    public static String doLoginTest()
    {
        try
        {
			RegistrationAndLoginController.doLogin('naresh190@gmail.com.parking', 'mandloi@22');
			return 'true';
        }
        catch (Exception e)
        {
            return null;
        }
    }
    @isTest(SeeAllData=true)
    public static boolean isEmailExistTest()
    {
            RegistrationAndLoginController.isEmailExist('shubhammandloi599@gmail.com.parking');
        	return true;
    }
    @isTest
    public static string registerUserTest()
    {
        // Test data
        String lastName = 'TestLastName';
        String phone = '1234567890';
        String email = 'test@example.com';
        String username = 'T2e3s5tUser';
        String communityNickname = 'TestCommunity';
        String password = 'TestPassword';


        // Call the method to test
        Profile guestProfile = [SELECT Id FROM Profile WHERE Name = 'VehicleParking Profile' AND UserLicense.Name = 'Guest User License' LIMIT 1];

        //Create our test guest user
        User guestUser = new User(
            Alias = 'random',
            Email='random@salesforce.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'random',
            LocaleSidKey = 'en_US',
            LanguageLocaleKey = 'en_US',
            ProfileId = guestProfile.Id,
            TimeZoneSidKey ='America/Los_Angeles',
            UserName ='randomud32de4g2xwqser@salesforceTest.com'
        );

        //Insert user record
        insert guestUser;
        System.runAs(guestUser){
            Test.startTest();
            String result = RegistrationAndLoginController.registerUser(lastName, phone, email, username, communityNickname, password);
            Test.stopTest();
        }
        return 'success';
    }
    @isTest(SeeAllData=true)
    public static string sendWelcomeMailTest()
    {
        User usr = [SELECT Id FROM User WHERE Id =:'0055h000009cK1LAAU'];
        RegistrationAndLoginController.sendWelcomeMail(usr,'0055h000009cK1LAAU');
        return 'success';
    }
}