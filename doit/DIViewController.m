//
//  DIViewController.m
//  doit
//
//  Created by Morgan Wilde on 03/05/2013.
//  Copyright (c) 2013 morganwilde. All rights reserved.
//

#import "DIViewController.h"
#import "views/DIItemListLabel.h"
#import "models/DIItemObject.h"

#define dispatchQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface DIViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelCurrentTime;
@property (weak, nonatomic) IBOutlet UIScrollView *itemCollectionList;

@end

@implementation DIViewController

- (void)viewDidLoad
{
    [self.itemCollectionList setScrollEnabled:YES];
    [self.itemCollectionList setContentSize:CGSizeMake(50, 400)];
    
    // Retrieve items from the doit API
    NSURL *doitAPIUrl = [NSURL URLWithString:@"http://mproject-doit-api.herokuapp.com/person/1/items"];
    
    dispatch_async(dispatchQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:doitAPIUrl];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    [self timeReload];                              // Fills the time label
    [NSTimer scheduledTimerWithTimeInterval:1.0f    // Reloads it every second
                                     target:self
                                   selector:@selector(timeReload)
                                   userInfo:nil
                                    repeats:YES];
     
}

- (void)fetchedData:(NSData *)responseData
{
    // Parse json data
    NSError *error;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    // Loop through the data
    int             itemCount       = [json count];
    NSMutableArray  *itemCollection = [NSMutableArray array];
    DIItemObject    *itemObjectNew;
    
    for (int itemNum = 0; itemNum < itemCount; itemNum++) {
        // Parse items dictionary
        NSDictionary *doitJSON = [json objectAtIndex:itemNum];
        //id number = [doitJSON objectForKey:@"pin"];
        id content = [doitJSON objectForKey:@"content"];
        // temp
        NSNumber *number = [NSNumber numberWithUnsignedInt:itemNum];
        //NSLog(@"number - %@", number);
        
        // Create item object
        itemObjectNew = [[DIItemObject alloc] initWithNumber:number andContent:content];
        // Append to collection
        [itemCollection addObject:itemObjectNew];
        
        // Add item label to scroll view
        [self.itemCollectionList addSubview:[[DIItemListLabel alloc] initWithItemObject:itemObjectNew].itemLabel];
        
        /*
        NSLog(@"%@ - %@",
              [doitJSON objectForKey:@"number"],
              [doitJSON objectForKey:@"content"]);
         */
    }
    
    // Resize the scroll view
    [self.itemCollectionList setContentSize:CGSizeMake(50, itemCount * 20)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Time setting method
- (void)timeReload
{
    // Get current time
    NSDate *timeNow = [NSDate date];
    NSCalendar *timeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [timeCalendar setTimeZone:[NSTimeZone systemTimeZone]];
    NSDateComponents *timeDate = [timeCalendar components:(NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit) fromDate:timeNow];
    
    // Set the time label to display it
    self.labelCurrentTime.text = [NSString stringWithFormat:
                                  @"%02d:%02d:%02d",
                                  [timeDate hour],
                                  [timeDate minute],
                                  [timeDate second]];
}

@end
