import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;
import processing.sound.*;
import jp.nyatla.nyar4psg.*;
import gifAnimation.*;


MultiMarker nya;
MultiMarker nya2;

Gif loopingGif;

OpenCV OpencvR;//, OpencvN;
Capture video, video2;
Rectangle[] faces;
//SoundFile hola, holaN, listo, lado, moverteN, platicar, sonrisa, ojoN, dientesN, otraOcasionN, granSonrisa, reflexion, fondo, fondo2, adios;
SoundFile fondo, fondo2, actual;

//PImage[] fuego;
PImage  Irostro, Iboca, sophia, isaac, leyes, robopsico, ray, f451, feria, pcv, robot; //
int cGeneral, step, ti, t, fdeseados, tposicionamiento, centro, tCambio, lcara, fSonriendo;
boolean audioON, audioListo, audioHolaN, Bsonrisa, BojoN, BdientesN, BotraocasionN;
boolean cam;
float vol;

void setup() {
 
  //size(640,480,P3D);
  size(1280,720, P3D);
  //size(1280, 480); //640x480
  //colorMode(RGB, 100);
  
  fdeseados=18;
  tposicionamiento=5000;
  lcara=60;
  step=0;
  
  
  loopingGif = new Gif(this, "Fuego4.gif");
  loopingGif.loop();
  
  nya=new MultiMarker(this,width,height,"camera_para.dat",NyAR4PsgConfig.CONFIG_PSG);
  nya.addARMarker("patt.hiro",60);
  
  nya2=new MultiMarker(this,width,height,"camera_para.dat",NyAR4PsgConfig.CONFIG_PSG);
  nya2.addARMarker("patt.kanji",30);
  
  
   fondo = new SoundFile(this, "Fondo.wav");
   fondo2 = new SoundFile(this, "Fondo2.wav");
  
  /*
  actual = new SoundFile(this, "Hola.wav");
  hola = new SoundFile(this, "Hola.wav");
  holaN = new SoundFile(this, "HolaN.wav");
  listo = new SoundFile(this, "Listo.wav");
  
  lado = new SoundFile(this, "Lado.wav");
  moverteN = new SoundFile(this, "MoverteN.wav");
  platicar = new SoundFile(this, "Platicar.wav");
  
  sonrisa = new SoundFile(this, "Sonrisa.wav");
  ojoN = new SoundFile(this, "OjoN.wav");
  dientesN = new SoundFile(this, "DientesN.wav");
  otraOcasionN = new SoundFile(this, "OtraOcasionN.wav");
  granSonrisa = new SoundFile(this, "GranSonrisa.wav");
  reflexion = new SoundFile(this, "Reflexion.wav");
  
  
  adios = new SoundFile(this, "Adios.wav");
  */
  robot=loadImage("casco.png");
  
  
  sophia=loadImage("sophia2.png");
  sophia.resize(sophia.width/4,sophia.height/4);
  
  isaac=loadImage("Isaac3.png");
  isaac.resize(isaac.width/4, isaac.height/4);

  leyes=loadImage("Leyes.png");
  leyes.resize(leyes.width/2, leyes.height/2);
  
  robopsico=loadImage("Robopsicologia.png");
  robopsico.resize(robopsico.width/2, robopsico.height/2);
  
  ray=loadImage("Ray.jpg");
  ray.resize(ray.width/4,ray.height/4);
  
  f451=loadImage("f451.jpg");
  f451.resize(f451.width*3/4, f451.height*3/4);
  
  feria=loadImage("Feria.jpg");
  feria.resize(feria.width/3, feria.height/3);
  
 
   video = new Capture(this, 640, 480, "HP TrueVision HD Camera", 30);
   video2 = new Capture(this, 640, 480, "DroidCam Source 3", 32);

  //name=HP TrueVision HD Camera,size=640x480,fps=30
  
  //OpencvR = new OpenCV(this, 640, 480);
  OpencvR = new OpenCV(this, 320, 240);
  OpencvR.loadCascade(OpenCV.CASCADE_FRONTALFACE);  


  //video.start();
  noLoop();
}



void draw() {
  
  //if (  video.available() == true )
  //  video.read()
  background(30);
  
  //disparo de detección: Bienvenida
  if(step==0)
  {
      
      if(key=='a')
      {
        fondo.amp(1.0);
        fondo.play();
        delay(2000);
        audio(0);
        actual.play(); 
        while(actual.isPlaying())
        {delay(1);}
        step=1;
        ti=millis();
        cGeneral=0;
        audioON=false;
        audioListo=false;
        audioHolaN=false;
      }
      else if(key=='3')
      {
        step=3;
        audioON=false;
      }
      else if(key=='6')
      {
         step=6;
         audioON=false;
         Bsonrisa=false;
         BojoN=false;
         BdientesN=false;
         BotraocasionN=false;
         fSonriendo=0; 
      }
        else if(key=='7')
      {
           step=7;
           audioON=false; 
      }
        else if(key=='8')
      {
           step=8;
           audioON=false; 
      }
  }

  //Detección de Rostro: Primera desición: Te distingo o no
  if(step==1)
  {
      
      //video.read();
      image(video, 320, 120);
      //pcv=get();
      pcv=get(320,120,video.width,video.height);
      pcv.resize(320,240);
      OpencvR.loadImage(pcv);
      faces = OpencvR.detect();
      
      
      noFill();
      stroke(0, 255, 0);
      strokeWeight(3);
      if(faces.length>0)
      {
          if((faces[0].width>lcara) && (faces[0].height>lcara))
          {
              //rect(faces[0].x, faces[0].y, faces[0].width, faces[0].height);
               rect(faces[0].x*2+320, faces[0].y*2+120, faces[0].width*2, faces[0].height*2);
               cGeneral++;
          }
          //println("Tamaño= ",faces[0].width);
      }
      //println("Frames= ",cGeneral);
     
      t=millis()-ti;
      if(t>tposicionamiento)
      {
          if((cGeneral>=fdeseados)&&(!audioON))
          {
              audio(2);    
              actual.play();
              audioON=true;
              audioListo=true;
          }
          else if((cGeneral<fdeseados)&&(!audioON))
          {
              audio(1);  
              actual.play();
              audioON=true;
              audioHolaN=true;
          }
          if(  !actual.isPlaying()  )
          {    
               if(audioHolaN)
                 step=2;
               
               else
                 step=3;
                      
                 audioON=false;      
        }
      }
  }
  
  //Paso en caso de no distinción inicial
  if(step==2)
  {
      //video.read();
      
      image(video, 320, 120);
      //pcv=get();
      pcv=get(320,120,video.width,video.height);
      pcv.resize(320,240);
      OpencvR.loadImage(pcv);
      faces = OpencvR.detect();
      
      //OpencvR.loadImage(video);
      //faces = OpencvR.detect();
      //image(video, 0, 0 );
      
      noFill();
      stroke(0, 255, 0);
      strokeWeight(3);
      if(faces.length>0)
      {
          if((faces[0].width>lcara) && (faces[0].height>lcara))
               //rect(faces[0].x, faces[0].y, faces[0].width, faces[0].height);
               rect(faces[0].x*2+320, faces[0].y*2+120, faces[0].width*2, faces[0].height*2);
        
      }
      
      if((audioHolaN)&&(!audioON))
      {
          audio(2);
          actual.play();     
          audioON=true;
      }
      if(!actual.isPlaying())
      {    
           step=3;
           audioON=false;
      }
      
  }
  
   if((step==3))
  {
      if((!audioON))
      {
          audio(3);
          actual.play(); 
          audioON=true;
          tCambio=0;
          ti=millis(); 
      }
      
      
     image(video, 320, 120);
      pcv=get(320,120,video.width,video.height);
      pcv.resize(320,240);
      OpencvR.loadImage(pcv);
      faces = OpencvR.detect();
      
      noFill();
      stroke(0, 255, 0);
      strokeWeight(3);
      if(faces.length>0)
      {
          if((faces[0].width>lcara) && (faces[0].height>lcara))
          {
          
               
                //rect(faces[0].x*2, faces[0].y*2-40, faces[0].width*2, faces[0].height*2+80);
               
               
               if(!actual.isPlaying())
                {    
                    
                    image(robot, 320+ faces[0].x*2-25, 120+faces[0].y*2-170, faces[0].width*2+80, faces[0].height*2+260);
                }
          }
      }
      
      t=millis()-ti;
      if(t>20000)
      {
        
             step=5;
             audioON=false;
        
      }
  }
  
  /*
  //Segumiento de rostro
  if((step==3)||(step==4))
  {
      if((!audioON))
      {
          lado = new SoundFile(this, "Lado.wav", false);
          lado.play(); 
          audioON=true;
          tCambio=0;
          ti=millis(); 
      }
      
      //video.read();
      
      image(video, 0, 0);
      pcv=get();
      pcv.resize(320,240);
      OpencvR.loadImage(pcv);
      faces = OpencvR.detect();
      
      noFill();
      stroke(0, 255, 0);
      strokeWeight(3);
      if(faces.length>0)
      {
          if((faces[0].width>lcara) && (faces[0].height>lcara))
          {
               //rect(faces[0].x, faces[0].y, faces[0].width, faces[0].height);
               rect(faces[0].x*2, faces[0].y*2, faces[0].width*2, faces[0].height*2);
               centro=  faces[0].x*2  +  faces[0].width;
               //circle(centro, 240, 10);
               
               if(!lado.isPlaying())
                {    
                    if (  (centro<(width/2-35))  &&  (faces[0].width>lcara)  &&  (faces[0].height>lcara)  )  
                    {
                        //serial.println(-5);    
                        tCambio=tCambio+5;
                    
                    }
                    else if (centro>(width/2+35)&&(faces[0].width>lcara) && (faces[0].height>lcara))
                    {
                        //serial.println(5);
                        tCambio=tCambio+5; 
                    }
                    println(tCambio);                    
                }
          }
      }
      
      t=millis()-ti;
      if(t>10000)
      {
        
          if (tCambio>80)
          {
             step=5;
             audioON=false;
          }
          else
          {
              tCambio=0;
              if(step==3)
              {
                  moverteN = new SoundFile(this, "MoverteN.wav");
                  moverteN.play();
                  step=4;
              }
              if(!moverteN.isPlaying())
              {    
                  step=5;
                  audioON=false;
                  moverteN.removeFromCache();
              }
          }
      }
  }

  */
  //Texto largo "Vuelve al centro Platicar
  if(step==5)
  {
      if(!audioON)
      {
          audio(4);
          actual.play();    
          audioON=true;
          ti=millis();
      }
      
      //video.read();
      image(video, 320, 120);
      pcv=get(320,120,video.width,video.height);
      pcv.resize(320,240);
      OpencvR.loadImage(pcv);
      faces = OpencvR.detect();
      
      noFill();
      stroke(0, 255, 0);
      strokeWeight(3);
      if(faces.length>0)
      {
          if((faces[0].width>lcara) && (faces[0].height>lcara))
               rect(320+faces[0].x*2, 120+faces[0].y*2, faces[0].width*2, faces[0].height*2);
               //rect(faces[0].x, faces[0].y, faces[0].width, faces[0].height);
          
      }
      
      t=millis()-ti;      
      if(  (t>11500)&&(t<35500)  )
      {    image(sophia,320+420,120+10);
      }
      
      if(  (t>16000)&&(t<35500)  )
      {    image(isaac,320+20,120+10);
      }
      
      if(  (t>27500)&&(t<35500)  )
      {    image(leyes,320+20,120+300);
      }
      
      if(  (t>30500)&&(t<35500)  )
      {    image(robopsico,320+400,120+280);
      }
      
      if(!(actual.isPlaying()) )
      {    step=6;
           audioON=false;
           Bsonrisa=false;
           BojoN=false;
           BdientesN=false;
           BotraocasionN=false;
           fSonriendo=0;
      }
      
  }
  
  
  //Sonrisa
  if(step==6)
  {
      if(!Bsonrisa)
      {
          audio(5);
          actual.play();    
          Bsonrisa=true;
          ti=millis();
      }
      
      //video.read();
      image(video, 320, 120);
      pcv=get(320,120,video.width,video.height);
      pcv.resize(320,240);
      OpencvR.loadImage(pcv);
      faces = OpencvR.detect();
      
      noFill();
      stroke(0, 255, 0);
      strokeWeight(3);
      if(faces.length>0)
      {
          if((faces[0].width>lcara) && (faces[0].height>lcara))
          {
               rect(320+faces[0].x*2, 120+faces[0].y*2, faces[0].width*2, faces[0].height*2);
               
               
               //Detección de nariz
               Irostro = get(320+faces[0].x*2, 120+ faces[0].y*2, faces[0].width*2, faces[0].height*2);
               Irostro.resize(200,200);
               image(Irostro, width/2, 0 );
               
               stroke(255,0, 0);
               strokeWeight(1);
               
                       rect(width/2+50, Irostro.height*2/3, Irostro.width-100 , Irostro.height/3-5);
              
                       //Rectángulo de la boca y detección de sonrisa
                       Iboca= Irostro.get(50, Irostro.height*2/3, Irostro.width-100 , Irostro.height/3-5);
                       image(Iboca, width/2, 200 );
                       
                       Iboca.filter(THRESHOLD, 0.67);
                       int cont=0;
                       for(int k=0; k<Iboca.pixels.length;k++){
                           if(brightness(Iboca.pixels[k])==255)
                           {cont++;}
                       }
                      
                      //80, threshold para sonrisa
                      if(  (cont>80)  &&  (fSonriendo<15)  )
                           fSonriendo++; 
                      
                      
                      println("Pixeles blancos", cont);
                      println("frames sonriendo", fSonriendo);
                  
          }//Cara útil
      }//Hay cara
      
      t=millis()-ti;      
      if (t>8000)
      {
           if(fSonriendo==15)
           {
               if (  (!audioON)  &&  !(actual.isPlaying())  ){ 
                   audio(9);
                   actual.play();
                   audioON=true;
               }
               if (  !(actual.isPlaying())  &&   (audioON))
               {
                   step=7;
                   audioON=false;
               }
           }
           else
           {
              if (!BojoN){ 
                 audio(6);
                 actual.play();
                 BojoN=true;
              }
              
              if (t>16000)
              {
                 if (!BdientesN){
                    audio(7);
                    actual.play();
                    BdientesN=true;
                 }
              }
              
              if (t>24000)
              {
                 if (!BotraocasionN){
                    audio(8);
                    actual.play();
                    BotraocasionN=true;
                 }
                    
                 if(  !(actual.isPlaying())  ){
                     step=7;
                     audioON=false;
                 }
        
              }
    
           }//No hay frames de sonrisa suficientes
      }//t>5 seg
    
  }
  
  
  if(step==7)
  {
   
      if(  (!audioON)  )
      {
          audio(10);
          actual.play();
          audioON=true;
          fondo2.amp(1.0);
          ti=millis();
          vol=1.0;
          cam=false;
          //frameRate(5);
      }
      
     if(  !(actual.isPlaying())  )
     {
         vol=vol-0.01;  
         fondo2.amp(vol);
         background(0);
         if( vol<0.07)
         {
             step=8;
             fondo2.stop();
             audioON=false;
         }
     }
      
     t=millis()-ti;
        
         if (t<21501)
         {
            //video.read();
           image(video, 320, 120); 
         }
         else if (  (t>21500)  &&  (t<24001)  )
            background(0);
         else if (  (t>24000)  &&  (t<30001)  )
         {
           if (!fondo2.isPlaying())
           {
               fondo2.play();
               video.stop();
           }
           
           image(ray, 320+80, 120+10);
           if (  (t>27000) )
           {
              image(f451, 320+245, 120+240);     
              if (!cam)
              {
              //video2.start();
              cam=true;
              }
           }
         }
      
     
     else if (  (t>30000) && (actual.isPlaying())  )
     {   
          video.read();
          nya.detect(video);
          background(0);
          nya.drawBackground(video);//frustumを考慮した背景描画
          if((!nya.isExist(0))){
            return;
          }     
          nya.beginTransform(0);
          translate(0,0,20);
          rotateX(-PI/2);
          image(loopingGif, -150, -300);
          nya.endTransform();    
     }
     
     
  }
  
  
  if(step==8)
  {
      if(!audioON)
      {
          background(0);
          delay(1200);
          fondo.amp(1.0);
          fondo.play();   
          delay(2000);
          audio(11);
          actual.play();
          audioON=true;
          cGeneral=0;
          vol=1.0;
      }
      
      cGeneral++;
      if(cGeneral<254)
      {
          background(0);
          tint(255,cGeneral);
          image(feria, 320+25, 120+120 );
      }
     
      
      if(!(actual.isPlaying()) )
      {    
        
           vol=vol-0.005;  
           fondo.amp(vol);
           if( vol<0.07)
           {
               step=9;
               fondo.stop();
               delay(1000);
               audioON=false;
               video2.stop();
               background(30);
               noLoop();
               //return;
           }
      }
      
  }
  
 

}


void keyPressed() {
  println(key);

  step=0;
  video.start();
  loop();
 
}



void captureEvent(Capture c) {
  c.read();
}

void audio (int elegido)
{
  if (elegido==0)
  {
      actual=null;
      actual = new SoundFile(this, "Hola.wav", false);
  }
  else if (elegido==1)
  {
     actual=null;
     actual = new SoundFile(this, "HolaN.wav", false); 
  }
  else if (elegido==2)
  {
      actual=null;
      actual = new SoundFile(this, "Listo.wav", false);
  }
  else if (elegido==3)
  {
      actual=null;
      actual = new SoundFile(this, "Lado.wav", false);
  }
  else if (elegido==4)
  {
      actual=null;
      actual = new SoundFile(this, "Platicar.wav", false);
  }
  else if (elegido==5)
  {
      actual=null;
      actual = new SoundFile(this, "Sonrisa.wav", false);
  }
  else if (elegido==6)
  {
      actual=null;
      actual = new SoundFile(this, "OjoN.wav", false);
  }
  else if (elegido==7)
  {
      actual=null;
      actual = new SoundFile(this, "DientesN.wav", false);
  }
  else if (elegido==8)
  {
     actual=null;
     actual = new SoundFile(this, "OtraOcasionN.wav", false); 
  }
  else if (elegido==9)
  {
     actual=null;
     actual = new SoundFile(this, "GranSonrisa.wav", false); 
  }
  else if (elegido==10)
  {
     actual=null;
     actual = new SoundFile(this, "Reflexion.wav", false); 
  }
  else if (elegido==11)
  {
     actual=null;
     actual = new SoundFile(this, "Adios.wav", false); 
  }
}


  
