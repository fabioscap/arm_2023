# RoboCup Autonomous Robot Manipulation Challenge 2023
## RoboKT Team, Sapienza University of Rome

This repository contains scripts and models necessary to reproduce our results for the qualification round of the RoboCup Autonomous Robot Manipulation Challenge 2023.

## Prerequisites

Before proceeding, ensure that you have the following dependencies installed:

- MATLAB R2023a
- Aerospace Toolbox
- Computer Vision Toolbox
- Deep Learning Toolbox
- Image Processing Toolbox
- ROS Toolbox
- Statistics and Machine Learning Toolbox

## Getting Started

1. **Clone the Repository**

First, clone this repository to your local machine using the following command:

``
git clone https://github.com/fabioscap/arm_2023
``


2. **Set Up the Simulated Environment**

After cloning the repository, run the [simulated environment](https://arm.robocup.org/). Ensure that the environment is set up correctly and all the necessary components are properly initialized. In our examinations, we've consistently utilized the Nvidia mode (command: ./run_bash Nvidia), thus maintaining a "real time factor" of 0.9 or higher.

3. **Connect to the Environment**

Open the `main.m` file and replace the placeholder IP with your own. This will connect your local setup to the simulated environment.

4. **Execute the Main File**

Finally, execute the `main.m` file to solve the challenge. 

## Useful links

- [YOLO Dataset](https://drive.google.com/drive/folders/1Z_fQhqY4dw6TJh4KXvdRaZEcKD5mIhhS?usp=sharing) (The link provided is private. If you wish to view it, kindly request access.)

- [Video of our program in action](https://drive.google.com/file/d/1aAxM02qK1T6J0tL3uSaWgUbBY04pCLik/view?usp=sharing)

## Contact

If you have any questions, please feel free to contact us.

- Dennis Rotondi <rotondi.1834864@studenti.uniroma1.it>
- Emanuele Giacomini <giacomini@diag.uniroma1.it>
- Fabio Scaparro <scaparro.1834913@studenti.uniroma1.it>
- Leonardo Brizi <brizi@diag.uniroma1.it>
- Marco Montagna <montagna.1882418@studenti.uniroma1.it>
