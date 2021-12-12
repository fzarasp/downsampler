# Downsampler
MATLAB program for downsamling and upsampling with LPF and comparsion with "decimator"

## Input 
![image](https://user-images.githubusercontent.com/47606879/145708947-2fefbfb1-bcd2-4942-ab9d-34963d798d16.png)

![image](https://user-images.githubusercontent.com/47606879/145708952-032eaaf2-2b4f-4b73-a881-290474d4c7e0.png)


## Echo
yecho[n] = Σ(k = 0 to N) α^k y[n − kM]  for M = 44100, α = .7, N = 3

![image](https://user-images.githubusercontent.com/47606879/145708999-7817209e-8750-4438-8222-76f1f3d9a6bf.png)

![image](https://user-images.githubusercontent.com/47606879/145709003-6ac14320-7fd8-492e-bdcf-e65e9d497d91.png)


## Downsampling and Upsampling

![image](https://user-images.githubusercontent.com/47606879/145709027-2a4edec2-023f-4302-8d90-708ba8447453.png)


## Downsampler vs Decimator 

![image](https://user-images.githubusercontent.com/47606879/145709037-33a85167-50c7-4c56-8964-4d7f4dbdee00.png)

## Low Pass Filter
- cutoff = min(pi/L , pi/n) 
- lowpassfilter fpass = Fs/6(pi/3) and fstop =Fs/5(2*pi/8)
- num = [0.028  0.053 0.071  0.053 0.028];
- denum = [1.000 -2.026 2.148 -1.159 0.279];

![image](https://user-images.githubusercontent.com/47606879/145709064-574f259d-8d1c-4d8f-ab78-1f3155ad1f5d.png)

