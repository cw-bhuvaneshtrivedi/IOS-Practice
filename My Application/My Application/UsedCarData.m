//
//  UsedCarData.m
//  My Application
//
//  Created by Ranjit Mahadik on 05/06/24.
//

#import "UsedCarData.h"

@implementation UsedCarData

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setupView];
    }
    return self;
}

-(void)setupView{
    self.backgroundColor = [UIColor redColor];
    
    self.makeName = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, self.frame.size.width-32, 40)];
    self.makeName.text = @"makeName here";
    self.makeName.textColor = [UIColor blackColor];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.makeName];
    
    self.modelName = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, self.frame.size.width-32, 40)];
    self.modelName.text = @"modelName here";
    self.modelName.textColor = [UIColor blackColor];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.modelName];
    
    CGFloat imageViewSize = 100.0;
    self.carImage = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - imageViewSize)/2, CGRectGetMaxY(self.modelName.frame)+10, imageViewSize, imageViewSize)];
    self.carImage.contentMode = UIViewContentModeScaleAspectFit;
    self.carImage.image = [UIImage imageNamed:@"carImage.webp"];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.carImage];
    
    [self setupConstraints];
}

-(void) setupConstraints{
     [NSLayoutConstraint activateConstraints:@[
        [self.makeName.topAnchor constraintEqualToAnchor:self.topAnchor constant:10],
        [self.makeName.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10],
        [self.makeName.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10],
        [self.makeName.heightAnchor constraintEqualToConstant:40]
    ]];

    [NSLayoutConstraint activateConstraints:@[
        [self.modelName.topAnchor constraintEqualToAnchor:self.makeName.bottomAnchor constant:10],
        [self.modelName.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10],
        [self.modelName.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10],
        [self.modelName.heightAnchor constraintEqualToConstant:40]
    ]];

    [NSLayoutConstraint activateConstraints:@[
        [self.carImage.topAnchor constraintEqualToAnchor:self.modelName.bottomAnchor constant:10],
        [self.carImage.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10],
        [self.carImage.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10],
        [self.carImage.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10]
    ]];    
}

-(void) setImageWithURL:(NSURL *)url{
    NSURLSessionTask *downloadImageTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler: ^(NSData * _Nullable data,NSURLResponse * _Nullable response, NSError * _Nullable error){
        if(error){
            NSLog(@"Failed to load image: %@",error.localizedDescription);
            return;
        }
        
        UIImage *downloadedImage = [UIImage imageWithData:data];
        
        if(downloadedImage){
            dispatch_async(dispatch_get_main_queue(), ^{
                self.carImage.image = downloadedImage;
            });
        }
    }];
    
    [downloadImageTask resume];
}

@end
