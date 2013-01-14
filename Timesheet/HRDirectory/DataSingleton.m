//
//  DataSingleton.m
//  HRDirectory
//
//  Created by Alex Chiu on 9/11/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "DataSingleton.h"

@implementation DataSingleton


@synthesize hr_users = _hr_users;

-(id)initDataSingleton
{
    if(self == [super init])
    {       
        [self createHRUsers];
    }
    return self;
}

+ (DataSingleton *) instance
{
    // Persistent instance.
    static DataSingleton *_default = nil;
    
    // Small optimization to avoid wasting time after the
    // singleton being initialized.
    if (_default != nil)
    {
        return _default;
    }
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    // Allocates once with Grand Central Dispatch (GCD) routine.
    // It's thread safe.
    static dispatch_once_t safer;
    dispatch_once(&safer, ^(void)
                  {
                      _default = [[DataSingleton alloc] initDataSingleton];
                  });
#else
    // Allocates once using the old approach, it's slower.
    // It's thread safe.
    @synchronized([MySingleton class])
    {
        // The synchronized instruction will make sure,
        // that only one thread will access this point at a time.
        if (_default == nil)
        {
            _default = [[MySingleton alloc] initSingleton];
        }
    }
#endif
    return _default;
}

-(void)createHRUsers {
    self.hr_users = [[NSMutableArray alloc] init];
    NSDictionary *entry;
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Bilbo Baggins", @"employeeName",
             @"bbaggins", @"employeeID",
             @"test", @"password",
             @"HTML5", @"department",
             @"", @"manager",
             @"Web Developer", @"position",
             @"3 Corporate Park \n Irvine, CA 92606", @"address",
             @"bbaggins@yahoo.com", @"email",
             @"310-1111-1111", @"phone",
             @"Bilbo", @"firstName",
             @"Baggins", @"lastName",
             @"http://4.bp.blogspot.com/-sZb0qXbNrtE/ToH3uMSIqrI/AAAAAAAACYA/7WrSzaTBKy0/s1600/animals_cats_small1.jpg", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Frodo Baggins", @"employeeName",
             @"fbaggins", @"employeeID",
             @"test", @"password",
             @"HR", @"department",
             @"gandalf", @"manager",
             @"Ringbearer", @"position",
             @"3 Corporate Park \n Irvine, CA 92606", @"address",
             @"fbaggins@lotr.com", @"email",
             @"3849102333", @"phone",
             @"Frodo", @"firstName",
             @"Baggins", @"lastName",
             @"http://4.bp.blogspot.com/-sZb0qXbNrtE/ToH3uMSIqrI/AAAAAAAACYA/7WrSzaTBKy0/s1600/animals_cats_small1.jpg", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Gandalf", @"employeeName",
             @"gandalf", @"employeeID",
             @"test", @"password",
             @"Mgmt", @"department",
             @"Senior SAP Architect", @"position",
             @"", @"manager",
             @"3 Corporate Park \nIrvine, CA 92606", @"address",
             @"gandalf@lotr.com", @"email",
             @"7378485929", @"phone",
             @"Gandalf", @"firstName",
             @"White", @"lastName",
             @"http://4.bp.blogspot.com/-sZb0qXbNrtE/ToH3uMSIqrI/AAAAAAAACYA/7WrSzaTBKy0/s1600/animals_cats_small1.jpg", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Meriadoc Brandybuck", @"employeeName",
             @"mbrandybuck", @"employeeID",
             @"test", @"password",
             @"Android", @"department",
             @"Mobile Developer", @"position",
             @"gandalf", @"manager",
             @"3 Corporate Park \n Irvine, CA 92606", @"address",
             @"mbrandybuck@lotr.com", @"email",
             @"9038498485", @"phone",
             @"Meriadoc", @"firstName",
             @"Brandybuck", @"lastName",
             @"http://4.bp.blogspot.com/-sZb0qXbNrtE/ToH3uMSIqrI/AAAAAAAACYA/7WrSzaTBKy0/s1600/animals_cats_small1.jpg", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Peregrin Took", @"employeeName",
             @"ptook", @"employeeID",
             @"test", @"password",
             @"IT", @"department",
             @"Network Administrator", @"position",
             @"gandalf", @"manager",
             @"3 Corporate Park \n Irvine, CA 92606", @"address",
             @"ptook@lotr.com", @"email",
             @"6572837485", @"phone",
             @"Peregrin", @"firstName",
             @"Took", @"lastName",
             @"http://4.bp.blogspot.com/-sZb0qXbNrtE/ToH3uMSIqrI/AAAAAAAACYA/7WrSzaTBKy0/s1600/animals_cats_small1.jpg", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Samwise Gamgee", @"employeeName",
             @"sgamgee", @"employeeID",
             @"test", @"password",
             @"HR", @"department",
             @"Recruiter", @"position",
             @"gandalf", @"manager",
             @"3 Corporate Park \n Irvine, CA 92606", @"address",
             @"sgamgee@lotr.com", @"email",
             @"8762345647", @"phone",
             @"Samwise", @"firstName",
             @"Gamgee", @"lastName",
             @"http://4.bp.blogspot.com/-sZb0qXbNrtE/ToH3uMSIqrI/AAAAAAAACYA/7WrSzaTBKy0/s1600/animals_cats_small1.jpg", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"John Shepard", @"employeeName",
             @"jshepard", @"employeeID",
             @"test", @"password",
             @"Alliance", @"department",
             @"Spectre", @"position",
             @"", @"manager",
             @"SSV Normandy", @"address",
             @"jshepard@masseffect.com", @"email",
             @"8762345647", @"phone",
             @"John", @"firstName",
             @"Shepard", @"lastName",
             @"http://fc05.deviantart.net/fs70/f/2012/173/9/b/commander_shepard_by_kaymarierose-d54ib08.jpg", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Ashley Williams", @"employeeName",
             @"awilliams", @"employeeID",
             @"test", @"password",
             @"Alliance Millitary", @"department",
             @"Gunner Chief", @"position",
             @"jshepard", @"manager",
             @"SSV Normandy", @"address",
             @"awilliams@masseffect.com", @"email",
             @"8762345647", @"phone",
             @"Ashley", @"firstName",
             @"Williams", @"lastName",
             @"http://images4.wikia.nocookie.net/__cb20120327175355/masseffect/images/thumb/a/a2/Ashley_ME3_Character_Shot.png/150px-Ashley_ME3_Character_Shot.png", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Tali Zorah", @"employeeName",
             @"tzorah", @"employeeID",
             @"test", @"password",
             @"Quarian", @"department",
             @"Councilwoman", @"position",
             @"jshepard", @"manager",
             @"SSV Normandy", @"address",
             @"tzorah@masseffect.com", @"email",
             @"8762345647", @"phone",
             @"Tali", @"firstName",
             @"Zorah", @"lastName",
             @"http://images1.wikia.nocookie.net/__cb20100610191748/masseffect/images/thumb/f/f6/Tali_Character_Box.png/270px-Tali_Character_Box.png", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Jacqeline Nought", @"employeeName",
             @"subzero", @"employeeID",
             @"test", @"password",
             @"Biotic", @"department",
             @"Psyochotic Biotic", @"position",
             @"jshepard", @"manager",
             @"SSV Normandy", @"address",
             @"subjectzero@masseffect.com", @"email",
             @"8762345647", @"phone",
             @"Jacqeline", @"firstName",
             @"Naught", @"lastName",
             @"http://images3.wikia.nocookie.net/__cb20100411062038/masseffect/images/thumb/4/45/Subject_Zero_Character_Box.png/270px-Subject_Zero_Character_Box.png", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Miranda Lawson", @"employeeName",
             @"mlawson", @"employeeID",
             @"test", @"password",
             @"Cerberus", @"department",
             @"Second in Command", @"position",
             @"jshepard", @"manager",
             @"SSV Normandy", @"address",
             @"mlawson@masseffect.com", @"email",
             @"8762345647", @"phone",
             @"Miranda", @"firstName",
             @"Lawson", @"lastName",
             @"http://images4.wikia.nocookie.net/__cb20100427194237/masseffect/images/thumb/a/ac/Miranda_Character_Box.png/270px-Miranda_Character_Box.png", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Garrus Vakarian", @"employeeName",
             @"archangel", @"employeeID",
             @"test", @"password",
             @"Turian", @"department",
             @"Best bro", @"position",
             @"jshepard", @"manager",
             @"SSV Normandy", @"address",
             @"archangel@masseffect.com", @"email",
             @"8762345647", @"phone",
             @"Garrus", @"firstName",
             @"Vakarian", @"lastName",
             @"http://images1.wikia.nocookie.net/__cb20100306223761/masseffect/images/thumb/3/35/Garrus_Character_Box.png/270px-Garrus_Character_Box.png", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Wrex Urdnot", @"employeeName",
             @"wrex", @"employeeID",
             @"test", @"password",
             @"Krogan", @"department",
             @"Patriarch", @"position",
             @"", @"manager",
             @"SSV Normandy", @"address",
             @"wrex@masseffect.com", @"email",
             @"8762345647", @"phone",
             @"Wrex", @"firstName",
             @"Urdnot", @"lastName",
             @"http://images1.wikia.nocookie.net/__cb20100610185441/masseffect/images/thumb/4/4e/Wrex_Character_Box.png/270px-Wrex_Character_Box.png", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Thane Krios", @"employeeName",
             @"tkrios", @"employeeID",
             @"test", @"password",
             @"Drell", @"department",
             @"Master Assassin", @"position",
             @"jshepard", @"manager",
             @"SSV Normandy", @"address",
             @"tkrios@masseffect.com", @"email",
             @"8762345647", @"phone",
             @"Thane", @"firstName",
             @"Krios", @"lastName",
             @"http://images2.wikia.nocookie.net/__cb20100607192607/masseffect/images/thumb/8/81/Thane_Character_Box.png/270px-Thane_Character_Box.png", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Joseph Manager", @"employeeName",
             @"manager", @"employeeID",
             @"test", @"password",
             @"Management", @"department",
             @"Head manager", @"position",
             @"", @"manager",
             @"Management street", @"address",
             @"manager@manager.com", @"email",
             @"8762345647", @"phone",
             @"Joseph", @"firstName",
             @"Manager", @"lastName",
             @"http://t1.gstatic.com/images?q=tbn:ANd9GcT_kTouXCKz-iLFpFfiL5On_6r-GsXnjQzczkssYbpOVv7BvO-DLA", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Jacob User", @"employeeName",
             @"user", @"employeeID",
             @"test", @"password",
             @"Userment", @"department",
             @"Head User", @"position",
             @"manager", @"manager",
             @"User street", @"address",
             @"user@manager.com", @"email",
             @"8762345647", @"phone",
             @"Jacob", @"firstName",
             @"User", @"lastName",
             @"http://icons.iconarchive.com/icons/artua/dragon-soft/512/User-icon.png", @"picture",
             nil];
    [self.hr_users addObject:entry];

}

-(NSDictionary *)findByUsername:(NSString *)username
{
    for(NSDictionary *thisUser in self.hr_users)
    {
        NSString *tempUsername = [thisUser objectForKey:@"employeeID"];
        if([tempUsername isEqualToString:username])
            return thisUser;
    }
    return nil;
}

@end
