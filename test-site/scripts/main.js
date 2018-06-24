var image = document.querySelector('img');

image.onclick = function() {
	var mysrc = image.getAttribute('src')
	if(mysrc === 'images/dog.jpg') {
		image.setAttribute('src', 'images/chromelogo.jpg');
	} else {
		image.setAttribute('src', 'images/dog.jpg');
	}
}

var myButton = document.querySelector('button');
var myHeading = document.querySelector('h1')

function setUserName() {
	var myName = prompt('enter your name');
	localStorage.setItem('name', myName);
	myHeading.innerHTML = 'Hello : ' + myName;
}
var a = Math.sqrt(4)
if (!localStorage.getItem('name')) {
	setUserName();
} else {
	var storedName = localStorage.getItem('name');
	myHeading.innerHTML = 'Hello : ' + storedName;
}

myButton.onclick = function() {
	setUserName();
}
var xiaoming = {
    name: '小明',
    birth: 1990,
    school: 'No.1 Middle School',
    height: 1.70,
    weight: 65,
    score: null,
    age: function() {
    	var y = new Date().getFullYear();
    	return y - this.birth;
    }
};
function max(a, b) {

    if (a > b) {
       var c = 0;
    } 
    console.log(c);

    return b;
  
}
var arr = []; 
for (var i = 1; i <= 3; i++) {
    arr.push(function (x) {
    	return function() {
    		return x*x;
    	}
    }(i));
}

function* fib(num) {
	var 
	    a = 0;
	    b = 1;
	    n = 0;
	while (n < num) {
		yield a;
		[a, b] = [b, a+b];
        n++;
	}
	return;
}

console.log(fib(5).next()['done']);
var re1 = /^\d{3}\-\d{3,8}$/;
re1.test('010-1234');

window.onload = function() {
	console.log('finish loading');
}

var js = document.querySelector('#test-p')
var arr = document.querySelectorAll('.c-red.c-green > p');
var haskell = document.querySelectorAll('.c-green:not(.c-red) > p')[1];