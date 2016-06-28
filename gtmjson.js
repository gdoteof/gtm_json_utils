var stdin = process.stdin;
var inputChunks = '';

stdin.on('data', function (chunk) {
      inputChunks += chunk;
});

stdin.on('end', function(){
  var input = inputChunks;
  var j = JSON.parse(input);
  var newtags = [];
  outer:
    for(tag in j.containerVersion.tag){
      inner:
         for(param in j.containerVersion.tag[tag].parameter){
            var p = j.containerVersion.tag[tag].parameter[param].key;
            if(p == "eventLabel" || p == "eventCategory" || p=="eventAction"){
              newtags.push(j.containerVersion.tag[tag]);
              continue outer;
            }
         }
    }
  j.containerVersion.tag = newtags;

  console.log(JSON.stringify(j));
  
})
