//
//  EditViewController.h
//  password
//
//  Created by Alexander Gomzyakov on 03.06.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSPassword;

@interface PSEditTableViewController : UITableViewController

/// Сущность Пароль, определяющая отображаемую ячейкой информацию.
@property (nonatomic, weak) PSPassword *password;

@end
