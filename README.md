# Unifi Controller Easypanel Docker Deployment

Proyek ini berisi Dockerfile dan instruksi untuk men-deploy Unifi Controller menggunakan Docker, khususnya melalui platform Easypanel.

## Isi Proyek

- `Dockerfile`: File konfigurasi untuk membangun image Docker Unifi Controller.
- `README.md`: Dokumen ini, berisi instruksi dan informasi proyek.

## Prasyarat

- Docker terinstal di mesin host
- Akses ke Easypanel (jika menggunakan metode deployment Easypanel)
- Git (opsional, untuk manajemen versi)

## Struktur Direktori

Sebelum menjalankan container, buat struktur direktori berikut di host:

```bash
mkdir -p ~/unifi/data
mkdir -p ~/unifi/log
```

## Menggunakan Dockerfile

### Membangun Image

Untuk membangun image Docker:

```bash
docker build -t unifi-controller .
```

### Menjalankan Container

Untuk menjalankan container:

```bash
docker run -d --init \
   --restart=unless-stopped \
   -p 8080:8080 -p 8443:8443 -p 3478:3478/udp \
   -e TZ='Africa/Johannesburg' \
   -v ~/unifi:/unifi \
   --user unifi \
   --name unifi \
   unifi-controller
```

## Deployment dengan Easypanel

1. Push Dockerfile dan README ke repositori Git Anda.

2. Di Easypanel:
   - Buat aplikasi baru
   - Pilih "Deploy from Dockerfile"
   - Masukkan URL repositori Git Anda

3. Konfigurasi Easypanel:
   - Volume: 
     - Tambahkan volume persisten untuk `/unifi/data`
     - Tambahkan volume persisten untuk `/unifi/log`
   - Port:
     - 8080 (HTTP)
     - 8443 (HTTPS)
     - 3478 (UDP)
   - Environment Variables:
     - `TZ`: Sesuaikan dengan zona waktu Anda (contoh: 'Asia/Jakarta')

4. Deploy aplikasi

## Akses Unifi Controller

Setelah container berjalan, akses Unifi Controller melalui:
- http://[IP-SERVER]:8080
- https://[IP-SERVER]:8443 (direkomendasikan)

## Pemeliharaan

- Untuk memperbarui Unifi Controller, rebuild image Docker dengan versi terbaru dari base image dan redeploy.
- Backup data secara berkala dari direktori `~/unifi/data`.

## Troubleshooting

Jika mengalami masalah:
1. Periksa log container: `docker logs unifi`
2. Pastikan port yang diperlukan tidak digunakan oleh aplikasi lain
3. Verifikasi permissions pada direktori host yang di-mount

## Kontribusi

Silakan buat issue atau pull request jika Anda memiliki saran perbaikan atau peningkatan.

## Lisensi

[Masukkan informasi lisensi di sini]
