//
//  JCSDirectoryViewController.m
//  FileView
//
//  Created by Jaicob Stewart on 8/28/14.
//  Copyright (c) 2014 Jaicob Stewart. All rights reserved.
//

#import "JCSDirectoryViewController.h"

@interface JCSDirectoryViewController () <UITableViewDelegate, UITableViewDataSource>
@property NSString *path;
@end

@implementation JCSDirectoryViewController

- (id)initWithPath:(NSString *)path Style:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.path = path;
  }
  
  return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [self initWithPath:@"/" Style:UITableViewStylePlain];
  self.title =  @"/"; 
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
  
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Determined by the number of keys returned by the filemanager
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSInteger rows = [[fileManager contentsOfDirectoryAtPath:self.path error:nil] count];
  // Return the number of rows in the section.
  return rows;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
 
 NSFileManager *fileManager = [NSFileManager defaultManager];
 NSArray *pathContents = [fileManager contentsOfDirectoryAtPath:self.path error:nil];
 NSString *cellText = pathContents[indexPath.row];
   
 cell.textLabel.text = cellText;
   
 return cell;
 }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSArray *pathContents = [fileManager contentsOfDirectoryAtPath:self.path error:nil];
  NSString *subPath = [NSString stringWithFormat:@"/%@",pathContents[indexPath.row]];
  NSString *newPath = [self.path stringByAppendingString:subPath];
  JCSDirectoryViewController *directoryVC = [[JCSDirectoryViewController alloc]initWithPath:newPath Style:UITableViewStylePlain];
  directoryVC.title = subPath;
  [self.navigationController pushViewController:directoryVC animated:YES];
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
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
