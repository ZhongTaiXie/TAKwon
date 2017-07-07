//
//
// 作者:邓琪 QQ:350218638 gitHub:https://github.com/DQ-qi/DQAddress
//
#import "DQAreasView.h"
#import "DQCanCerEnsureView.h"
#import <Masonry.h>
#import "WQNetWorkManager.h"
#import "TACityModel.h"
#import "TAProviceModel.h"
#import "TACountryModel.h"

@interface DQAreasView ()<DQCanCerEnsureViewDelegate>
@property (nonatomic, copy) NSDictionary *areasDict;
@property (nonatomic, strong)DQCanCerEnsureView *CancerEnsure;
@property (strong, nonatomic) NSDictionary *selectedDict;
@property (strong,nonatomic) UIPickerView * pickerView;
@property (nonatomic, strong) UITapGestureRecognizer *ges;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIView *backView;
@end
@implementation DQAreasView
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0,0, KTA_Screen_Width, KTA_Screen_Height);
        self.window = [[[UIApplication sharedApplication] delegate] window];
        [self.window addSubview:self];
        UIView *blackView1 = [UIView new];
        blackView1.backgroundColor = [WQTools colorWithHexString:@"000000"];
        blackView1.alpha = 0.6f;
        blackView1.frame = CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height);
        [self addSubview:blackView1];
        self.ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GestureCloseSelectViewAnimation:)];
        [self.window bringSubviewToFront:self];
        [blackView1 addGestureRecognizer:self.ges];
        self.backView = [UIView new];
        self.backView.backgroundColor = [UIColor whiteColor];
        self.backView.frame = CGRectMake(0, KTA_Screen_Height, KTA_Screen_Width, 260);
        [self addSubview:self.backView];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *dic = [userDefaults objectForKey:@"cityListJson"];
        if (dic) {
            [self getProviencesArrayByDic:dic];
        }else{
            [self getDataFromServer];//获取地区字典数据
        }
        
        self.hidden = YES;
    }
    return self;
}

//获取地区字典数据
-(void)getDataFromServer{
    NSString *url = [HeadUrl stringByAppendingString:@"Center/AreaList"];
    [WQNetWorkManager sendPostRequestWithUrl:url parameters:nil success:^(NSDictionary *dic) {
        
        if (dic[@"Data"][@"Success"]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:dic forKey:@"cityListJson"];
            [userDefaults synchronize];
            
            [self getProviencesArrayByDic:dic[@"Data"][@"Data"]];
        }else{
            [MBProgressHUD showError:dic[@"error"][@"info"]];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)getProviencesArrayByDic:(NSDictionary *)dic{
    NSArray *array = dic[@"provincelist"];
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *provienceDic in array) {
        TAProviceModel *provienceModel = [TAProviceModel initProvinceModelWithDic:provienceDic];
        [mutableArray addObject:provienceModel];
    }
    [self creadedtionSubview:[mutableArray mutableCopy]];
}

//配置选择器UI
-(void)creadedtionSubview:(NSArray *)provienceArray{
    //解析数据
    self.ProvinceArr = provienceArray;
    NSString *ProvinceStr = [self.ProvinceArr objectAtIndex:0];
    self.selectedDict = [self.areasDict objectForKey:ProvinceStr];
    
    [self calculateCityArrAndCounty:0 andRow:0];
    _CancerEnsure = [[DQCanCerEnsureView alloc]init];
    [_CancerEnsure setTitleText:@""];
    _CancerEnsure.delegate = self;
    UIView *sub = self.backView;
    [sub  addSubview:_CancerEnsure];
    [_CancerEnsure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub);
        make.left.equalTo(sub);
        make.right.equalTo(sub);
        make.height.mas_equalTo(45);
    }];
    
    self.pickerView = [UIPickerView new];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.showsSelectionIndicator = YES;
    [sub addSubview:self.pickerView];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub.mas_top).offset(45);
        make.left.equalTo(sub);
        make.right.equalTo(sub);
        make.bottom.equalTo(sub);
    }];
    
}

//及时更新数据
- (void)calculateCityArrAndCounty:(NSInteger )section andRow:(NSInteger )row{
    if (section == 0) {
        if (self.ProvinceArr.count > row) {
            NSString *ProvinceStr = [self.ProvinceArr objectAtIndex:row];
            self.selectedDict = [self.areasDict objectForKey:ProvinceStr];
            self.cityArr = [self.selectedDict allKeys];
            NSString *countyStr = [self.cityArr firstObject];
            self.countyArr = [self.selectedDict objectForKey:countyStr];
        }
        
    }else if(section == 1){
        if (self.cityArr.count>row) {
            NSString *countyStr = self.cityArr[row];
            self.countyArr = [self.selectedDict objectForKey:countyStr];
        }
    }else{
    }
}
#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;//两组
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.ProvinceArr.count;
    } else if (component == 1) {
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        TAProviceModel*model =  self.ProvinceArr[rowProvince];
        return model.CityList.count;
        
    } else {
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        TAProviceModel *model = self.ProvinceArr[rowProvince];
        if(model.CityList.count == 0){
            return 0;
        }else{
            TACityModel *cityModel = model.CityList[rowCity];
            return cityModel.CountryList.count;
        }
        
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (0 == component){
        TAProviceModel *model = self.ProvinceArr[row];
        return model.Name;
    }else if(1 == component){
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        TAProviceModel *model = self.ProvinceArr[rowProvince];
        TACityModel *cityModel = model.CityList[row];
        return cityModel.Name;
    }else{
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        TAProviceModel *model = self.ProvinceArr[rowProvince];
        TACityModel *cityModel = model.CityList[rowCity];
        TACountryModel *areaModel = cityModel.CountryList[row];
        return areaModel.Name;
    }
    
    
//    else if (component == 1){
//        
//    } else{
//        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
//        TAProviceModel *model = self.ProvinceArr[rowProvince];
//        if (row >= model.CityList.count) {
//            return @"";
//        }else{
//            TACityModel *cityModel = model.CityList[row];
//            return cityModel.Name;
//        }
//        
//    }
}

//-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    UILabel *lable = [[UILabel alloc]init];
//    lable.textAlignment = NSTextAlignmentCenter;
////    lable.backgroundColor = [UIColor redColor];
//    lable.font=[UIFont systemFontOfSize:15];
//    if (component == 0) {
//        TAProviceModel *model = self.ProvinceArr[row];
//        lable.text = model.Name;
//    } else if (component == 1) {
//        TACityModel *cityModel = self.cityArr[row];
//        lable.text = cityModel.Name;
//    } else if(component == 2){
//        if (self.countyArr.count>row) {
//            TACountryModel *countryModel = self.countyArr[row];
//            lable.text = countryModel.Name;
//
//        }
//    }
//    return lable;
//}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return KTA_Screen_Width/3;
    } else if (component == 1) {
        return KTA_Screen_Width/3;
    } else {
        return KTA_Screen_Width/3;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 41;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if(0 == component) {
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        
    }
    if(1 == component) {
        [pickerView reloadComponent:2];
    }
    
    NSInteger selectOne = [pickerView selectedRowInComponent:0];
    NSInteger selectTwo = [pickerView selectedRowInComponent:1];
    NSInteger selectThree = [pickerView selectedRowInComponent:2];
    
    TAProviceModel *model = self.ProvinceArr[selectOne];
    if (model.CityList.count == 0) {
        
    }else{
        TACityModel *cityModel = model.CityList[selectTwo];
        TACountryModel *areaModel;
        if (cityModel.CountryList.count == 0 ){
            
        }else{
            areaModel = cityModel.CountryList[selectThree];
        }
    }
    
    
    
    //    NSLog(@"%@",[NSString stringWithFormat:@"%@ %@ %@",model.name,cityModel.name,areaModel.name.length == 0 ? @"" : areaModel.name]);
}

- (void)ClickCancerDelegateFunction{
    
    [self CloseAnimationFunction];
    
}


//点击确定按钮的回调，将选的东西传回去
- (void)ClickEnsureDelegateFunction{
    
    NSInteger selectOne = [self.pickerView selectedRowInComponent:0];
    NSInteger selectTwo = [self.pickerView selectedRowInComponent:1];
    NSInteger selectThree = [self.pickerView selectedRowInComponent:2];
    
    TAProviceModel *provincemodel = self.ProvinceArr[selectOne];
    TACityModel *cityModel = provincemodel.CityList[selectTwo];
    
    TACountryModel *areaModel;
    if (cityModel.CountryList.count == 0) {
        
    }else{
        areaModel = cityModel.CountryList[selectThree];
    }
    
    [self CloseAnimationFunction];
    if ([self.delegate respondsToSelector:@selector(clickAreasViewEnsureBtnActionAreaStr:cityCode:)]) {
        [self.delegate clickAreasViewEnsureBtnActionAreaStr:[NSString stringWithFormat:@"%@%@%@",provincemodel.Name,cityModel.Name,areaModel.Name] cityCode:[NSString stringWithFormat:@"%@",areaModel.Id]];
    }
}
- (void)startAnimationFunction{
    UIView *AnView = self.backView;
    self.hidden = NO;
    CGRect rect = AnView.frame;
    rect.origin.y = KTA_Screen_Width + 40;
    [self.window bringSubviewToFront:self];
    [UIView animateWithDuration:0.4 animations:^{
        
        AnView.frame = rect;
    }];
    
}
- (void)CloseAnimationFunction{
    
    UIView *AnView = self.backView;
    CGRect rect = AnView.frame;
    rect.origin.y = KTA_Screen_Height;
    [UIView animateWithDuration:0.4f animations:^{
        AnView.frame = rect;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
}

- (void)GestureCloseSelectViewAnimation:(UIGestureRecognizer *)ges{
    
    [self CloseAnimationFunction];
}

- (void)dealloc{
    
    self.ges = nil;
    
}
@end
