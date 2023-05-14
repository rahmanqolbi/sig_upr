const BASE_URL = 'localhost';

async function getFakultas() {
  const response = await fetch(`${BASE_URL}/fakultas`);
  const responseJson = await response.json();
  if (responseJson.status !== 'success') {
    return { error: true, data: null };
  }

  return { error: false, data: responseJson.data };
}

async function getRuangKelas() {
  const response = await fetch(`${BASE_URL}/ruang-kelas`);
  const responseJson = await response.json();
  if (responseJson.status !== 'success') {
    return { error: true, data: null };
  }

  return { error: false, data: responseJson.data };
}
