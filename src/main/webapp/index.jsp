<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale-1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link type="text/css" rel="stylesheet" href="style.css">
    <title>Calculator</title>
</head>

<style>
    *{
    box-sizing: border-box;
    outline: none;
}

body{
    background: #f1f3fc;
}

.app{
    display:flex;
    width: 100vw;
    height: 100vh;
    justify-content: center;
    align-items: center;
}

.display{
    text-align: right;
    width: 510px;
    background: #000;
    color: #fff;
    font-size: 40px;
    padding: 30px;
    border-radius: 20px 20px 0px 0px;
    border: 4px solid #000;
    border-bottom: none;
    box-shadow: 3px 4px 10px #a1a1a1;
}

.buttons{
    display: flex; 
    flex-wrap: wrap; 
    justify-content: space-between;
    align-items: center;
    width: 510px;
    border: 4px solid #000; 
    position: relative;
    padding: 18px 15px;
    border-radius: 0px 0px 20px 20px;
    background: #fff;
    box-shadow: 3px 4px 10px #a1a1a1;
}

button{
    font-size: 20px;
    padding: 15px;
    width: 110px;
    margin: 5px 0px;
    border-radius: 20px;
    color: #e5e5e5;
    background: #111;
    box-shadow: 1px 1px 2px #111;
}

button:hover{
    font-size: 24px;
    padding: 12px 15px;
    background: #2a2a2a;
    box-shadow: 4px 4px 5px #5d5d5d;
}

.equal{
    position: absolute;
    right: 15px;
    bottom: 18px;
    height: 120px;
}
</style>



<script>
    let display = document.getElementById("display");
let buttons = document.getElementsByClassName("btn");

let operations="0";
let mr = "0";

for(let i = 0; i < buttons.length; i++)
{
    let button = buttons[i];

    button.addEventListener("click", function(){operation(button)});
}

document.addEventListener("keydown", function(event){
    if(event.key == "0")
        operation(buttons[20]);
    else if(event.key == "1")
        operation(buttons[16]);
    else if(event.key == "2")
        operation(buttons[17]);
    else if(event.key == "3")
        operation(buttons[18]);
    else if(event.key == "4")
        operation(buttons[12]);
    else if(event.key == "5")
        operation(buttons[13]);
    else if(event.key == "6")
        operation(buttons[14]);
    else if(event.key == "7")
        operation(buttons[8]);
    else if(event.key == "8")
        operation(buttons[9]);
    else if(event.key == "9")
        operation(buttons[10]);
    else if(event.key == "Backspace")
        operation(buttons[5]);
    else if(event.key == "/")
        operation(buttons[6]);
    else if(event.key == "*")
        operation(buttons[7]);
    else if(event.key == "-")
        operation(buttons[11]);
    else if(event.key == "+")
        operation(buttons[15]);
    else if(event.key == "=" || event.key == "Enter")
        operation(buttons[22]);
    else if(event.key == ".")
        operation(buttons[21]);
        
});

function operation(button){
    switch(button.classList.contains("number")){
        case true:
            if(typeof(operations) == "number")
                operations = "0";
            
            if(button.dataset.value === "."){
                for(let j = operations.length -1; j>=0 ; j-- )
                    switch(operations[j]){
                        case "+":
                        case "-":
                        case "*":
                        case "/":
                            for(let k = j+1; k < operations.length; k++){
                                if(operations[k] == "."){
                                    return
                                }
                            }
                        concatOperation(button);
                        display.innerHTML = operations;
                        return;
                    }
                for(let l = operations.length -1; l >= 0 ; l--)
                    if(operations[l] == ".")
                        return;
                    concatOperation(button);
            }
            
            else{
                concatOperation(button);
            }
            display.innerHTML = operations;
            break;


        case false:
            if(button.classList.contains("operator")){
                switch(operations[operations.length - 1]){
                    case "+":
                    case "-":
                    case "*":
                    case "/":
                        callAction(buttons[5]); 
                    default:
                        concatOperation(button);
                }
                
                display.innerHTML = operations;
            }
            else if(button.classList.contains("action")){
                callAction(button);
                display.innerHTML = operations;
            }
            else{
                callMemory(button);
            }
    }



function concatOperation(button){
    if(operations === "0" && button.classList.contains("number") && !(button.classList.contains("dot"))){
        operations = button.dataset.value;
        return;
    }
        
    operations += button.dataset.value;
}



function callAction(button){
    if(button.dataset.value == "backspace"){
        if(operations == 0)
            return;
        else if(typeof(operations) == "number"){
            operations = "0";
            return;
        }
        else if(operations.length == 1){
            operations = "0";
            return;
        }
            
        operations = operations.slice(0, -1);
    }
    else if(button.dataset.value == "clear"){
        operations = "0";
    }
    else{
        switch(operations[operations.length - 1]){
            case "+":
            case "-":
            case "*":
            case "/":
                return;
        }
        operations = eval(operations);
    }
}



function callMemory(button){
    if(button.dataset.value == "mem-display"){
        display.innerHTML = mr;
        operations = "0";
    }

    else if(button.dataset.value == "mem-clear"){
        mr = "0";
    }
   
    else if(button.dataset.value == "mem-add"){
        mr = operations + "+" + mr;
        mr = eval(mr);
    }
   
    else{
        mr = operations + "-" + mr;
        mr = eval(mr);
    }
}

}
</script>


<body>
    <div class="app">
        <div class="calc">
                <div class="display" id="display">0</div>
                <div class="buttons">
                    <button class="btn memory" data-value="mem-add">m+</button>
                    <button class="btn memory" data-value="mem-sub">m-</button>
                    <button class="btn memory" data-value="mem-clear">mc</button>
                    <button class="btn memory" data-value="mem-display">mr</button>
                    <button class="btn action" data-value="clear">C</button>
                    <button class="btn action" data-value="backspace">CE</button>
                    <button class="btn operator" data-value="/">/</button>
                    <button class="btn operator" data-value="*">x</button>
                    <button class="btn number" data-value="7">7</button>
                    <button class="btn number" data-value="8">8</button>
                    <button class="btn number" data-value="9">9</button>
                    <button class="btn operator" data-value="-">-</button>
                    <button class="btn number" data-value="4">4</button>
                    <button class="btn number" data-value="5">5</button>
                    <button class="btn number" data-value="6">6</button>
                    <button class="btn operator" data-value="+">+</button>
                    <button class="btn number" data-value="1">1</button>
                    <button class="btn number" data-value="2">2</button>
                    <button class="btn number" data-value="3">3</button>
                    <button></button>
                    <button class="btn number" data-value="00">00</button>
                    <button class="btn number" data-value="0">0</button>
                    <button class="btn number dot" data-value=".">.</button>
                    <button></button>
                    <button class="btn action equal" data-value="calculate">=</button>
                </div>
        </div>
    </div>
    <script src="script.js"></script>
</body>
</html>