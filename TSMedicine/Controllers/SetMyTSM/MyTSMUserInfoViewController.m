//
//  MyTSMUserInfoViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-4.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyTSMUserInfoViewController.h"
#import "MyTSMResetViewController.h"
#import "MyUserInforView.h"

#import "MyUserInfoHeadTableViewCell.h"
#import "MyUserInfoTableViewCell.h"

#import "UIImage+Rotation.h"
#import "UIImage+Resize.h"

NSString *const UserInfoHeadTableViewCell = @"MyUserInfoHeadTableViewCell";
NSString *const UserInfoTableViewCell = @"MyUserInfoTableViewCell";

#define PROVINCE_TITLE  @"province_title"       //省名
#define CITY_TITLE      @"city_title"           //市名
#define COUNTY_TITLE    @"county_title"         //县/地区名

@interface MyTSMUserInfoViewController () <UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSMutableArray  *provinceTitleArr;
    UIView          *bgView;                    //地区界面
    UIPickerView    *areaPickView;
    UIToolbar       *finishBar;

    NSInteger       currentProvinceIndex;       //第一列选择的省份，方便显示 市名
    NSInteger       currentCityIndex;           //地二列选择的市名，方便显示 县/地区名
    NSString        *selectProvince;
    NSString        *selectCity;
    NSString        *selectCounty;
}

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) UIActionSheet *pageActionSheet;
@property (nonatomic,strong) UIImage *userImage;

@end

@implementation MyTSMUserInfoViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
    
    [self createUI];
    
    [self loadAreaData];
    
    provinceTitleArr = [NSMutableArray array];
    
}
-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"个人资料";
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
    }
    
    [_tableView registerNib:[UINib nibWithNibName:UserInfoHeadTableViewCell bundle:nil] forCellReuseIdentifier:UserInfoHeadTableViewCell];
    [_tableView registerNib:[UINib nibWithNibName:UserInfoTableViewCell bundle:nil] forCellReuseIdentifier:UserInfoTableViewCell];
    
    return _tableView;
}
-(void)createUI
{
    [self.view addSubview:self.tableView];
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, Main_Size.height, Main_Size.width, 162+Navbar_Height)];
    [bgView setBackgroundColor:[UIColor whiteColor]];
//    [bgView.layer setBorderWidth:0.5];
//    [bgView.layer setBorderColor:NavBarColor.CGColor];
    [self.view addSubview:bgView];
    
    finishBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, Main_Size.width, Navbar_Height)];
    [finishBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *finishItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishChoiceArea)];
    [finishBar setItems:[NSArray arrayWithObjects:spaceItem,finishItem,nil]];
    [bgView addSubview:finishBar];
    
    areaPickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, Navbar_Height, Main_Size.width, 162)];
    [areaPickView setDelegate:self];
    [areaPickView setDataSource:self];
    [areaPickView setShowsSelectionIndicator:YES];
    [areaPickView setBackgroundColor:[UIColor whiteColor]];
    [bgView addSubview:areaPickView];
}

#pragma mark ViewAction
- (void)finishChoiceArea{
    [UIView animateWithDuration:0.3 animations:^{
        [bgView setFrame:CGRectMake(0, Main_Size.height, Main_Size.width, 162 + Navbar_Height)];
    }];
    [[self areaLb] setText:[NSString stringWithFormat:@"%@-%@-%@",selectProvince,selectCity,selectCounty]];
    
     NSDictionary *parameters = @{@"u":UserInfoData.im,@"UserLogin":UserInfoData.im,@"clientkey":UserInfoData.clientkey,@"Province":selectProvince,@"City":selectCity,@"Area":selectCounty};
    
    [self resetInfoWithParameter:parameters];
}

#pragma mark ------------UITableViewDataSource--------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        MyUserInfoHeadTableViewCell *headCell = [tableView dequeueReusableCellWithIdentifier:UserInfoHeadTableViewCell];
        headCell.titleLab.text = @"头像";
        [headCell.headImageView sd_setImageWithURL:[NSURL URLWithString:UserInfoData.headPic] placeholderImage:[UIImage imageNamed:default_head] options:SDWebImageRefreshCached];
        headCell.headImageView.tag = 1000;
        return headCell;
        
    }else{
        
        MyUserInfoTableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:UserInfoTableViewCell];
        switch (indexPath.row) {
            case 1:
            {
                infoCell.titleLab.text = @"昵称";
                infoCell.contentLab.text = [NSString stringWithFormat:@"%@",UserInfoData.nickName];;
            }
                break;
                
            case 2:
            {
                infoCell.titleLab.text = @"性别";
                infoCell.contentLab.tag = 101;
                infoCell.contentLab.text = [NSString stringWithFormat:@"%@",UserInfoData.sex];
            }
                break;
                
            case 3:
            {
                infoCell.titleLab.text = @"年龄";
                infoCell.contentLab.text = [NSString stringWithFormat:@"%@",UserInfoData.Age];
            }
                break;
                
            case 4:
            {
                infoCell.titleLab.text = @"手机号";
                infoCell.contentLab.text = [NSString stringWithFormat:@"%@",UserInfoData.phone];
            }
                break;
                
            case 5:
            {
                infoCell.titleLab.text = @"地区";
                infoCell.contentLab.tag = 102;
                infoCell.contentLab.text = [NSString stringWithFormat:@"%@-%@-%@",UserInfoData.Province,UserInfoData.City,UserInfoData.Area];
            }
                break;
                
            case 6:
            {
                infoCell.titleLab.text = @"街道";
                infoCell.contentLab.text = [NSString stringWithFormat:@"%@",UserInfoData.Address];
            }
                break;
                
            default:
                break;
        }
        
        return infoCell;
    }
    
    
}
#pragma mark ------------UITableViewDelegate--------------
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 60.0f;
    }else{
        return 44.0f;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            //修改头像
            [self selectHeadImage];
        }
            break;
            
        case 1:
        {
            NSLog(@"修改昵称");
            MyTSMResetViewController *resetVC = [[MyTSMResetViewController alloc] init];
            resetVC.navTitle = @"修改昵称";
            resetVC.sendTag = 201;
            [self.navigationController pushViewController:resetVC animated:YES];
            
        }
            break;
            
        case 2:
        {
            //修改性别
            [self selectSex];
        }
            break;
            
        case 3:
        {
            NSLog(@"修改年龄");
            MyTSMResetViewController *resetVC = [[MyTSMResetViewController alloc] init];
            resetVC.navTitle = @"修改年龄";
            resetVC.sendTag = 203;
            [self.navigationController pushViewController:resetVC animated:YES];
        }
            break;
            
        case 4:
        {
            NSLog(@"修改手机号");
            MyTSMResetViewController *resetVC = [[MyTSMResetViewController alloc] init];
            resetVC.navTitle = @"修改手机号";
            resetVC.sendTag = 204;
            [self.navigationController pushViewController:resetVC animated:YES];
        }
            break;
            
        case 5:
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                [bgView setFrame:CGRectMake(0, ScreenHeight - (162 + Navbar_Height*2), Main_Size.width, 162 + Navbar_Height*2)];
            }];
            
        }
            break;
            
        case 6:
        {
            NSLog(@"修改街道");
            MyTSMResetViewController *resetVC = [[MyTSMResetViewController alloc] init];
            resetVC.navTitle = @"修改街道";
            resetVC.sendTag = 206;
            [self.navigationController pushViewController:resetVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(UILabel *)areaLb
{
    UILabel *areaLb = (UILabel *)[self.view viewWithTag:102];
    return areaLb;
}
#pragma mark ------------UIPickerViewDataSource-----------
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0: //省名
        {
            return provinceTitleArr.count;
        }
            break;
            
        case 1:
        {
            if(provinceTitleArr.count > 0){
                NSDictionary *currentCityDic = (NSDictionary *)provinceTitleArr[currentProvinceIndex];
                NSArray *currentCityArr = (NSArray *)currentCityDic[CITY_TITLE];
                return currentCityArr.count;
            }
        }
            break;
            
        case 2:
        {
            if(provinceTitleArr.count > 0){
                NSDictionary *currentCityDic = (NSDictionary *)provinceTitleArr[currentProvinceIndex];
                NSArray *currentCityArr = (NSArray *)currentCityDic[CITY_TITLE];
                if(currentCityArr.count > 0){
                    NSDictionary *currentCountyDic = (NSDictionary *)currentCityArr[currentCityIndex];
                    NSArray *currentCountyArr = (NSArray *)currentCountyDic[COUNTY_TITLE];
                    return currentCountyArr.count;
                }
            }
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0: //省名
        {
            return [provinceTitleArr[row] objectForKey:PROVINCE_TITLE];
        }
            break;
            
        case 1:
        {
            if(provinceTitleArr.count > 0){
                NSDictionary *currentCityDic = (NSDictionary *)provinceTitleArr[currentProvinceIndex];
                NSArray *currentCityArr = (NSArray *)currentCityDic[CITY_TITLE];
                return [currentCityArr[row] objectForKey:CITY_TITLE];
            }
        }
            break;
            
        case 2:
        {
            if(provinceTitleArr.count > 0){
                NSDictionary *currentCityDic = (NSDictionary *)provinceTitleArr[currentProvinceIndex];
                NSArray *currentCityArr = (NSArray *)currentCityDic[CITY_TITLE];
                if(currentCityArr.count > 0){
                    NSDictionary *currentCountyDic = (NSDictionary *)currentCityArr[currentCityIndex];
                    NSArray *currentCountyArr = (NSArray *)currentCountyDic[COUNTY_TITLE];
                    return currentCountyArr[row];
                }
            }
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component)  {
        case 0:
        {
            currentProvinceIndex = row;
            currentCityIndex = 0;
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            
            if(provinceTitleArr.count > 0){
                NSDictionary *currentCityDic = (NSDictionary *)provinceTitleArr[currentProvinceIndex];
                NSArray *currentCityArr = (NSArray *)currentCityDic[CITY_TITLE];
                if(currentCityArr.count > 0){
                    NSDictionary *currentCountyDic = (NSDictionary *)currentCityArr[currentCityIndex];
                    NSArray *currentCountyArr = (NSArray *)currentCountyDic[COUNTY_TITLE];
                    
                    selectProvince  = [provinceTitleArr[row] objectForKey:PROVINCE_TITLE];
                    selectCity      = [currentCityArr[0] objectForKey:CITY_TITLE];
                    selectCounty    = currentCountyArr[0];
                }
            }
        }
            break;
            
        case 1:
        {
            currentCityIndex = row;
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            
            
            if(provinceTitleArr.count > 0){
                NSDictionary *currentCityDic = (NSDictionary *)provinceTitleArr[currentProvinceIndex];
                NSArray *currentCityArr = (NSArray *)currentCityDic[CITY_TITLE];
                if(currentCityArr.count > 0){
                    NSDictionary *currentCountyDic = (NSDictionary *)currentCityArr[currentCityIndex];
                    NSArray *currentCountyArr = (NSArray *)currentCountyDic[COUNTY_TITLE];
                    
                    selectCity      = [currentCityArr[row] objectForKey:CITY_TITLE];
                    selectCounty    = currentCountyArr[0];
                }
            }
        }
            break;
            
        case 2:
        {
            if(provinceTitleArr.count > 0){
                NSDictionary *currentCityDic = (NSDictionary *)provinceTitleArr[currentProvinceIndex];
                NSArray *currentCityArr = (NSArray *)currentCityDic[CITY_TITLE];
                if(currentCityArr.count > 0){
                    NSDictionary *currentCountyDic = (NSDictionary *)currentCityArr[currentCityIndex];
                    NSArray *currentCountyArr = (NSArray *)currentCountyDic[COUNTY_TITLE];
                    
                    selectCounty = currentCountyArr[row];
                }
            }
        }
            break;
            
        default:
            break;
    }
    
    NSLog(@"选择了 %@省  %@市 %@县/区",selectProvince,selectCity,selectCounty);
    
    [[self areaLb] setText:[NSString stringWithFormat:@"%@-%@-%@",selectProvince,selectCity,selectCounty]];
}



#pragma mark ----------头像修改------------------------
-(void)selectHeadImage
{
     NSLog(@"换头像");
    [self.pageActionSheet showInView:self.view];
}

#pragma mark ------------头像选择弹出框---------------
- (UIActionSheet *)pageActionSheet
{
    if(!_pageActionSheet) {
        _pageActionSheet = [[UIActionSheet alloc]
                            initWithTitle:nil
                            delegate:self
                            cancelButtonTitle:nil
                            destructiveButtonTitle:nil
                            otherButtonTitles:nil];
        _pageActionSheet.tag = 20;
        
//        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//        {
//            [_pageActionSheet addButtonWithTitle:NSLocalizedString(@"拍照", @"")];
//        }
        [_pageActionSheet addButtonWithTitle:NSLocalizedString(@"拍照", @"")];
        [_pageActionSheet addButtonWithTitle:NSLocalizedString(@"从相册中选择", @"")];
        
        [_pageActionSheet addButtonWithTitle:NSLocalizedString(@"取消", @"")];
        _pageActionSheet.cancelButtonIndex = [self.pageActionSheet numberOfButtons]-1;
    }
    return _pageActionSheet;
}
#pragma mark ------------------------ UIActionSheetDelegate------------------
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 20) {
        NSString *actTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
        if ([actTitle isEqualToString:@"拍照"])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate = self;
            picker.allowsEditing = YES;
            
            [self presentModalViewController:picker animated:YES];
        }
        else if([actTitle isEqualToString:@"从相册中选择"])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            picker.allowsEditing = YES;
            
            [self presentModalViewController:picker animated:YES];
        }
        self.pageActionSheet = nil;
        
    }else if (actionSheet.tag == 21){
        
        UILabel *sexLab = (UILabel *)[self.view viewWithTag:101];
        switch (buttonIndex) {
            case 0:
            {
                sexLab.text = @"男";
                NSDictionary *parameters = @{@"u":UserInfoData.im,@"UserLogin":UserInfoData.im,@"clientkey":UserInfoData.clientkey,@"Sex":sexLab.text};
                [self resetInfoWithParameter:parameters];
            }
                break;
            case 1:
            {
                sexLab.text = @"女";
                 NSDictionary *parameters = @{@"u":UserInfoData.im,@"UserLogin":UserInfoData.im,@"clientkey":UserInfoData.clientkey,@"Sex":sexLab.text};
                [self resetInfoWithParameter:parameters];
            }
                break;
                
            default:
                break;
        }
        
    }else{
        
    }
    
}
#pragma -mark ---------------------相片选取相关-----------------------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    //图片压缩
    UIImage *renderedImage = [image rotate];
    renderedImage = [renderedImage resizedImageWithContentMode:UIViewContentModeScaleAspectFill
                                                        bounds:CGSizeMake(80, 80)
                                          interpolationQuality:kCGInterpolationDefault];
    self.userImage = renderedImage;
//    UIImageView *headImageView = (UIImageView *)[self.view viewWithTag:1000];
//    headImageView.image = renderedImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self upDateHeadImage];
}
#pragma mark ---------------头像数据上传-----------------
-(void)upDateHeadImage
{
    NSData *pictureData = nil;
    if (self.userImage) {
        pictureData = UIImagePNGRepresentation(self.userImage);
    }
    
    NSDictionary *dic = @{@"clientkey":UserInfoData.clientkey,@"UserLogin":UserInfoData.im};
    
    [HttpRequest_MyApi POSTURLString:@"/User/updateavatarfile/" parameters:dic imageData:pictureData success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSLog(@"responseObject == %@",responseObject);
        
        UIImageView *headImageView = (UIImageView *)[self.view viewWithTag:1000];
        if ([responseObject[@"state"] boolValue]) {
             NSDictionary *dataDic = (NSDictionary *)[responseObject[@"data"] objectFromJSONString];
            if ([dataDic[@"result"] boolValue]) {
                 NSLog(@"头像更新成功");
                
                [headImageView sd_setImageWithURL:[NSURL URLWithString:dataDic[@"fileurl"]] placeholderImage:[UIImage imageNamed:default_head] options:SDWebImageRefreshCached];
            }
            
            [[GlobalMethod sharedInstance] reloadUserInfoDataSuccess:^(NSString *status) {
                if ([status isEqualToString:@"success"]) {
                    NSLog(@"用户数据更新成功");
                }
            } failure:^{
                
            }];
            
        }else{
            [self showHUDInView:self.view WithText:[NSString stringWithFormat:@"%@:%@",responseObject[HTTP_ERRCODE],responseObject[HTTP_MSG]] andDelay:LOADING_TIME];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error == %@",error);
    }];
    
}

#pragma mark ----------------选择性别------------------
-(void)selectSex
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
    sheet.tag = 21;
    [sheet showInView:self.view];
    
}

#pragma mark ----------修改用户数据---------------
-(void)resetInfoWithParameter:(NSDictionary *)parameter
{
    [HttpRequest_MyApi POSTURLString:@"/User/update/" parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject == %@",responseObject);
        
        if ([responseObject[@"state"] boolValue]) {
            
            NSDictionary *dataDic = (NSDictionary *)[responseObject[@"data"] objectFromJSONString];
            NSLog(@"dataDic == %@",dataDic)
            
            if ([dataDic[@"result"] boolValue]) {
                
                NSLog(@"修改成功");
                
                //更新用户数据
                [[GlobalMethod sharedInstance] reloadUserInfoDataSuccess:^(NSString *status) {
                    if ([status isEqualToString:@"success"]) {
                        NSLog(@"用户数据更新成功");
                    }
                } failure:^{
                    
                }];
            }
            
        }else{
            [self showHUDInView:self.view WithText:[NSString stringWithFormat:@"%@:%@",responseObject[HTTP_ERRCODE],responseObject[HTTP_MSG]] andDelay:LOADING_TIME];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error == %@",error);
    }];
}

-(void)loadAreaData
{
    NSDictionary *dic = @{@"pid":@"0001",@"child":@"1"};
    
    [HttpRequest_MyApi GETURLString:@"/areas/list/" userCache:YES parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
        NSDictionary *rqDic = (NSDictionary *)responseObj;
        
        if([rqDic[HTTP_STATE] boolValue]){
            
            NSDictionary *countryDic = (NSDictionary *)[rqDic[HTTP_DATA] objectFromJSONString];
            
            NSArray *proArr = (NSArray *)countryDic[@"AChildData"];
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_group_t group = dispatch_group_create();
            
            for(int i=0; i<proArr.count; i++)
            {
                dispatch_group_async(group, queue, ^{
                    
                    NSDictionary *proDic = (NSDictionary *)proArr[i];
                    
                    NSArray *cityArr = (NSArray *)proDic[@"AChildData"];
                    NSMutableArray *cityTitleArr = [NSMutableArray arrayWithCapacity:10];
                    for(int i=0; i<cityArr.count; i++){
                        NSDictionary *cityDic = (NSDictionary *)cityArr[i];
                        
                        NSArray *countyArr = (NSArray *)cityDic[@"AChildData"];
                        NSMutableArray *countyTitleArr = [NSMutableArray arrayWithCapacity:10];
                        for(int i=0; i<countyArr.count; i++){
                            NSDictionary *countyDic = (NSDictionary *)countyArr[i];
                            [countyTitleArr addObject:countyDic[@"AName"]];
                        }
                        
                        NSDictionary *city_countyDic = @{CITY_TITLE:cityDic[@"AName"], COUNTY_TITLE:countyTitleArr};
                        
                        [cityTitleArr addObject:city_countyDic];
                    }
                    
                    NSDictionary *pro_cityDic = @{PROVINCE_TITLE:proDic[@"AName"],CITY_TITLE:cityTitleArr};
                    
                    /*
                     解构：provinceTitleArr{ "PROVINCE_TITLE":"省名",
                     "CITY_TITLE":{ CITY_TITLE:@"城市名", COUNTY_TITLE : @"县/区 名数组" }
                     }
                     */
                    
//                    NSLog(@"pro_cityDic == %@",pro_cityDic);
                    [provinceTitleArr addObject:pro_cityDic];
                });
                
                dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
            }
            
        }
        
        [areaPickView reloadAllComponents];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden  = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
