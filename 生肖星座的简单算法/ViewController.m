//
//  ViewController.m
//  生肖星座的简单算法
//
//  Created by ZZWangtao on 14-12-15.
//  Copyright (c) 2014年 ZZWangtao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UILabel *age;
@property (strong, nonatomic) IBOutlet UILabel *zodiac;
@property (strong, nonatomic) IBOutlet UILabel *constellation;
@property (strong, nonatomic) NSDate* birthday;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datePicker.datePickerMode = UIDatePickerModeDate;
    
    [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];

}
//时间选择器值改变的时候响应
-(void)dateChanged:(id)sender{
    UIDatePicker* control = (UIDatePicker*)sender;
    self.birthday = control.date;
    
    [self getAgeWith:self.birthday];
    
    [self getConstellationFromBirthday:self.birthday];
    
    [self getZodiacWith:self.birthday];
    
}

//根据生日得到年龄
- (void)getAgeWith:(NSDate*)birthday{

    //日历
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSUInteger unitFlags = NSCalendarUnitYear;
    
    NSDateComponents *components = [gregorian components:unitFlags fromDate:birthday toDate:[NSDate  date] options:0];

    self.age.text = [NSString stringWithFormat:@"%ld岁了",[components year]+1];
}
//根据生日得到星座
- (void)getConstellationFromBirthday:(NSDate*)birthday{

    NSCalendar *myCal = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comp1 = [myCal components:NSCalendarUnitMonth| NSCalendarUnitDay fromDate:birthday];
    
    NSInteger month = [comp1 month];
    
    
    NSInteger day = [comp1 day];
    
    self.constellation.text = [self getAstroWithMonth:month day:day];
}
//根据生日得到生肖
- (void)getZodiacWith:(NSDate*) birthday{

    NSCalendar *myCal = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comp1 = [myCal components:NSCalendarUnitYear fromDate:birthday];
    
    NSInteger year = [comp1 year];

    self.zodiac.text = [self  getZodiacWithYear:year];
}

//得到生肖的算法
-(NSString *)getZodiacWithYear:(NSInteger)y{
    if (y <0) {
        return @"错误日期格式!!!";
    }
    
    NSString *zodiacString = @"鼠牛虎兔龙蛇马羊猴鸡狗猪";
    
    NSRange range = NSMakeRange ((y+9)%12-1, 1);
    
    NSString*  result = [zodiacString  substringWithRange:range];
    
    return [result stringByAppendingString:@"年"];
    
}
//得到星座的算法
-(NSString *)getAstroWithMonth:(NSInteger)m day:(NSInteger)d{
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    
    NSString *astroFormat = @"102123444543";
    
    NSString *result;
    
    if (m<1||m>12||d<1||d>31){
        
        return @"错误日期格式!";
        
    }
    
    if(m==2 && d>29)
        
    {
        
        return @"错误日期格式!!";
        
    }else if(m==4 || m==6 || m==9 || m==11) {
        
        if (d>30) {
            
            return @"错误日期格式!!!";
            
        }
        
    }
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    
    return [result stringByAppendingString:@"座"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
