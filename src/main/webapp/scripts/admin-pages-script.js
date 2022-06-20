function edit_tariff(tariff_id) {
    let input = document.querySelectorAll('.input_' + tariff_id);
    let submit = document.querySelectorAll('.submit_' + tariff_id);

    input.forEach((elem) => {
        if (elem.hasAttribute('disabled'))
            elem.removeAttribute('disabled');
        else elem.setAttribute('disabled', 'disabled')
    });

    submit.forEach((elem) => {
        if (elem.style.display === 'none')
            elem.style.display = 'block';
        else elem.style.display = 'none';
    });
}