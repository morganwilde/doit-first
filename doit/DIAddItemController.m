//
//  DIAddItem.m
//  doit
//
//  Created by Morgan Wilde on 03/05/2013.
//  Copyright (c) 2013 morganwilde. All rights reserved.
//

#import "DIAddItemController.h"
#import "DIViewController.h"

@interface DIAddItemController ()

@property (weak, nonatomic) IBOutlet UILabel *labelHeader;
@property (weak, nonatomic) IBOutlet UITextField *itemNewContent;

- (IBAction)itemNewConfirm:(id)sender;

@end

@implementation DIAddItemController

- (IBAction)itemNewConfirm:(id)sender
{
    // This is where we send off our data to doit API
    //NSLog(@"field - %@", self.itemNewContent.text);
    
    NSURL *doitAPIUrl = [NSURL URLWithString:@"http://mproject-doit-api.herokuapp.com/person/1/item-add"];
    NSMutableURLRequest *doitAPIRequest = [[NSMutableURLRequest alloc] initWithURL:doitAPIUrl];
    
    // HTTP method
    [doitAPIRequest setHTTPMethod:@"POST"];
    // Prepare request body
    NSString *number = [@"5" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *content = [self.itemNewContent.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *requestBody = [NSString stringWithFormat:@"number=%@&content=%@", number, content];
    // HTTP request body
    [doitAPIRequest setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Request URL
    NSURLConnection *doitAPIConnection = [[NSURLConnection alloc] initWithRequest:doitAPIRequest delegate:self];

    //DIViewController *viewItemList = [self.storyboard instantiateViewControllerWithIdentifier:@"viewItemList"];
    //[self presentedViewController:viewItemList animated:YES completion:nil];
    
    if (doitAPIConnection) {

        //NSLog(@"result - %@", [requestBody dataUsingEncoding:NSUTF8StringEncoding]);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //NSLog(@"segue start");
    
    // this works without the segue
    //UIStoryboard *storyboard = self.storyboard;
    //DIViewController *viewItemList = [storyboard instantiateViewControllerWithIdentifier:@"viewItemList"];
    //[self presentViewController:viewItemList animated:YES completion:nil];
    
    // this works with the proper segue
    [self performSegueWithIdentifier:@"ItemDoListDisplay" sender:self];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.itemNewContent) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

@end

// Custom segue
@interface segueFlipLeft : UIStoryboardSegue

@end

@implementation segueFlipLeft

- (void)perform
{
    UIViewController *src = (UIViewController *) self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;

    [UIView beginAnimations:@"LeftFlip" context:nil];
    [UIView setAnimationDuration:0.8];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:src.view.superview cache:YES];
    [UIView commitAnimations];

    [src presentViewController:dst animated:NO completion:nil];
    //[[self sourceViewController] presentModalViewController:[self destinationViewController] animated:NO];
}

@end