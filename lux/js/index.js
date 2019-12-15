var list = [
  "Cojone",
  "Imbecille",
  "Te odio",
  "Cazzo se te odio",
  "Stupeto",
  "Te disprezzo",
  "Fai schifo",
  "Fai cagare",
  "'mbecille"
];

function myFunction() {
    var nuovoInsulto = document.getElementById('add').value; 
    list.push(nuovoInsulto);
}

function Cojone(){
var lucidi = list[Math.floor(Math.random()*list.length)];

document.getElementById('message').innerHTML = lucidi;
}

