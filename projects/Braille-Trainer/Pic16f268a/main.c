#include <main.h>

int16 delay=0,  min, max, tiempo;
int8 bit=0, pal=0;
unsigned char dato=0, salida=0, palabra[30];
//External interrupt and "hi" flag is used for the PS/2 keyboard
//"hi2" flag is used for serial BT
//"acento" is for spanish special characters
int1 hi=1, hi2=1, acento=0;


//The first 48 constants are the characters
//The second 48 constants are the port output for the motors activation
//that matches the character to be represented in braille
unsigned char const sinshift[48][2] = {
0x0d,0xCC, 0x15,0x4F, 0x1a,0xC5, 0x1b,0x0E, 0x1c,0x01, 0x1d,0xCA,
0x21,0x09, 0x22,0x8D, 0x23,0x49, 0x24,0x41, 0x29,0x00, 0x2a,0x87, 
0x2b,0x0B, 0x2c,0x4E, 0x2d,0x47, 0x31,0x4D, 0x32,0x03, 0x33,0x43, 
0x34,0x4B, 0x35,0xCD, 0x39,0x02, 0x3a,0x0D, 0x3b,0x4A, 0x3c,0x85, 
0x41,0x02, 0x42,0x05, 0x43,0x0A, 0x44,0x45, 0x49,0x04, 0x4a,0x84, 
0x4b,0x07, 0x4c,0xCB, 0x4d,0x0F, 0x55,0x46, 0x5b,0x46, 0x61,0x40, 
0x71,0x04, 0x79,0x46, 0x7b,0x84, 0x7c,0x44, 0x58,0x88, 0x76,0xCF,
0x52,0x00, 0x05,0xC7, 0x06,0x8E, 0x04,0x0C, 0x0C,0x8C, 0x03,0xCE   
};

unsigned char const acentuadas[5][2] = {
0x1C,0xC7,0x24,0x8E,0x43,0x0C,0x44,0x8C,0x3C,0xCE
};

//External interrupt is dedicated to PS/2 keyboard
//It decodes bit per bit the serial keyboard data of pressing a single key
#int_EXT
void  EXT_isr(void) 
{

   if (hi)
   {
      if((bit>0)&&(bit<9))
      {
       dato = (dato >> 1);
       
         if(input(PIN_B4))
            dato = dato | 0x80;      
      }
              
      
      if (bit++==32)
      {       
         if (dato==0x52)
         {
            acento=true;        
         }
         else
         {      
            hi=false;      
         }
         bit=0;
      }   
   }
}

//BT serial starts the process with hi2 flag
#int_RDA
void  RDA_isr(void) 
{
   palabra[pal]=getch();
   if (palabra[pal]==0x07)
   {
      bit=0;
      hi2=false;      
   }
   pal++;

}

void PWM()
{

   output_A(salida);
   delay_us(delay);
   output_A(0x00);
   delay_us(19900-delay);
   
}

//Servomotors manually set
//With this and PWM function, a manually square wave is set
//"Delay" sets the duty cycle of the PWM signal
//Pin B7 is connected to a relay so all the servomotors have power
void motor()
{

      while(delay<=max)
      {                  
         pwm();      
         delay=delay+50;
      }      
      delay=max;
      tiempo=0;
      while(tiempo<=250)//20ms pwm 250<<5seg
      {                  
         pwm();      
         tiempo++;
      }        
      while(delay>=min)
      {                    
         pwm();                                               
         delay=delay-50;
      }                 

}

void main()
{
int16 cont=0, cont2=0;

   delay_ms(3000);
   ext_int_edge( H_TO_L );   
   enable_interrupts(INT_EXT);
   enable_interrupts(INT_RDA);   
   enable_interrupts(GLOBAL);
    
    
     salida=0xCf;
     //printf("Proyecto para ciegos");          
     min=500;
     max=1300;
         
      delay_ms(3000);
      output_bit(Pin_B7,1);      
      delay=min;      
      motor();
      
      max=2000;
      //2100 maximum, 2000 for tolerance    
      
                 
   while(true)
   {
      //Activation logic through PS/2
      if (!hi)
      {
          //printf("%X ",dato);      
          if (acento)
          {
            for(cont=0;cont<5;cont++)
            {
               if(dato==acentuadas[cont][0])
               {
                  salida=acentuadas[cont][1];
                  //printf("%X ",salida); 
                  motor();                              
               }
            }
            acento=false;            
          }
          else
          {
          for(cont=0;cont<48;cont++)
          {
            if (sinshift[cont][0]==dato)
            {               
               salida=sinshift[cont][1];
               //printf("%X ",salida); 
               motor();                              
            }          
          }          
          }
          dato=0;   
          hi=true;
      }      
      
      //Activation logic through BT
      if (!hi2)
      {
          for (cont2=0; cont2<pal-1;cont2++)
          {
             for(cont=0;cont<48;cont++)
             {
               if (sinshift[cont][0]==palabra[cont2])
               {
                  salida=sinshift[cont][1];               
                  motor(); 
                  delay_ms(500);
                  break;
               }          
             }
          }
          pal=0;
          hi2=true;
      
      }      
   }
}

//5-clock---negro
//3-GND---cafe
//1-data-- naramja
//4-VCC--- rojo

/*
dato[bit]=input(PIN_B4);
   bit++;
   
   if (bit>14)
   {
      bit=0;
      for(i=0;i<15;i++)
      {
         printf("%u",dato[i]);
      }
      printf(" ");
      dato[0]=3;
      dato[1]=3;
      dato[2]=3;
      dato[3]=3;
      dato[4]=3;
      dato[5]=3;
      dato[6]=3;
      dato[7]=3;
      dato[8]=3;
      dato[9]=3;
      dato[10]=3;
      dato[11]=3;
      dato[12]=3;
      dato[13]=3;
      dato[14]=3;      
   }
   
   */
