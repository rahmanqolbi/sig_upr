var map = L.map('map', {
  zoomControl: false,
}).setView([-2.2165470720021343, 113.89801487350582], 18);

function initializeMap() {
  L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
    attribution:
      '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>',
  }).addTo(map);

  L.control
    .zoom({
      position: 'bottomright',
    })
    .addTo(map);
}

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

function mobileSideBar() {
  const sideBar = document.getElementById('sideBar');
  const menu = document.getElementById('menu');
  menu.addEventListener('click', () => {
    sideBar.classList.toggle('hide');
  });
}

function initializeSideBar() {
  const sideBarContainer = document.querySelector('.list-group');
  const fakultas = ['Teknik', 'Apa', 'Ya'];
  for (let data of fakultas) {
    if (data === fakultas[0]) {
      sideBarContainer.innerHTML += `
      <button type="button" class="list-group-item list-group-item-action d-flex active">
        <i class="fa-solid fa-location-dot my-auto me-2" style="color: #e62020;"></i>
        ${data}
        <i class="fa-solid fa-chevron-right my-auto ms-auto" style="color: #212326;"></i>
      </button>
      `;
    } else {
      sideBarContainer.innerHTML += `
      <button type="button" class="list-group-item list-group-item-action d-flex">
        <i class="fa-solid fa-location-dot my-auto me-2" style="color: #e62020;"></i>
        ${data}
        <i class="fa-solid fa-chevron-right my-auto ms-auto" style="color: #212326;"></i>
      </button>
      `;
    }
  }
}

function main() {
  initializeMap();
  initializeSideBar();
  mobileSideBar();
  selectActiveMenu();
  var markerIcon = L.icon({
    iconUrl: 'assets/location-dot-solid.svg',
    iconSize: [30, 30],
  });
  L.marker([-2.2159230106564487, 113.89870865952419], {
    icon: markerIcon,
    riseOnHover: true,
  })
    .addTo(map)
    .bindPopup(
      `
      <h1 class="h6">Ruang Kelas</h1>
      <p class="my-2">Fakultas Teknik</p>
      <p class="my-2">Jurusan Teknik Informatika</p>
      <button class="btn btn-sm btn-outline-primary">Lihat Sarana dan Prasarana</button>`
    )
    .bindTooltip('Ruang Kelas');
}

window.addEventListener('load', () => {
  main();
});
