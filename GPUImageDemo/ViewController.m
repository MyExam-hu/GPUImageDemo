//
//  ViewController.m
//  GPUImageDemo
//
//  Created by huweidong on 26/10/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UIImage *inputImage=[UIImage imageNamed:@"image1.jpeg"];
    UIImage *inputImage=[UIImage imageNamed:@"image.jpg"];
    
    //创建一个亮度的滤镜
//    GPUImageBrightnessFilter *passthroughFilter = [[GPUImageBrightnessFilter alloc] init];
//    passthroughFilter.brightness = 0.5f;
    //朦胧加暗
//    GPUImageHazeFilter *passthroughFilter = [[GPUImageHazeFilter alloc] init];
//    passthroughFilter.distance=-0.1;
    //高斯模糊
//    GPUImageGaussianBlurFilter *passthroughFilter = [[GPUImageGaussianBlurFilter alloc] init];
//    passthroughFilter.texelSpacingMultiplier=0.2;
     //水晶球效果
    GPUImageGlassSphereFilter *passthroughFilter = [[GPUImageGlassSphereFilter alloc] init];
    
    //设置要渲染的区域
    [passthroughFilter forceProcessingAtSize:inputImage.size];
    [passthroughFilter useNextFrameForImageCapture];
    
    //获取数据源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
    //添加上滤镜
    [stillImageSource addTarget:passthroughFilter];
    //开始渲染
    [stillImageSource processImage];
    //获取渲染后的图片
    UIImage *nearestNeighborImage = [passthroughFilter imageFromCurrentFramebuffer];
    //加载出来
    UIImageView *imageView=[[UIImageView alloc] initWithImage:nearestNeighborImage];
//    imageView.frame=CGRectMake(0, 50, inputImage.size.width/5, inputImage.size.height/5);
    imageView.frame=CGRectMake(0, 50, inputImage.size.width, inputImage.size.height);
    [self.view addSubview:imageView];
    //释放内存
    [[GPUImageContext sharedImageProcessingContext].framebufferCache purgeAllUnassignedFramebuffers];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
