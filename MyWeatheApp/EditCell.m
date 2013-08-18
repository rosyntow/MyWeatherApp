//
//  EditCell.m
//  MyWeatheApp
//
//  Created by Rosina Otchere-Nyarko on 8/17/13.
//  Copyright (c) 2013 xperttech. All rights reserved.
//

#import "EditCell.h"

@interface EditCell()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UIButton *button;

@end;

@implementation EditCell


+ (id)newCellWithDelegate:(id <EditCellDelegate>)delegate andText:(NSString *)text forProperty:(NSString *)property{
    EditCell *cell = [[EditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:property];
    cell.property = property;
    cell.text = text;
    cell.delegate = delegate;
    
    return cell;

}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

                
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if(self.type == EditCellTypeButton)
    {
        self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.button setTitle:self.property forState:UIControlStateNormal];
        [self.button setFrame:CGRectMake(140, 5, 50, 30)];
        [self addSubview:self.button];
    }else if(self.type == EditCellTypeTextResult)
    {
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(60, 5, 150, 50)];
        [self addSubview:self.textField];
        [self.textField setDelegate:self];
        
        
    }else if(self.type == EditCellTypeLabel){
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 150, 30)];
        [self.label setText:[NSString stringWithFormat:@"%@",self.property]];
        [self.label setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.label];
    }else if(self.type == EditTextTableCellTypeNotEditable){
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 7, 150, 30)];
        [self.textField setText:[NSString stringWithFormat:@"%@",self.text]];
        self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.button setTitle:@"GO" forState:UIControlStateNormal];
        [self.button setFrame:CGRectMake(210, 7, 50, 30)];
        [self addSubview:self.label];
        [self addSubview:self.textField];
        [self addSubview:self.button];
        
        [self.textField setBorderStyle:UITextBorderStyleRoundedRect];
        [self.textField setPlaceholder:[NSString stringWithFormat:@"%@",self.property]];
        [self.textField setDelegate:self];
        
    }else{
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 7, 150, 30)];
        self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.button setTitle:@"GO" forState:UIControlStateNormal];
        [self.button setFrame:CGRectMake(210, 7, 50, 30)];
        [self.button addTarget:self action:@selector(callByCityButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.label];
        [self addSubview:self.textField];
        [self addSubview:self.button];

        [self.textField setBorderStyle:UITextBorderStyleRoundedRect];
        [self.textField setPlaceholder:[NSString stringWithFormat:@"%@",self.property]]; 
        [self.textField setDelegate:self];
        
    }

    
}

-(void)callByCityButtonPressed:(id)sender{
    if ([self.delegate respondsToSelector:@selector(cell:forProperty:)]) {
        [self.delegate cell:self
                forProperty:self.property];
        
        
    }

}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.type == EditTextTableCellTypeNotEditable) {
        return NO;
    }
       return YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
