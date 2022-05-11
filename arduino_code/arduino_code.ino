
#define LED RED_LED    //define the LED pin
#define LED2 GREEN_LED    //define the LED pin
#define LED3 BLUE_LED    //define the LED pin
const int buttonPin = PUSH1;
const int buttonPin2 = PUSH2;
void setup(){

  pinMode(LED, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(LED3, OUTPUT);//initialize LED output
  Serial.begin(9600);         //start the serial communication
   pinMode(buttonPin, INPUT_PULLUP);
    pinMode(buttonPin2, INPUT);
}

void loop(){
  int buttonState = 0;
  int buttonState2 = 0;
  buttonState = digitalRead(buttonPin);
  buttonState2 = digitalRead(buttonPin2);
 
  if (buttonState == LOW) { 
    buttonState == HIGH;
    delay(250);
    for(int i=0;i<1;i++){ 
   Serial.print(1);
   }}

    if (buttonState2 == LOW) {
    buttonState2 == HIGH;
    delay(250);
    for(int i=0;i<1;i++){ 
   Serial.print(2);
   }}

  if(Serial.available() > 0){           //if some data is available of in the serial port
    char ledPinState = Serial.read();   //read the value
    if(ledPinState == '1'){             //if statement will be true(1)
      digitalWrite(LED, HIGH);
      delay(100);
      digitalWrite(LED, LOW);
      digitalWrite(LED3, HIGH);
      delay(100);
      digitalWrite(LED3, LOW); 
    }
    if(ledPinState == '0'){             //if statement will be false(0)
      digitalWrite(LED, LOW); 
      digitalWrite(LED3, LOW); //turn OFF the LED
    }
  }
}
