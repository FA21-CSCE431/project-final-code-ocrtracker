document.body.addEventListener("ajax:success", (event) => {
    const [data, status, xhr] = event.detail;

    document.getElementById('flash_message').innerHTML = data.message;
});