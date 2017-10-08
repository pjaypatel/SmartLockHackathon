
#include <CurieBLE.h>
#include <Servo.h>

BLEPeripheral blePeripheral;

BLEService connectionService("a3c9025d-f942-48fb-bb7a-c2397c029f85");

BLEIntCharacteristic switchCharacteristic("a3c9025d-f942-48fb-bb7a-c2397c029f85", BLERead | BLEWrite);

int guests [4]= {4,63,103,92};

int doorLocked = 1;

Servo serv;

int position = -45;

void setup() {
  Serial.begin(9600);

  blePeripheral.setLocalName("Bright Lock");
  blePeripheral.setAdvertisedServiceUuid(connectionService.uuid());

  blePeripheral.addAttribute(connectionService);
  blePeripheral.addAttribute(switchCharacteristic);

  switchCharacteristic.setValue(0);

  serv.attach(9);

  serv.write(position);

  blePeripheral.begin();

}

void loop() {
  
  BLECentral central = blePeripheral.central();
  
  Serial.println("Searching for connection");

  if(!doorLocked){
    lockDoor();
  }
  
  if(central){

    Serial.println("Connected");

    while(central.connected()){
      
      if(switchCharacteristic.written()){
        
        int n = switchCharacteristic.value();

        Serial.println(n);
        
        search(n);
      }
      
    }
    
  }

}

void search(int n){

  int found = 0;
  
  for(unsigned int x=0; x<sizeof(guests) && !found; ++x){
      
    if(n == guests[x]){
      Serial.println("Is a guest");
      unlockDoor();
      found = 1;
    }
  }
}

void unlockDoor(){

  serv.write(45);

  doorLocked = 0;
}

void lockDoor(){
  
  serv.write(-45);
 
  doorLocked = 1;
}

