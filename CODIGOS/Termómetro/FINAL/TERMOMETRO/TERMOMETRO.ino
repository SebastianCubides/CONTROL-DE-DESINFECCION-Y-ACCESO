#include <Wire.h>
#include <Adafruit_MLX90614.h>
#include <Wire.h> 
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27,16,2);
Adafruit_MLX90614 mlx = Adafruit_MLX90614();

void setup() { 
  mlx.begin();  
  lcd.init();
  lcd.backlight();
  Serial.begin(9600);
}
void loop() {
  /*Serial.print("Ambient = "); Serial.print(mlx.readAmbientTempC()); 
  Serial.print("*C\tObject = "); Serial.print(mlx.readObjectTempC()); Serial.println("*C");*/
  lcd.print("TEMP:");
  lcd.print(mlx.readObjectTempC()-1000);
  lcd.print("*C");
  if ((mlx.readObjectTempC()-1000)>=37.5){
    Serial.write(2);
  }
  else{
    Serial.write(1);
  }
  delay(500);
  lcd.clear();
}
