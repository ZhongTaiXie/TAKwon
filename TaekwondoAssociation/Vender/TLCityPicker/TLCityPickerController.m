//
//  TLCityPickerController.m
//  TLCityPickerDemo
//
//  Created by 李伯坤 on 15/11/5.
//  Copyright © 2015年 李伯坤. All rights reserved.
//

#import "TLCityPickerController.h"
#import "TLCityPickerSearchResultController.h"
#import "TLCityHeaderView.h"
#import "TLCityGroupCell.h"
#import "IQKeyboardManager.h"
#import "WXCommonViewClass.h"
#import <CoreLocation/CoreLocation.h>

@interface TLCityPickerController () <TLCityGroupCellDelegate, TLSearchResultControllerDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
}
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) TLCityPickerSearchResultController *searchResultVC;

@property (nonatomic, strong) NSMutableArray *cityData;
@property (nonatomic, strong) NSMutableArray *localCityData;
@property (nonatomic, strong) NSMutableArray *hotCityData;
@property (nonatomic, strong) NSMutableArray *commonCityData;
@property (nonatomic, strong) NSMutableArray *arraySection;

@end

@implementation TLCityPickerController
@synthesize data = _data;
@synthesize commonCitys = _commonCitys;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startLocation];
    [self.navigationItem setTitle:@"城市选择"];
    [self.tableView setTableHeaderView:self.searchController.searchBar];
//    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonDown:)];
    
//    [self.navigationItem setLeftBarButtonItem:cancelBarButton];
    
    
    //关闭按钮
    UIButton * closeBtn = [WXCommonViewClass getRightBtnOfNav:nil hightlightedImageName:nil title:@"取消"];
    [closeBtn setTitleColor:RGB(21, 126, 251) forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(0, 0, 35, 35);
    [closeBtn addTarget:self action:@selector(cancelButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:closeBtn];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    
    [self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [self.tableView setSectionIndexColor:[UIColor blackColor]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerClass:[TLCityGroupCell class] forCellReuseIdentifier:@"TLCityGroupCell"];
    [self.tableView registerClass:[TLCityHeaderView class] forHeaderFooterViewReuseIdentifier:@"TLCityHeaderView"];
    self.tableView.sectionIndexColor = RGB(0, 125, 251);
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];//设置状态栏字体为黑色
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];//设置状态栏字体为白色
}
#pragma mark - public

- (void)startLocation
{
    if([CLLocationManager locationServicesEnabled]){
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = 5;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;//kCLLocationAccuracyBest;
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            [_locationManager requestWhenInUseAuthorization];
        }
        [_locationManager startUpdatingLocation];
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations

{
    
    CLLocation *newLocation = locations[0];
    
    CLLocationCoordinate2D oldCoordinate = newLocation.coordinate;
    
    NSLog(@"旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
    
    
    
    [manager stopUpdatingLocation];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> *_Nullable placemarks, NSError * _Nullable error) {
        
        
        
        for (CLPlacemark *place in placemarks) {
            
            NSLog(@"name,%@",place.name);                      // 位置名
            
            NSLog(@"thoroughfare,%@",place.thoroughfare);      // 街道
            
            NSLog(@"subThoroughfare,%@",place.subThoroughfare);// 子街道
            _localCityData = [[NSMutableArray alloc]initWithObjects:place.locality, nil];
            [self.tableView reloadData];
            NSLog(@"locality,%@",place.locality);
            // 市
            
            NSLog(@"subLocality,%@",place.subLocality);        // 区
            
            NSLog(@"country,%@",place.country);                // 国家
            //            if (_gpsCityName) {
            //                <#statements#>
            //            }
            //            if ([JudgeIDAndBankCard isEmptyOrNull:_gpsCityName]) {
            //                _gpsCityName=@"定位失败";
            //            }
            //            WRITE_DATA(place.locality,@"CITY_JC_NAME");
            //            [self.mytableviewreloadData];
            
        }
        
    }];
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [_locationManager requestWhenInUseAuthorization];
            }
            break;
        case kCLAuthorizationStatusDenied:
        {
            
        }
        default:
            break;
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{ //此方法为定位失败的时候调用。并且由于会在失败以后重新定位，所以必须在末尾停止更新
    
    if(error.code == kCLErrorLocationUnknown)
    {
        NSLog(@"Currently unable to retrieve location.");
    }
    else if(error.code == kCLErrorNetwork)
    {
        NSLog(@"Network used to retrieve location is unavailable.");
    }
    else if(error.code == kCLErrorDenied)
    {
        NSLog(@"Permission to retrieve location is denied.");
        [manager stopUpdatingLocation];
    }
    
    
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    
//    return UIStatusBarStyleLightContent;
//    
//}
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count + 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 3) {
        return 1;
    }
    TLCityGroup *group = [self.data objectAtIndex:section - 3];
    return group.arrayCitys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 3) {
        TLCityGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLCityGroupCell"];
        if (indexPath.section == 0) {
            [cell setTitle:@"定位城市"];
            [cell setCityArray:_localCityData];
        }
        else if (indexPath.section == 1) {
            [cell setTitle:@"最近访问"];
            [cell setCityArray:self.commonCityData];
        }
        else {
            [cell setTitle:@"热门城市"];
            [cell setCityArray:self.hotCityData];
        }
        [cell setDelegate:self];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    TLCityGroup *group = [self.data objectAtIndex:indexPath.section - 3];
    TLCity *city =  [group.arrayCitys objectAtIndex:indexPath.row];
    [cell.textLabel setText:city.cityName];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section < 3) {
        return nil;
    }
    TLCityHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TLCityHeaderView"];
    NSString *title = [_arraySection objectAtIndex:section - 2];
    [headerView setTitle:title];
    return headerView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [TLCityGroupCell getCellHeightOfCityArray:self.localCityData];
    }
    else if (indexPath.section == 1) {
        return [TLCityGroupCell getCellHeightOfCityArray:self.commonCityData];
    }
    else if (indexPath.section == 2){
        return [TLCityGroupCell getCellHeightOfCityArray:self.hotCityData];
    }
    return 43.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section < 3) {
        return 0.0f;
    }
    return 23.5f;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section < 3) {
        return;
    }
    TLCityGroup *group = [self.data objectAtIndex:indexPath.section - 3];
    TLCity *city = [group.arrayCitys objectAtIndex:indexPath.row];
    [self didSelctedCity:city];
}

- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.arraySection;
}

- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if(index == 0) {
        [self.tableView scrollRectToVisible:self.searchController.searchBar.frame animated:NO];
        return -1;
    }
    return index+2;
}

#pragma mark TLCityGroupCellDelegate
- (void) cityGroupCellDidSelectCity:(TLCity *)city
{
    [self didSelctedCity:city];
}

#pragma mark TLSearchResultControllerDelegate
- (void) searchResultControllerDidSelectCity:(TLCity *)city
{
    [self.searchController dismissViewControllerAnimated:YES completion:^{
        
    }];
    [self didSelctedCity:city];
}

#pragma mark - Event Response
- (void) cancelButtonDown:(UIBarButtonItem *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(cityPickerControllerDidCancel:)]) {
        [_delegate cityPickerControllerDidCancel:self];
    }
}

#pragma mark - Private Methods
- (void) didSelctedCity:(TLCity *)city
{
    if (_delegate && [_delegate respondsToSelector:@selector(cityPickerController:didSelectCity:)]) {
        [_delegate cityPickerController:self didSelectCity:city];
    }
    
    if (self.commonCitys.count >= MAX_COMMON_CITY_NUMBER) {
        [self.commonCitys removeLastObject];
    }
    for (NSString *str in self.commonCitys) {
        if ([city.cityID isEqualToString:str]) {
            [self.commonCitys removeObject:str];
            break;
        }
    }
    [self.commonCitys insertObject:city.cityID atIndex:0];
    [[NSUserDefaults standardUserDefaults] setValue:self.commonCitys forKey:COMMON_CITY_DATA_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Setter
- (void) setCommonCitys:(NSMutableArray *)commonCitys
{
    _commonCitys = commonCitys;
    if (commonCitys != nil && commonCitys.count > 0) {
        [[NSUserDefaults standardUserDefaults] setValue:commonCitys forKey:COMMON_CITY_DATA_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark - Getter 
- (UISearchController *) searchController
{
    if (_searchController == nil) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultVC];
        [_searchController.searchBar setPlaceholder:@"输入城市名或拼音查询"];
        [_searchController.searchBar setBarTintColor:[UIColor colorWithWhite:0.95 alpha:1.0]];
        [_searchController.searchBar sizeToFit];
        [_searchController setSearchResultsUpdater:self.searchResultVC];
        [_searchController.searchBar.layer setBorderWidth:0.5f];
        [_searchController.searchBar.layer setBorderColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
        _searchController.searchBar.backgroundImage = [UIImage imageNamed:@"searchback"];
        UITextField *searchField=[_searchController.searchBar valueForKey:@"_searchField"];
        searchField.backgroundColor = RGB(235, 236, 238);
    }
    return _searchController;
}

- (TLCityPickerSearchResultController *) searchResultVC
{
    if (_searchResultVC == nil) {
        _searchResultVC = [[TLCityPickerSearchResultController alloc] init];
        _searchResultVC.cityData = self.cityData;
        _searchResultVC.searchResultDelegate = self;
    }
    return _searchResultVC;
}

- (NSMutableArray *) data
{
    if (_data == nil) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CityData" ofType:@"plist"]];
        _data = [[NSMutableArray alloc] init];
        for (NSDictionary *groupDic in array) {
            TLCityGroup *group = [[TLCityGroup alloc] init];
            group.groupName = [groupDic objectForKey:@"initial"];
            for (NSDictionary *dic in [groupDic objectForKey:@"citys"]) {
                TLCity *city = [[TLCity alloc] init];
                city.cityID = [dic objectForKey:@"city_key"];
                city.cityName = [dic objectForKey:@"city_name"];
                city.shortName = [dic objectForKey:@"short_name"];
                city.pinyin = [dic objectForKey:@"pinyin"];
                city.initials = [dic objectForKey:@"initials"];
                [group.arrayCitys addObject:city];
                [self.cityData addObject:city];
            }
            [self.arraySection addObject:group.groupName];
            [_data addObject:group];
        }
    }
    return _data;
}

- (NSMutableArray *) cityData
{
    if (_cityData == nil) {
        _cityData = [[NSMutableArray alloc] init];
    }
    return _cityData;
}

//- (NSMutableArray *) localCityData
//{
//    if (_localCityData == nil) {
//        _localCityData = [[NSMutableArray alloc] init];
//        if (self.locationCityID != nil) {
//            TLCity *city = nil;
//            for (TLCity *item in self.cityData) {
//                if ([item.cityID isEqualToString:self.locationCityID]) {
//                    city = item;
//                    break;
//                }
//            }
//            if (city == nil) {
//                NSLog(@"Not Found City: %@", self.locationCityID);
//            }
//            else {
//                [_localCityData addObject:city];
//            }
//        }
//    }
//    return _localCityData;
//}

- (NSMutableArray *) hotCityData
{
    if (_hotCityData == nil) {
        _hotCityData = [[NSMutableArray alloc] init];
        for (NSString *str in self.hotCitys) {
            TLCity *city = nil;
            for (TLCity *item in self.cityData) {
                if ([item.cityID isEqualToString:str]) {
                    city = item;
                    break;
                }
            }
            if (city == nil) {
                NSLog(@"Not Found City: %@", str);
            }
            else {
                [_hotCityData addObject:city];
            }
        }
    }
    return _hotCityData;
}

- (NSMutableArray *) commonCityData
{
    if (_commonCityData == nil) {
        _commonCityData = [[NSMutableArray alloc] init];
        for (NSString *str in self.commonCitys) {
            TLCity *city = nil;
            for (TLCity *item in self.cityData) {
                if ([item.cityID isEqualToString:str]) {
                    city = item;
                    break;
                }
            }
            if (city == nil) {
                NSLog(@"Not Found City: %@", str);
            }
            else {
                [_commonCityData addObject:city];
            }
        }
    }
    return _commonCityData;
}

- (NSMutableArray *) arraySection
{
    if (_arraySection == nil) {
        _arraySection = [[NSMutableArray alloc] initWithObjects:@"#", nil];
    }
    return _arraySection;
}

- (NSMutableArray *) commonCitys
{
    if (_commonCitys == nil) {
        NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:COMMON_CITY_DATA_KEY];
        _commonCitys = (array == nil ? [[NSMutableArray alloc] init] : [[NSMutableArray alloc] initWithArray:array copyItems:YES]);
    }
    return _commonCitys;
}

@end
