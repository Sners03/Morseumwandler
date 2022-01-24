int bx = 300; //x-Position des Butons
int by = 300; //y-Position des Buttons
int bb = 355; //Breite des Buttons
int bh = 40; //Höhe des Buttons

int ex = 20; //x-Position des Eingabefelds
int ey = 20; //y-Position des Eingabefelds
int eb = 960; //Breite des Eingabefelds
int eh = 260; //Höhe des Eingabefelds

boolean aufButtonX = false;
boolean aufButtonY = false;
String klartext = "";

void setup(){
  size(1000,600);
  background(240);
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
      klartext+='\n';
      break;
    case BACKSPACE:
      if(klartext.length()>0){
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

public static boolean istKonvertierbar(char buchstabe){
  String buchstabeString = Character.toString(buchstabe); 
  buchstabeString = buchstabeString.toUpperCase();
  String konvertierbar = "ABCDEFGHIJKLMNOPQRSTUVWXYZ ÄÖÜß1234567890+-*/?.:'ÉÈ=()@";
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
