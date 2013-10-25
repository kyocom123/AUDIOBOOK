//
//  ViewController.m
//  SwipeToTransferDemo
//
//  Created by lijiangang on 13-4-17.
//  Copyright (c) 2013年 lijiangang. All rights reserved.
//

#import "ViewController.h"
#import "TheSecondViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableArray *screenShot;
}
@synthesize tableView=_tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGSize thisFrameSize = self.view.frame.size;
    //add tabview
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tableView.delegate = (id<UITableViewDelegate>)self;
        tableView.dataSource = (id<UITableViewDataSource>)self;
        [self.view addSubview:tableView];
        self.tableView = tableView;
    }

    
    
    UIImage *img = [UIImage imageNamed:@"My_Bookshelf_by_sardao.jpg"];
    
    UIGraphicsBeginImageContext( thisFrameSize );
    [img drawInRect:CGRectMake(0,0,thisFrameSize.width,thisFrameSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor =[UIColor colorWithPatternImage:newImage];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    image.backgroundColor = [UIColor blueColor];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(100, 17, 160, 30)];
    lab.text = @"SÁCH NÓI VIỆT";
    lab.textColor = [UIColor redColor];
    lab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:image];
    [self.view addSubview:lab];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"firstView";
 //   self.view.userInteractionEnabled=YES;
}
- (void)viewDidUnload {
    [super viewDidUnload];
    self.tableView = nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    screenShot =[[NSMutableArray alloc]init];
    [screenShot addObject:[self capture]];
      
}
- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}


- (IBAction)PushToNext:(id)sender {
    TheSecondViewController *vc = [[TheSecondViewController alloc]init];
       vc.screenShotsList = screenShot;
    [self.navigationController pushViewController:vc animated:YES];
  
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
//so row
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
//chieu dai row
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return  498;
    }
    else
    {
        return 139;
    }
}
//set content row
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    UIImage *img ;
    CGSize thisFrameSize = self.view.frame.size;
    
    
    if (indexPath.row==0) {
        img = [UIImage imageNamed:@"BACK_1.JPG"];
        UIGraphicsBeginImageContext( img.size );
        [img drawInRect:CGRectMake(0,0,thisFrameSize.width,498)];
    }
    else
    {
        img = [UIImage imageNamed:@"BACK_2.JPG"];
        UIGraphicsBeginImageContext( img.size );
        [img drawInRect:CGRectMake(0,0,thisFrameSize.width,139)];
    }
    
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    cell.backgroundColor =[UIColor colorWithPatternImage:img];
    
    //img truyen
    img = [UIImage imageNamed:@"BookDefault.jpg"];
    UIGraphicsBeginImageContext( img.size );
    [img drawInRect:CGRectMake(35,30,60,90)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *posterValue = [[UIImageView alloc]initWithImage:img];
    [cell.contentView addSubview:posterValue];
    //cell.imageView.image = [UIImage imageNamed:@"BookDefault.jpg"];
    //cell.textLabel.text = [NSString stringWithFormat:@"sach thu %i", indexPath.row];
    
    return cell;
    
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
