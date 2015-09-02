#include <iostream>
#include <stdio.h>
#include <opencv2/opencv.hpp>
#include <unistd.h>
#include <math.h>

#include <Arduino.h>

using namespace std;

int fake_main(){
    cv::Mat mat;

    double pi = atan(1)*4;
    cout << "pi = " << pi << endl;

    pinMode(13, OUTPUT);
    pinMode(5, INPUT);

    while(!digitalRead(5)){
        digitalWrite(13, HIGH);
        usleep(500000);
        digitalWrite(13, LOW);
        usleep(500000);
    }
    return 0;
}
