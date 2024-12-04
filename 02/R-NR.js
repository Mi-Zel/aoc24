input = readFile("input.txt");
input = input.split("\n");
console.log(countSafe(input));

function countSafe(input){
    let safe = 0;
    for (row of input){
        let levels = row.split(" ");
        if (problemDumpener(levels)){
            safe++;
        }
    }
    return safe;
}

function problemDumpener(levels){
    if (safeLevel(levels)){
        return true;
    }
    for (let i = 0; i < levels.length; i++){
        if (safeLevel(levels.slice(0, i).concat(levels.slice(i + 1)))){
            return true;
        }
    }
    return false;
}

function safeLevel(levels){
    if (levels.length < 2){return false;}
    let ascending = parseInt(levels[0]) < parseInt(levels[1]);
    for (let i = 0; i < levels.length - 1; i++){
        let a = parseInt(levels[i]);
        let b = parseInt(levels[i + 1]);
        if (Math.abs(a - b) <= 3 && a != b){
            if (ascending){
                if (a >= b) {return false;}
            } else { // descending
                if (a <= b){return false;}
            }
        } else {
            return false;
        } 
    }
    return true;
}

function readFile(file){
    return require("fs").readFileSync(file, "utf-8");
}