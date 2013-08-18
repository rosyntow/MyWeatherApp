//
//  EditCell.h
//  MyWeatheApp
//
//  Created by Rosina Otchere-Nyarko on 8/17/13.
//  Copyright (c) 2013 xperttech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    EditCellTypeText,
    EditCellTypeTextResult,
    EditCellTypeButton,
    EditTextTableCellTypeNotEditable,
    EditCellTypeLabel
} EditCellType;

@class EditCell;
@protocol EditCellDelegate <NSObject>

- (void)cell:(EditCell *)cell forProperty:(NSString *)property;

@end
@interface EditCell : UITableViewCell
@property(nonatomic,weak)id<EditCellDelegate> delegate;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,copy)NSString *property;
@property (nonatomic, assign) EditCellType type;
+ (id)newCellWithDelegate:(id <EditCellDelegate>)delegate andText:(NSString *)text forProperty:(NSString *)property;
@end
