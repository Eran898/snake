import processing.sound.*;
import processing.serial.*;
boolean map=false;
int countermap=1;
boolean lvlupsound=true;
boolean callMethod=true;
boolean die_sound=true;
boolean no_music=true;
PImage smile,shok,dead;//this is for the image
SoundFile coin;
SoundFile die;
SoundFile background;
SoundFile lvlups;
SoundFile go;
PImage bg,bg2;
ArrayList<Integer> x = new ArrayList<Integer>(), y = new ArrayList<Integer>();
int w = 40, h = 40, bs = 20, direction = 0, applex = 12, appley = 10;
//directons== 0=down  1=up   2=right 3=left==== buttons righ=2 left=1
int[] dx = {0,0,1,-1}, dy = {1,-1,0,0};
boolean gameover = false;
boolean warning = false;
int score,high_score,time=40,counter,LBreset;
Serial myPort;                  //define name of the serial communication
int down=0,up=1,right=2,left=3;



void setup() {
              size(800, 800);
              bg=loadImage("last.jpg");//this is for the image
              bg2=loadImage("3.jpg");
              smile=loadImage("smile.jpg");
              shok=loadImage("shok.jpg");
              dead=loadImage("dead.jpg");
              coin = new SoundFile(this, "coin.wav");
              die = new SoundFile(this, "die.wav");
              lvlups = new SoundFile(this, "lvlup.wav");
              background = new SoundFile(this, "background.mp3");
              go = new SoundFile(this, "gameover.wav");
              x.add(5);//the size of the snake
              y.add(5);//the size of the snake
              myPort=new Serial(this, "COM4", 9600);  //se the name of our communication port (Arduino COM port)
              myPort.write('0');
             }

void draw() {
  background(255);
  background(#2A1FD8);
  image(bg,0,0);//this is for the image
  image(smile,390,52);
   if(callMethod==true){
                        myMethod();
                        callMethod = false;
                       }
    while (myPort.available() > 0) {//while for the controlls buttons of the board
                                    int ezer=myPort.read();//to use of ezer is toread from the board and every time it get signal i must reset him to zero
                                    if(direction==up){
                                                      if(ezer==49){
                                                                    direction=left;
                                                                    ezer=0;
                                                                  }
                                                      if(ezer==50){
                                                                    direction=right;
                                                                    ezer=0;
                                                                  }
                                                       }
                                    
                                    if(direction==left){
                                                        if(ezer==49){
                                                                     direction=down;
                                                                     ezer=0;
                                                                    }
                                                        if(ezer==50){
                                                                     direction=up;
                                                                      ezer=0;
                                                                     }
                                                         }
                                    
                                    if(direction==down){
                                                        if(ezer==49){
                                                                     direction=right;
                                                                     ezer=0;
                                                                    }
                                                        if(ezer==50){
                                                                     direction=left;
                                                                     ezer=0;
                                                                     }
                                                        }
                                                                   
                                    
                                    if(direction==right){
                                                         if(ezer==49){
                                                                      direction=up;
                                                                      ezer=0;
                                                                     }
                                                         if(ezer==50){
                                                                     direction=down;
                                                                     ezer=0;
                                                                     }
                                                         }
                                   }//end of the while
      if(score==5){
                   lvlupsound=true;
                   fill(255,0,0);
                   textSize(30);
                   text("Congrats!!!! Next lvl", 100, height/2);
                   if (score<6){
                                delay(time-score*5);
                                }
                  }
      textSize(20);
      text("SCORE: "+score,width*0.80,height*0.1);
      text("HIGHEST SCORE: "+ high_score,width*0.1,height*0.1);
      myPort.write('0');
      if(keyPressed && key=='h'){
                   delay(200);//must have delay if not h pressed 4 times in a row
                   countermap++;
                                }
      if(countermap%2==0){
                          map=true;
                         }
      else{
            map=false;
           }
      if(map==true){
                    stroke(255,255,255);
                    for(int i = 0 ; i < w; i++) line(i*bs, 0, i*bs, height); 
                    for(int i = 0 ; i < h; i++) line(0, i*bs, width, i*bs); 
                   }

      for(int i = 0 ; i < x.size(); i++) {
                                          fill (#ADFF9D);
                                          stroke(#ADFF9D);
                                          rect(x.get(i)*bs, y.get(i)*bs, bs, bs);
                                          fill(#02D9E3);
                                          ellipse(x.get(i)*bs+10, y.get(i)*bs+10, bs-8, bs-8);
                                          fill(#CE4E04);
                                          ellipse(x.get(i)*bs+10, y.get(i)*bs+10, bs-10, bs-10);
                                         }
      if(!gameover) {  
                     if (score<4){
                                  delay(time-score*10);
                                 }
      fill(#2A1FD8);//apple color
      stroke(#2A1FD8);
      rect(applex*bs, appley*bs, bs, bs);
      fill(255,0,0);
      ellipse(applex*bs+10, appley*bs+10, bs-4, bs-4);
      if(frameCount%5==0){
                          x.add(0,x.get(0) + dx[direction]);
                          y.add(0,y.get(0) + dy[direction]);
                          if(x.get(0) < 0 || y.get(0) < 0 || x.get(0) >= w || y.get(0) >= h){
                                                                                             gameover = true;
                                                                                             }      
                          if(x.get(0) == 0 || y.get(0) == 0 || x.get(0) == w-1 || y.get(0) == h-1){
                                                                                                    warning = true;
                                                                                                   }
       else{ 
            warning = false;
            }
       if(warning==true){
                         textSize(30);
                         text("WARNING"+warning, 250, height/2);
                         myPort.write('1');}
                         for(int i = 1; i < x.size(); i++) if(x.get(0) == x.get(i) &&  y.get(0) == y.get(i)){
                                                                                                             gameover = true;
                                                                                                            }
                        if(x.get(0)==applex && y.get(0)==appley) {//if i touched the apple
                                                                  applex = (int)random(0,w);
                                                                  appley = (int)random(0,h);
                                                                  score++;
                                                                  coin.play();
                                                                  shok();
                                                                 }
                        else {
                              x.remove(x.size()-1);
                              y.remove(y.size()-1);
                             }
                         }

                } 
      else {
            image(dead,390,52);
            fill(255,0,0);
            textSize(85);
            text("GAME OVER.", 150, (height/2));
            textSize(30);
            text("Press Space or long LB press to Play Again", 100, (height/2)+100);
            LBreset=myPort.read();
            if(keyPressed && key == ' '||(LBreset==50)||(LBreset==49)) {
                                                                        if(high_score<score){
                                                                                              high_score=score;
                                                                                             }
                                                                                                         
            score=0;//zero score again
            x.clear(); //Clear array list
            y.clear(); //Clear array list
            x.add(5);
            y.add(5);
            gameover = false;
            if(no_music==true){
                                no_bg();
                                no_music = true;
                                callMethod=true;
                                die_sound = true;
                              }
            if(die_sound==true){
                                die();
                                die_sound = false;
                                 }
            delay(3000);
            go.play();
                                                                        }
          }

      if (keyPressed == true) {
                                int newdir = key=='s' ? 0 : (key=='w' ? 1 : (key=='d' ? 2 : (key=='a' ? 3 : -1)));
                                if(newdir != -1 && (x.size() <= 1 || !(x.get(1) ==x.get(0) + dx[newdir] && y.get (1) == y.get(0) + dy[newdir]))) direction = newdir;
                               }
              }//end of drew
              
void music(){
              if(gameover==true){
                                 background.play();
                                }
              else{
                   background.stop();
                  }
            }
void myMethod(){
                delay(1000);
                background.play();
               }
void no_bg(){
             background.stop();
            }
void lvlup(){
    //background.stop();
             lvlups.play();
            }
void die(){
           background.stop();
           die.play();
           die.rate(0.5);//slow down the music
          }
          void shok(){
                      image(shok,390,52);
                      delay(150);
                      }
          //END