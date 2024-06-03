#include <16F628A.h>

#FUSES NOWDT                    //No Watch Dog Timer
#FUSES PUT                      //Power Up Timer
//#FUSES HS                       //High speed Osc (> 4mhz for PCM/PCH) (>10mhz for PCD)
#FUSES INTRC_IO                 //Internal RC Osc, no CLKOUT
#FUSES NOMCLR                   //Master Clear pin used for I/O
#FUSES NOBROWNOUT               //No brownout reset
#FUSES NOLVP                    //No low voltage prgming, B3(PIC16) or B5(PIC18) used for I/O
#FUSES NOCPD                    //No EE protection
#FUSES NOPROTECT                //Code not protected from reading

#use delay(int=4000000)
//#use delay(clock=10000000)
#use rs232(baud=9600,parity=N,xmit=PIN_B2,rcv=PIN_B1,bits=8)//stream=PORT1)

