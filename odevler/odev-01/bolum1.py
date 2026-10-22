# Bölüm 1: Algoritma ve izleme
#SORU1.1
numbers = [4, 7, 2, 9, 5, 1, 8]
total = 0
result = []

for i in range(len(numbers)):
    if numbers[i] % 2 == 0:
        total = total + numbers[i]
    else:
        result.append(numbers[i])

print(total)
print(result)
# Burada çift sayıları topladık ve tek sayıları bir arada yazarak listeledik.
# Ekran çıktısı:
#14
#[7,9,5,1]
#Tahminim tuttu.

#SORU 1.2
#SÖZDE KOD:

#BAŞLA
#Okumalar listesi oluştur
#Eşik değeri belirle
#Seri Sayacı 0 yap
#En uzun seri sayacı 0 yap
#Listedeki okumaları ele al
#EĞER okuma eşik değerinden büyük İSE
#Seri sayacını 1 arttır
#DEĞİLSE
#Seri sayacını 0 yap
#EĞER seri sayacı en uzun seri sayacından büyük İSE
#En uzun seri sayacınu seri sayacına eşitle
#YAZ en uzun seri sayacını
#BİTİR

#PYTHON KODU:

readings = [18, 21, 23, 25, 24, 26, 27, 19, 20, 22, 23, 24, 25, 26]
threshold = 22
count=0
max_count=0

for i in range(len(readings)):
    if readings[i] > threshold:
      count=count+1
    else:
      count=0

    if count>max_count:
      max_count=count

print(max_count)

#SORU 1.3
records = [
    {"student": "Ece", "course": "VTYS"},
    {"student": "Ali", "course": "Yapay Zeka"},
    {"student": "Ece", "course": "Yapay Zeka"},
    {"student": "Can", "course": "VTYS"},
    {"student": "Ali", "course": "VTYS"},
    {"student": "Ece", "course": "Robotik"},
]
course_count={} #kendimiz bir sözlük oluşturduk.

for records in records:
  course=records["course"] #kaydın içindeki course değeri,anahtarın değerini veriyor.

  if course in course_count:  #dersin ssözlüğümüzde olup olmadıgını kontrol ediyoruz.
    course_count[course]=course_count[course]+1 #dersin sayısını 1 arttırıyoruz.

  else:
    course_count[course] = 1   #eğer yoksa dersi ilk kez burada ekliyor ve sayısını 1 yapıyoruz. 
print(course_count)