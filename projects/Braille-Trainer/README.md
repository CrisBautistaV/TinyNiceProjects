# A braille trainer system

## General info
This was one of my first projects when I finished my career. A long story short, my mom had an accident and broke her ankle. When taking her to physical rehab, classes for visually impaired people were given at the same hours, so I entered to them.
It's when this idea came from and was a nice life experience.

## Technical info
The system controls **6 servomotors** that activates in combination with the Braille alphabet. The letters can be given by an old **PS/2 keyboard** or a **cellphone application** through BT communication (an HC-05 BT serial module). If the app is used, you can enter the text or dictate the word.

It's based on a PIC16f628A Microchip microcontroller, a HC-05 serial BT module, a PS/2 keyboard and 6 small 5V servomotors.
It's programmed using PIC-C software and PROTEUS for PCB design. 
The original mechanism was a set of small pistons going up and down and pressing the hand's palm. A smaller mechanism with thin wires were thought, so it could simulate better the feeling in the fingertips, but it was not implemented.

* In [AppInventor](AppInventor) you will find the app.
* In [PCB](PCB) there are the schematic and the one-layer PCB design. 
* In [PIC16F628A](Pic16f268a) you will find the files for programming the microcontroller.
* [Characters] file has the Hexadecimal values that correspond to each character. Is based on the output given by the PS/2 keyboard.

If not applied like this, you could use the PCB design for servomotors activation through BT.

Feel free to use it any of this files. If you do so, a mention would be nice. ;)


# Un sistema de entrenamiento braille

## Información general
Este fue uno de mis primeros proyectos cuando terminé mi carrera. En pocas palabras, mi mamá tuvo un accidente y se rompió el tobillo. Al llevarla a rehabilitación física, en el mismo horario se daban clases para personas con discapacidad visual, así que entré a las clases.
Fue entonces cuando surgió esta idea y fue una buena experiencia de vida.

## Información técnica
El sistema controla **6 servomotores** que se activan en combinación con el alfabeto Braille. Las letras pueden ser dadas por un antiguo **teclado PS/2** o una **aplicación de celular** a través de comunicación BT (un módulo serial HC-05 BT). Si se utiliza la aplicación, puede ingresar el texto o dictar la palabra.

Se basa en un microcontrolador Microchip PIC16f628A, un módulo BT serie HC-05, un teclado PS/2 y 6 pequeños servomotores de 5V.
Se programó utilizando el software PIC-C y PROTEUS para el diseño del PCB.
El mecanismo original era un conjunto de pequeños pistones que subían y bajaban y presionaban la palma de la mano. Se pensó en un mecanismo más pequeño con alambres finos, para poder simular mejor la sensación en las yemas de los dedos, pero no se implementó.

* En [AppInventor](AppInventor) encontrarás la aplicación.
* En [PCB](PCB) está el esquemático y el diseño del PCB de una capa.
* En [PIC16F628A](Pic16f268a) encontrarás los archivos para programar el microcontrolador.
* El archivo **Characteres** tiene los valores hexadecimales que corresponden a cada carácter. Se basa en la salida proporcionada por el teclado PS/2.

Si no se aplica así, podrías utilizar el diseño de PCB para la activación de servomotores a través de BT.

Siéntase libre de utilizar cualquiera de estos archivos. Si lo hace, una mención estaría bien. ;)
