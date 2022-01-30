import java.util.ArrayList; // Hilft bei der Speicherung des Morsecodes

int bx = 300; //x-Position des Butons
int by = 350; //y-Position des Buttons
int bb = 355; //Breite des Buttons
int bh = 40; //Höhe des Buttons

int ex = 20; //x-Position des Eingabefelds
int ey = 30; //y-Position des Eingabefelds
int eb = 960; //Breite des Eingabefelds
int eh = 300; //Höhe des Eingabefelds

int ax = 20;
int ay = 430;
int ab = 960; //Breite des Ausgabefelds
int ah = 300; //Höhe des Ausgabefelds


int buttonClickedDrawCalls = 0;

int anzahlZeilenumbrueche = 0; // Zählt die Zeilenumbrüche, gibt gleichzeitig die aktuelle Zeile zurück
int[] zeichenProZeile = {0,0,0,0,0,0,0,0,0}; //Zählt die Zeichen pro Zeile um die Zeilenlänge nicht zu übersteigen

static int anzahlZeilenumbruecheMorse = 0;
static ArrayList<Integer> zeichenProZeileMorse = new ArrayList<Integer>(); 

boolean aufButtonX = false;
boolean aufButtonY = false;

boolean aufEingabefeldX = false;
boolean aufEingabefeldY = false;

boolean buttonClicked = false;
String klartext = "";
String morsetext = "";

void setup(){
  size(1000,750);
  background(240);
  
  // Überschrift Eingabefeld
  fill(0);
  textSize(20);
  text("Eingabe Klartext:",20,20);
  
  // Überschrift Ausgabetext
  fill(0);
  textSize(20);
  text("Ausgabe Morsecode:",20,420);
  
  //Ausgabefeld
    fill(255);
    stroke(0);
    strokeWeight(2);
    rect(ax,ay,ab,ah);
 // selectInput("Select a file to process:", "fileSelected");
}



void draw(){
  aufButtonX = bx <= mouseX && bx + bb >= mouseX;
  aufButtonY = by <= mouseY && by + bh >= mouseY;
  aufEingabefeldX = ex <= mouseX && ex + eb >= mouseX;
  aufEingabefeldY = ey <= mouseY && ey + eh >= mouseY;
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
  if(aufEingabefeldX && aufEingabefeldY){
    stroke(0,200,255);
  }
  strokeWeight(2);
  rect(ex,ey,eb,eh);
  //Text in Eingabefeld
  fill(0);
  textSize(20);
  text(klartext,ex+5,ey+20);
  stroke(0);
}
void zeilenumbruch(){
  // Hilfsfunktion zum einfügen eines Zeilenumbruchs
  if(anzahlZeilenumbrueche<8){
    klartext+='\n';
    anzahlZeilenumbrueche++;
  }
}

// Funktion würd Aufgerufen,wenn eine Taste gedrückt wird
void keyPressed(){
  switch(key){
    case ENTER:
      zeilenumbruch();
      break;
    case BACKSPACE:
      if(klartext.length()>0){
        if(klartext.charAt(klartext.length()-1)=='\n'){
          anzahlZeilenumbrueche--;
        }
        zeichenProZeile[anzahlZeilenumbrueche]--;
        klartext = klartext.substring(0,klartext.length()-1);
      }
      break;
    default:
      if(zeichenProZeile[anzahlZeilenumbrueche]<56){
        if(istKonvertierbar(key)){
          klartext+=key;
          zeichenProZeile[anzahlZeilenumbrueche]++;
        }
      }
      else{
        zeilenumbruch();
        }
      break;
 }
}


void mouseClicked(){
  if(aufButtonX && aufButtonY){
    buttonClicked=true;
    morsetext = umwandelnInMorse(klartext);
    System.out.println(morsetext);
   
    //Textfeld Ausgabe
    fill(255);
    stroke(0);
    strokeWeight(2);
    rect(ax,ay,ab,ah);
    //Text im Ausgabefeld
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


  
public String umwandelnInMorse(String klartext){
  klartext = klartext.toUpperCase();
  String morsetext = "";
  String morseZeichen = "";
  int zeilenLaenge;
  int klartextLaenge = klartext.length();
  
  zeichenProZeileMorse.add(0);
  for(int i=0; i<klartextLaenge;i++){
    morseZeichen = buchstabenUmwandeln(klartext.charAt(i));
    // Länge des Zeichens aus dem Morsecode +1 für das Leerzeichen
    morsetext += morseZeichen + " ";
    zeilenLaenge = zeichenProZeileMorse.get(anzahlZeilenumbruecheMorse);
    zeilenLaenge += morseZeichen.length()+1;
    zeichenProZeileMorse.set(anzahlZeilenumbruecheMorse,zeilenLaenge);
    
    if(zeichenProZeileMorse.get(anzahlZeilenumbruecheMorse)>155){
      anzahlZeilenumbruecheMorse++;
      zeichenProZeileMorse.add(0);
      morsetext += '\n';
    }
    }
  if(anzahlZeilenumbruecheMorse>8){
    // https://processing.org/reference/saveStrings_.html (30.01.2022 13:05 Uhr)
    String[] list = split(morsetext, '\n');

    // Writes the strings to a file, each on a separate line
    saveStrings("output.txt", list);
    return "der Morsecode ist zu lang für das Ausgabefeld. \nihre Ausgabe wurde in der Datei \"output.txt\" gespeichert";
      }
  else{
  return morsetext;
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
  }
}
  
/*  
public static void main(String[] args){
  String klartext = "Hallo Welt!";
  String morsetext = umwandelnInMorse(klartext);
  System.out.println(morsetext);
}*/
