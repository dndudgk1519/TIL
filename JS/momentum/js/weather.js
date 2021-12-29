const API_KEY = "a3fdc1311117613f8202169382bdf6a0"; 


function onGeoOk(position) {
    const lat = position.coords.latitude;
    const lon = position.coords.longitude;
    // console.log(position);

    const url = `https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${API_KEY}&units=metric`;
    fetch(url).then(response => response.json()).then((data) => {
        const weather = document.querySelector("#weather span:first-child");
        const city = document.querySelector("#weather span:last-child");
        city.innerText = data.name;
        weather.innerText = `${data.weather[0].main} / 대략 ${Math.round(data.main.temp)}도 입니다.`;
        // console.log(data);
        // console.log(url);
        console.log(data);
    }); 
}

function onGeoError() {
    alert("위치를 찾을 수 없습니다.");
}


navigator.geolocation.getCurrentPosition(onGeoOk, onGeoError);