//
//  PSSlideCell.m
//  password
//
//  Created by Alexander Gomzyakov on 24.12.13.
//  Copyright (c) 2013 Alexander Gomzyakov. All rights reserved.
//

#import "PSSlideCell.h"
#import "PSSlideCellButton.h"
#import "PSPassword.h"
#import "PSValidator.h"
#import "DSFavIconManager.h"
#import "PSCircleWrapper.h"

NSString *const PSSlideCellEnclosingTableViewDidBeginScrollingNotification = @"PSSlideCellEnclosingTableViewDidBeginScrollingNotification";

/// Расстояние на которое отодвигается фронтальное представление при свайпе с права на лево (равно ширине 3х кнопок)
CGFloat const PSScrollViewRightCatchWidth = 58 * 3;

/// Расстояние на которое отодвигается фронтальное представление при свайпе с лева на право (чуть меньше общей ширины ячейки)
const CGFloat PSBackPasswordViewWidth = 320 - 58;


@interface PSSlideCell () <UIScrollViewDelegate>

/// Основное прокручиваемое контейнерное представление.
@property (nonatomic, strong) UIScrollView *scrollView;

/// Основное (верхнее) представление ячейки (содержит Title и Username пароля).
@property (nonatomic, strong) UIView *frontContentView;

/// Контейнерное представление содержащее кнопки для манипулирования паролем.
@property (nonatomic, strong) UIView *backButtonsView;

/// Контейнерное представление на котором отображается (в открытую) пароль.
@property (nonatomic, strong) UIView *backPasswordView;

/// Метка для отображения названия записи с паролем (имя сайта/сервиса, как правило).
@property (nonatomic, weak) UILabel *titleLabel;

/// Метка для отображения имени пользователя.
@property (nonatomic, weak) UILabel *loginLabel;

@property (nonatomic, strong) PSCircleWrapper *circleWrapper;

/// Представление для отображения фавикона, если пароль сохраняется для сайта.
@property (nonatomic, weak) UIImageView *faviconView;

/// Метка для отображения имени пользователя.
@property (nonatomic, weak) UILabel *passwordLabel;

@end


@implementation PSSlideCell

/// Стандартный отступ в макетной сетке нашего представления.
static const CGFloat kOffset = 16.0;

/// Ширина ячейки.
static const CGFloat kCellWidth = 320.0;

/// Высота ячейки.
static const CGFloat kCellHeight = 60.0f;

- (PSSlideCell *)initWithPassword:(PSPassword *)password reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.password = password;
        self.frame    = CGRectMake(0.0, 0.0, self.frame.size.width, kCellHeight);

        [self makeUI];

        [self registerNotifications];
        [self recognizeTapsToFrontView];

        self.titleLabel.text = self.password.title;
        self.loginLabel.text = self.password.username;

        if (self.password.siteUrl) {
            [self renewFaviconWithUrlString:self.password.siteUrl];
        }
    }

    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    NSLog(@"Error: Use initWithPassword:reuseIdentifier: method!")
    return nil;
}

/**
   Подписываемся на уведомления.
 */
- (void)registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enclosingTableViewDidScroll)
                                                 name:PSSlideCellEnclosingTableViewDidBeginScrollingNotification
                                               object:nil];
}

- (void)enclosingTableViewDidScroll
{
    [self.scrollView setContentOffset:CGPointMake(PSBackPasswordViewWidth, 0.0) animated:YES];
}

#pragma mark - Actions

- (void)actionSingleTapToCell
{
    [_delegate slideCellDidSingleTap:self];
}

- (void)actionDoubleTapToCell
{
    [_delegate slideCellDidDoubleTap:self];
}

- (void)actionDeleteButtonPressed:(id)sender
{
    [self.delegate cellDidSelectDelete:self];
    [self.scrollView setContentOffset:CGPointMake(PSBackPasswordViewWidth, 0.0) animated:YES];
}

- (void)actionFavoriteButtonPressed:(id)sender
{
    [self.delegate cellDidSelectFavorite:self];
}

- (void)actionEditButtonPressed:(id)sender
{
    [self.delegate cellDidSelectEdit:self];
}

#pragma mark - Overridden Methods

- (void)prepareForReuse
{
    [super prepareForReuse];

    [self.scrollView setContentOffset:CGPointMake(PSBackPasswordViewWidth, 0.0) animated:NO];
}

/**
   При попытке обратиться к стандатной основную метке ячейки, меняем название записи о пароле.
 */
- (UILabel *)textLabel
{
    return self.titleLabel;
}

/**
   При попытке обратиться к стандатной дополнительной метке ячейки, меняем имя пользователя.
 */
- (UILabel *)detailTextLabel
{
    return self.loginLabel;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    // Расстояния на которое необходимо отвести плашку для того, чтобы отработала "докрутка" левого/правого свайпа.
    CGFloat offsetToTriggerLeftSwipe  = PSBackPasswordViewWidth - 2 * 58;
    CGFloat offsetToTriggerRightSwipe = PSBackPasswordViewWidth + PSScrollViewRightCatchWidth;

    if (scrollView.contentOffset.x < offsetToTriggerLeftSwipe) {
        targetContentOffset->x = 0;
    } else if (scrollView.contentOffset.x > offsetToTriggerRightSwipe) {
        targetContentOffset->x = PSBackPasswordViewWidth + PSScrollViewRightCatchWidth;
    } else {
        *targetContentOffset = CGPointMake(PSBackPasswordViewWidth, 0.0);

        // Необходимо для того, чтобы убрать мерцание. Странно.
        dispatch_async(dispatch_get_main_queue(), ^{
                           [scrollView setContentOffset:CGPointMake(PSBackPasswordViewWidth, 0.0) animated:YES];
                       });
    }
}

#pragma mark - Make UI

- (void)makeUI
{
    CGFloat const bgColorComponent = 195.0 / 256.0;
    self.backgroundColor = [UIColor colorWithRed:bgColorComponent green:bgColorComponent blue:bgColorComponent alpha:1.0f];

    [self createScrollView];
    [self createFrontContentView];
    [self createBackPasswordView];
    [self createBackButtonsView];

    [self addConstraints];
}

- (void)createScrollView
{
    CGFloat scrollViewContentWidth  = PSBackPasswordViewWidth + CGRectGetWidth(self.bounds) + PSScrollViewRightCatchWidth;
    CGFloat scrollViewContentHeight = CGRectGetHeight(self.bounds);

    _scrollView               = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    _scrollView.contentSize   = CGSizeMake(scrollViewContentWidth, scrollViewContentHeight);
    _scrollView.contentOffset = CGPointMake(PSBackPasswordViewWidth, 0.0);

    _scrollView.delegate                       = self;
    _scrollView.showsHorizontalScrollIndicator = NO;

    [self.contentView addSubview:_scrollView];
}

/**
   Создаем две метки - для отображения названия записи о пароле и имени пользователя.
 */
- (void)createFrontContentView
{
    self.frontContentView                 = [[UIView alloc] initWithFrame:CGRectMake(PSBackPasswordViewWidth, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    self.frontContentView.backgroundColor = [UIColor whiteColor];

    [self.scrollView addSubview:self.frontContentView];

    [self createCircleWrapper];
    [self createFaviconView];
    [self createTitleLabel];
    [self createLoginLabel];
}

- (void)createCircleWrapper
{
    PSCircleWrapper *circleWrapper = [[PSCircleWrapper alloc] initWithFrame:CGRectMake(0.0, 0.0, 60.0, 60.0)];

    circleWrapper.translatesAutoresizingMaskIntoConstraints = NO;

    self.circleWrapper = circleWrapper;
    [self.frontContentView addSubview:self.circleWrapper];
}

- (void)createTitleLabel
{
    const CGFloat titleLabelFontSize = 17.0;

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font      = [UIFont systemFontOfSize:titleLabelFontSize];

    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.titleLabel = titleLabel;
    [self.frontContentView addSubview:self.titleLabel];
}

- (void)createLoginLabel
{
    const CGFloat loginLabelFontSize = 12.0;
    const CGFloat colorComp          = 128.0 / 255.0;

    UILabel *loginLabel = [[UILabel alloc] init];
    loginLabel.textColor = [[UIColor alloc] initWithRed:colorComp green:colorComp blue:colorComp alpha:1.0];
    loginLabel.font      = [UIFont systemFontOfSize:loginLabelFontSize];

    loginLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.loginLabel = loginLabel;
    [self.frontContentView addSubview:self.loginLabel];
}

- (void)createFaviconView
{
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.layer.cornerRadius = 2.0f;
    photoView.contentMode        = UIViewContentModeScaleAspectFit;

    photoView.translatesAutoresizingMaskIntoConstraints = NO;

    self.faviconView = photoView;
    [self.frontContentView addSubview:self.faviconView];
}

/**
   Создаем три управляющих кнопки: Править, В избранное и Удалить
 */
- (void)createBackPasswordView
{
    self.backPasswordView                 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, PSBackPasswordViewWidth, CGRectGetHeight(self.bounds))];
    self.backPasswordView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.backPasswordView];

    const CGFloat kFontSize  = 18.0;
    CGRect        labelFrame = CGRectMake(kOffset, 15.0, PSBackPasswordViewWidth - 2*kOffset, 1.5 * kFontSize);
    UILabel       *label     = [[UILabel alloc] initWithFrame:labelFrame];
    label.textColor    = [UIColor darkGrayColor];
    label.font         = [UIFont systemFontOfSize:kFontSize];
    self.passwordLabel = label;
    [self.backPasswordView addSubview:self.passwordLabel];

    self.passwordLabel.text = self.password.password;
}

/**
   Создаем три управляющих кнопки: Править, В избранное и Удалить
 */
- (void)createBackButtonsView
{
    CGFloat backButtonsViewX = CGRectGetWidth(self.bounds) + PSBackPasswordViewWidth;

    self.backButtonsView = [[UIView alloc] initWithFrame:CGRectMake(backButtonsViewX, 0, PSScrollViewRightCatchWidth, CGRectGetHeight(self.bounds))];
    [self.scrollView addSubview:self.backButtonsView];

    PSSlideCellButton *editButton = [PSSlideCellButton buttonWithType:PSSlideCellButtonTypeEdit target:self action:@selector(actionEditButtonPressed:)];
    editButton.frame = CGRectMake(kCellHeight * 0, 0.0, editButton.frame.size.width, editButton.frame.size.height);
    [self.backButtonsView addSubview:editButton];

    PSSlideCellButton *favoriteButton = [PSSlideCellButton buttonWithType:PSSlideCellButtonTypeFavorite target:self action:@selector(actionFavoriteButtonPressed:)];
    favoriteButton.frame = CGRectMake(kCellHeight * 1, 0.0, favoriteButton.frame.size.width, favoriteButton.frame.size.height);
    [self.backButtonsView addSubview:favoriteButton];

    PSSlideCellButton *deleteButton = [PSSlideCellButton buttonWithType:PSSlideCellButtonTypeDelete target:self action:@selector(actionDeleteButtonPressed:)];
    deleteButton.frame = CGRectMake(kCellHeight * 2, 0.0, deleteButton.frame.size.width, deleteButton.frame.size.height);
    [self.backButtonsView addSubview:deleteButton];

    // Представление-заслонка, необходимо только для того, чтобы закрыть общий фон (серый) цветом последней
    // кнопки слайд-менюя (красный, кнопка удаления).
    UIView *flapView = [[UIView alloc] initWithFrame:CGRectMake(kCellHeight * 3, 0, 300.0, CGRectGetHeight(self.bounds))];
    flapView.backgroundColor = deleteButton.backgroundColor;
    [self.backButtonsView addSubview:flapView];

}

#pragma mark - Constraints

- (void)addConstraints
{
    [self constraintCircleWrapper];
    [self constraintTitleLabel];
    [self constraintLoginLabel];
    [self constraintFaviconView];
}

- (void)constraintCircleWrapper
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.circleWrapper
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.frontContentView
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0f
                                                      constant:0.0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.circleWrapper
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.frontContentView
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0f
                                                      constant:0.0]];

    // Ширина у миниатюры фото фиксированная.
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.circleWrapper
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0f
                                                      constant:60.0]];
    // Высота у миниатюры фото фиксированная.
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.circleWrapper
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0f
                                                      constant:60.0]];
}

- (void)constraintTitleLabel
{
    // Отступаем от левого края
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.frontContentView
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0f
                                                      constant:kOffset]];
    // Отступаем от правого края
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.frontContentView
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0f
                                                      constant:-3.5*kOffset]];
    const CGFloat kTopOffset = 12.0f;

    // Отступаем от верхнего края
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.frontContentView
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0f
                                                      constant:kTopOffset]];
}

- (void)constraintLoginLabel
{
    // Отступаем от левого края
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.loginLabel
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.frontContentView
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0f
                                                      constant:kOffset]];
    // Отступаем от правого края
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.loginLabel
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.frontContentView
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0f
                                                      constant:-3.5*kOffset]];
    const CGFloat kBottomOffset = 10.0f;

    // Отступаем от нижнего края
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.loginLabel
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.frontContentView
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0f
                                                      constant:-kBottomOffset]];
}

- (void)constraintFaviconView
{
    // Отступаем от верхнего края ячейки
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.faviconView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.circleWrapper
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0f
                                                      constant:1.0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.faviconView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.circleWrapper
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0f
                                                      constant:5.0]];

    const CGFloat kFaviconSize = 16.0;

    // Ширина у миниатюры фото фиксированная.
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.faviconView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0f
                                                      constant:kFaviconSize]];
    // Высота у миниатюры фото фиксированная.
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.faviconView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0f
                                                      constant:kFaviconSize]];
}

#pragma mark - Helpers

+ (CGFloat)cellHeight
{
    return kCellHeight;
}

/**
   Отправляем делегату сообщение при одиночном или двойном тапе по фронтальному представлению.
   @note Стандартное событие таблицы tableView:didSelectRowAtIndexPath: отрабатывать не будет, т.к. мы целиком закрыли ячейку свои представлением.
 */
- (void)recognizeTapsToFrontView
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionSingleTapToCell)];
    singleTap.numberOfTapsRequired = 1;
    [_frontContentView addGestureRecognizer:singleTap];

    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionDoubleTapToCell)];
    doubleTap.numberOfTapsRequired = 2;
    [_frontContentView addGestureRecognizer:doubleTap];

    [singleTap requireGestureRecognizerToFail:doubleTap];
}

- (void)renewFaviconWithUrlString:(NSString *)urlString
{
    BOOL result = [[urlString lowercaseString] hasPrefix:@"http://"];

    NSString *urlStringWithHTTP;
    if (result) {
        urlStringWithHTTP = urlString;
    } else {
        urlStringWithHTTP = [NSString stringWithFormat:@"http://%@", urlString];
    }

    if ([PSValidator validateURLString:urlStringWithHTTP]) {
        NSURL *url = [NSURL URLWithString:urlStringWithHTTP];
        if ([[DSFavIconManager sharedInstance] cachedIconForURL:url]) {
            self.circleWrapper.hidden = NO;
            self.faviconView.image    = [[DSFavIconManager sharedInstance] cachedIconForURL:url];
        } else {
            self.faviconView.image = [[DSFavIconManager sharedInstance] iconForURL:url downloadHandler:^(UIImage *icon) {
                                          self.circleWrapper.hidden = NO;
                                          self.faviconView.image = icon;
                                      }];
        }
    } else {
        self.circleWrapper.hidden = YES;
        self.faviconView.image    = nil;
    }
}

@end
