int bx = 300; //x-Position des Butons
int by = 340; //y-Position des Buttons
int bb = 355; //Breite des Buttons
int bh = 40; //Höhe des Buttons

int ex = 20; //x-Position des Eingabefelds
int ey = 20; //y-Position des Eingabefelds
int eb = 960; //Breite des Eingabefelds
int eh = 300; //Höhe des Eingabefelds

int ax = 20;
int ay = 400;
int ab = 960; //Breite des Eingabefelds
int ah = 300; //Höhe des Eingabefelds

int anzahlZeilenumbrueche = 0;
int buttonClickedDrawCalls = 0;

boolean aufButtonX = false;
boolean aufButtonY = false;
boolean buttonClicked = false;
String klartext = "";
String morsetext = "";

void setup(){
  size(1000,720);
  background(240);
  
  //Textfeld
    fill(255);
    stroke(0);
    strokeWeight(2);
    rect(ax,ay,ab,ah);
}

void draw(){
  aufButtonX = bx <= mouseX && bx + bb >= mouseX;
  aufButtonY = by <= mouseY && by + bh >= mouseY;
  if (aufButtonX && aufButtonY){
    fill(0,200,255);
  }
  else{
    fill(0,150,255);
  }
  if(buttonClicked){
      fill(0,100,255);
      buttonClickedDrawCalls++;
      //Das dunkle Blau wird für 8 Frames als Buttonfarbe gezeichnet
      if(buttonClickedDrawCalls>8){
        buttonClickedDrawCalls = 0;
        buttonClicked=false;
      }
    }
  rect(bx,by,bb,bh);
  textSize(30);
  fill(0);
  text("In Morsecode konvertieren",bx+10,by+bh-10);
  
  //Eingabefeld
  fill(255);
  stroke(0);
  strokeWeight(2);
  rect(ex,ey,eb,eh);
  //Text in Eingabefeld
  fill(0);
  textSize(20);
  text(klartext,ex+5,ey+20);
}

void keyPressed(){
  switch(key){
    case ENTER:
      if(anzahlZeilenumbrueche<8){
        klartext+='\n';
        anzahlZeilenumbrueche++;}
      break;
    case BACKSPACE:
      if(klartext.length()>0){
        if(klartext.charAt(klartext.length()-1)=='\n'){
          anzahlZeilenumbrueche--;
        }
        klartext = klartext.substring(0,klartext.length()-1);
      }
      break;
    default:
      if(istKonvertierbar(key)){
        klartext+=key;
    }
      break;
  }
}

void mouseClicked(){
  if(aufButtonX && aufButtonY){
    buttonClicked=true;
    morsetext = umwandelnInMorse(klartext);
    System.out.println(morsetext);
    
    
    //Textfeld
    fill(240);
    stroke(0);
    strokeWeight(2);
    rect(ax,ay,ab,ah);
    //Text im Textfeld
    fill(0);
    textSize(20);
    text(morsetext,ax+5,ay+20);
  }
}

public static boolean istKonvertierbar(char buchstabe){
  String buchstabeString = Character.toString(buchstabe); 
  buchstabeString = buchstabeString.toUpperCase();
  String konvertierbar = "ABCDEFGHIJKLMNOPQRSTUVWXYZ ÄÖÜß1234567890+-*?/.:'ÉÈ=()@";
  for(int i=0; i<konvertierbar.length(); i++){
    if(buchstabeString.charAt(0) == konvertierbar.charAt(i)){
      return true;
    }
  }
  return false;
}


public static String buchstabenUmwandeln(char buchstabe){
  //Quelle: https://www.code-knacker.de/morsealphabet.htm
  String[][] morseAlphabet = {{"A",".-"},{"B","-..."},
                                {"C","-.-."},{"D","-.."},
                                {"E","."},{"F","..-."},
                                {"G","--."},{"H","...."},
                                {"I",".."},{"J",".---"},
                                {"K","-.-"},{"L",".-.."},
                                {"M","--"},{"N","-."},
                                {"O","---"},{"P",".--."},
                                {"Q","--.-"},{"R",".-."},
                                {"S","..."},{"T","-"},
                                {"U","..-"},{"V","...-"},
                                {"W",".--"},{"X","-..-"},
                                {"Y","-.--"},{"Z","--.."},
                                {" "," "},{"Ä",".-.-"},
                                {"Ö","---."},{"Ü","..--"},
                                {"ß","...--.."},{"1",".----"},
                                {"2","..---"},{"3","...--"},
                                {"4","....-"},{"5","....."},
                                {"6","-...."},{"7","--..."},
                                {"8","---.."},{"9","----."},
                                {"0","-----"},{"+",".-.-."},
                                {"-","-....-"},{"*","-..-"},
                                {"/","-..-."},{"?","..--.."},
                                {".",".-.-.-"},{":","---..."},
                                {"'",".----."},{"É","..-.."},
                                {"È",".-..-"},{"(","-.--."},
                                {"=","-...-"},{")","-.--.-"},
                                {"@",".--.-."}
                              };
   int morseAlphabetLaenge = morseAlphabet.length;
   // Im Fall eines Zeilenumbruchs, wird einfach ein Leerzeichen eingefügt
   if(buchstabe == '\n'){
     return " ";
   }
   for(int i=0; i<morseAlphabetLaenge; i++){
     
     if(morseAlphabet[i][0].equals(String.valueOf(buchstabe))){
       return morseAlphabet[i][1];
     }
   }
  return " (Fehler: Zeichen " + String.valueOf(buchstabe) + " nicht konvertierbar) ";
  }
  
  
public static String umwandelnInMorse(String klartext){
  klartext = klartext.toUpperCase();
  String morsetext = "";
  String morseZeichen = "";
  int klartextLaenge = klartext.length();
  for(int i=0; i<klartextLaenge;i++){
    morseZeichen = buchstabenUmwandeln(klartext.charAt(i));
    morsetext = morsetext + morseZeichen + " ";
  }
  return morsetext;
}
  
/*  
public static void main(String[] args){
  String klartext = "Hallo Welt!";
  String morsetext = umwandelnInMorse(klartext);
  System.out.println(morsetext);
}*/
