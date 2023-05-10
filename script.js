var map = L.map('map').setView([-2.2165470720021343, 113.89801487350582], 18);

L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
  maxZoom: 19,
  attribution:
    '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>',
}).addTo(map);

L.marker([-2.2159230106564487, 113.89870865952419])
  .addTo(map)
  .bindPopup('Gimana kelanjutan projectnya?')
  .openPopup();

function selectActiveMenu() {
  const listFakultasButton = document.getElementsByClassName('list-group-item');
  for (let fakultasButton of listFakultasButton) {
    fakultasButton.addEventListener('click', () => {
      removeAllActiveMenu();
      fakultasButton.classList.add('active');
    });
  }
}

function removeAllActiveMenu() {
  const listFakultasButton = document.getElementsByClassName('list-group-item');
  for (let fakultasButton of listFakultasButton) {
    fakultasButton.classList.remove('active');
  }
}

selectActiveMenu();
