//
//  LabWithLinesViewCell.m
//  TABAnimatedDemo
//
//  Created by tigerAndBull on 2018/10/22.
//  Copyright © 2018年 tigerAndBull. All rights reserved.
//

#import "LabWithLinesViewCell.h"

@import TABAnimated;

#import "Game.h"
#import "TABDefine.h"
#import "UILabel+TABCategory.h"

@interface LabWithLinesViewCell () {
    UIImageView *gameImg;
    UILabel *titleLab;
}

@end

@implementation LabWithLinesViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat gameImageWidth = (self.frame.size.height - 20) * 1.5;
    CGFloat titleLabelWidth = kScreenWidth - gameImageWidth- 15 - 15 - 10;
    // 获取对应组件文本大小
    CGRect rect = [titleLab.text
                        boundingRectWithSize:CGSizeMake(titleLabelWidth, MAXFLOAT)
                        options:NSStringDrawingUsesLineFragmentOrigin
                        attributes:@{
                         NSFontAttributeName : titleLab.font
                        }
                        context:nil];
    // 布局
    gameImg.frame = CGRectMake(15, 10, gameImageWidth, (self.frame.size.height - 20));
    gameImg.layer.cornerRadius = 5;
    titleLab.frame = CGRectMake(CGRectGetMaxX(gameImg.frame) + 15, 10, titleLabelWidth, rect.size.height);
}

#pragma mark - Public Methods

- (void)initWithData:(Game *)game {
    titleLab.text = [NSString stringWithFormat:@"%@",game.title];
    titleLab.lineSpace = 5;
    [gameImg setImage:[UIImage imageNamed:@"test.jpg"]];
}

#pragma mark - Initize Methods

- (void)initUI {
    
    {
        UIImageView *iv = [[UIImageView alloc] init];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.layer.masksToBounds = YES;
        
        gameImg = iv;
        [self.contentView addSubview:iv];
    }
    
    {
        UILabel *lab = [[UILabel alloc]init];
        [lab setFont:kFont(15)];
        lab.tag = 1000;
        lab.numberOfLines = 3;
        [lab setTextColor:[UIColor blackColor]];
        
        titleLab = lab;
        [self.contentView addSubview:lab];
    }
}

@end
