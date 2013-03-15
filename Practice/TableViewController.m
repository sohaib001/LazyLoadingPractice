//
//  TableViewController.m
//  Practice
//
//  Created by Sohaib Muhammad on 13/03/2013.
//  Copyright (c) 2013 coeus. All rights reserved.
//

#define kProduct_Id             @"id"
#define kProduct_Title          @"title"
#define kProduct_Description	@"description"
#define kProduct_ImageUrl1      @"image_url_1"
#define kProduct_ImageUrl2      @"image_url_2"
#define kProduct_ImageUrl3      @"image_url_3"

#define kProduct_SellerId       @"seller_id"
#define kProduct_Price          @"price"
#define kProduct_Status         @"status"
#define kProduct_Latitude       @"latitude"
#define kProduct_Longitude      @"longitude"
#define kProduct_searchTerm     @"searchterm"
#define kProduct_Questions      @"questionArray"
#define kProduct_Offers         @"offerArray"
#define kProduct_CategoryID     @"category_type_id"
#define kProduct_CategoryID_2     @"categoryTypeId"


#define kProduct_ImageUrl1_new      @"img1"
#define kProduct_ImageUrl2_new      @"img2"
#define kProduct_ImageUrl3_new      @"img3"

#define kProduct_ImageUrl1_1      @"imageUrl1"
#define kProduct_ImageUrl2_2      @"imageUrl2"
#define kProduct_ImageUrl3_3      @"imageUrl3"
#define kBASEURL @"http://5hands.coeus-solutions.de/"
#define kBASEURL_IMAGE @"http://5hands.coeus-solutions.de/uploads/products/"

#import "TableViewController.h"
#import "AFHTTPClient.h"
#import "SBJsonWriter.h"
#import "SBJson.h"
#import "AFURLConnectionOperation.h"
#import "UIImageView+WebCache.h"
#import "CustomTableCell.h"
@interface TableViewController ()
@property (strong,nonatomic)  NSMutableArray * imagesArr ;
@end

@implementation TableViewController

-(void) serviceCall{

    
    
    //  setp 1 :first make the address of url in string format
    NSString *urlString = [NSString stringWithFormat:@"%@%@",kBASEURL,@"api/getallproducts"];
    
    // step 2 :then encode this stirng using encoding method (for removing spaces)
    NSString *encodedURL=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   
    // step 3: now make a url with string
    NSURL *url= [[NSURL alloc] initWithString:encodedURL];
   
    // if u are using AFNetworking then there is no need of sep 2 and 3
    
    // make a HttpClient usign AFNetworking 
    
    //AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
   
    NSMutableDictionary *postParams = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                                                  [NSString stringWithFormat:@"%f",31.54972],
                                                                                  [NSString stringWithFormat:@"%f",74.203787],
                                                                                  [NSString stringWithFormat:@"%d",1],
                                                                                  [NSString stringWithFormat:@"%f",6379.0],
                                                                                  [NSString stringWithFormat:@"%@",@""],
                                                                                  [NSString stringWithFormat:@"%d",0],nil]
                                       
                                                                         forKeys:[NSArray arrayWithObjects:
                                                                                  kProduct_Latitude,
                                                                                  kProduct_Longitude,
                                                                                  @"page",
                                                                                  @"radius",
                                                                                  kProduct_searchTerm,
                                                                                  kProduct_CategoryID,nil]];
    
  
    // this is special case in with we convert the dictionary into json using SBJson  writer .
    // then use NSURLConnection to send the asynchronous request to the server
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *jsonString= [NSString stringWithFormat:@"%@",[writer stringWithObject:postParams]];
     NSString *encodedJsonString=[jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *jsonData = [[NSString stringWithFormat:@"data=%@",encodedJsonString] dataUsingEncoding:NSUTF8StringEncoding];
    
    

    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
	[request setHTTPMethod:@"POST"];
    
    [request setHTTPBody:jsonData];
    
    NSOperationQueue *start =[NSOperationQueue mainQueue];
    
    [NSURLConnection sendAsynchronousRequest:request queue:start completionHandler:^(NSURLResponse *ressp, NSData *data, NSError *error) {
        [self parseData:data];
    }];
    
}


-(void) parseProductImagesWith:(NSDictionary*)productDict{
    
    
    
    
    if ([productDict objectForKey:kProduct_ImageUrl1] || [productDict objectForKey:kProduct_ImageUrl1_new] || [productDict objectForKey:kProduct_ImageUrl1_1])
    {
        if([productDict objectForKey:kProduct_ImageUrl1])
            [self.imagesArr addObject:[NSString stringWithFormat:@"%@%@",kBASEURL_IMAGE,[productDict objectForKey:kProduct_ImageUrl1]]];
        else if ([productDict objectForKey:kProduct_ImageUrl1_1])
            [self.imagesArr addObject:[NSString stringWithFormat:@"%@%@",kBASEURL_IMAGE,[productDict objectForKey:kProduct_ImageUrl1_1]]];
        else
            [self.imagesArr addObject:[NSString stringWithFormat:@"%@%@",kBASEURL_IMAGE,[productDict objectForKey:kProduct_ImageUrl1_new]]];
        
    }
    if ([productDict objectForKey:kProduct_ImageUrl2] || [productDict objectForKey:kProduct_ImageUrl2_new] || [productDict objectForKey:kProduct_ImageUrl2_2])
    {
        if([productDict objectForKey:kProduct_ImageUrl2])
            [self.imagesArr addObject:[NSString stringWithFormat:@"%@%@",kBASEURL_IMAGE,[productDict objectForKey:kProduct_ImageUrl2]]];
        else if ([productDict objectForKey:kProduct_ImageUrl2_2])
            [self.imagesArr addObject:[NSString stringWithFormat:@"%@%@",kBASEURL_IMAGE,[productDict objectForKey:kProduct_ImageUrl2_2]]];
        else
            [self.imagesArr addObject:[NSString stringWithFormat:@"%@%@",kBASEURL_IMAGE,[productDict objectForKey:kProduct_ImageUrl2_new]]];
        
    }
    if ([productDict objectForKey:kProduct_ImageUrl3] || [productDict objectForKey:kProduct_ImageUrl3_new] || [productDict objectForKey:kProduct_ImageUrl3_3])
    {
        if([productDict objectForKey:kProduct_ImageUrl3])
            [self.imagesArr addObject:[NSString stringWithFormat:@"%@%@",kBASEURL_IMAGE,[productDict objectForKey:kProduct_ImageUrl3]]];
        else if ([productDict objectForKey:kProduct_ImageUrl3_3])
            [self.imagesArr addObject:[NSString stringWithFormat:@"%@%@",kBASEURL_IMAGE,[productDict objectForKey:kProduct_ImageUrl3_3]]];
        else
            [self.imagesArr addObject:[NSString stringWithFormat:@"%@%@",kBASEURL_IMAGE,[productDict objectForKey:kProduct_ImageUrl3_new]]];
        
    }
    
    if (self.imagesArr.count){
        NSLog(@"%d",self.imagesArr.count);
        
    }
    
}



-(void)getProductParseWith:(NSDictionary *)productDict{
   
    [self parseProductImagesWith:productDict];
    
    
}


-(void) parseData:(id) responseObject{
    
    NSData *data = [[NSData alloc] initWithData:responseObject];
    NSError *error = [[NSError alloc] init];
    
    NSObject *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"%@",json);
    
    NSArray *productsToParse = (NSArray*)json;
    for (int i = 0; i < productsToParse.count; i++) {
		[self getProductParseWith:(NSDictionary *)[productsToParse objectAtIndex:i]];
    }
	
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.imagesArr = [NSMutableArray new];

    [self serviceCall];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
//
   CustomTableCell *cell =(CustomTableCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        NSArray *nib = [[ NSBundle mainBundle] loadNibNamed:@"CustomTableCell" owner:nil options:nil];
        cell = (CustomTableCell *) [nib objectAtIndex:0];
        
        
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"Nib name" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)viewDidUnload {
   
    [super viewDidUnload];
}
@end
