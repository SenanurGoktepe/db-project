# Bölüm 2: Veritabanı kavramları
#SORU1:Bir kurum verilerini Excel dosyalarında tutuyor. Hangi üç somut sorunla karşılaşır
1 Eşzamanlı erişim hatası:Dosyalar birden fazla aynı anda yazarlara göre tasarlanmamıştır.Birinin yaptığı değişiklik,daha sonra bir kişinin yaptığı değişiklik yüzünden tamamen kaybolur.

2 Tutarsızlık (inconsistency):Bir bilgi farklı excel dosyalarında tutulduğu zaman ve bir dosyada  değiştirip diğer dosyalarda bilgi eksik kalabilir.Veri tabanı düzenli tutmasında yardımcı olabilir.Veri tabanında bilgilerin düzenli kullanılması oluşacak tutarsızlıkları azaltabilir

3 Veri tekrarı (redundancy):Bir bilginin birden fazla gereksiz yere saklanmasıdır.Veri tabanında tabloları düzgün bir şekilde tasarlamak ve düzgün ilişkiler kurmak bilginin tekrar tekrar saklanmasını azaltabilir.

#SORU2:Birincil anahtar (primary key) ne işe yarar? Öğrenci numarası iyi bir birincil anahtar mıdır, ad soyad neden değildir?
->Birincil anahtar (primary key) veritabanındaki bir tablonun benzersiz bir şekilde olmasını sağlar.Birincil anahtar değeri farklı olmalıdır.Elbette öğrenci numarası iyi bir birincil anahtardır.Öğrenci numarası her öğrenciye özgündür bir numara birden farklı öğrenciye gitmez tek bir öğrenci ile eşleşir.Ad soyad iyi bir birincil anahtar değildir çünkü farklı öğrencilerin adları ve soyadları aynı olabilir.Ad soyad bu nedenden dolayı her öğrenciyi benzersiz tanımlayamaz.

SORU3:Veritabanı yönetim sistemi (DBMS) ile veritabanının farkı nedir? PostgreSQL bunlardan hangisi?
->Veri tabanı düzenli bir şekilde saklanan verilerdir.Veri tabanu yönetim sistemleri(DBMS)ise bu verileri oluşturmayı,saklamayı,değiştirmeyi sağlayan bir yazılımdır.VE PostgreSQL de Veri tabanı yönetim sistemleri'dir.Yani veri tabanını yönetmek için kullanılıyor.

SORU4:Aynı anda iki kişi aynı kaydı değiştirmeye kalkarsa ne olur? Bunu bir cümleyle anlat.
->Birinin yaptığı değişiklik diğerinin yaptığı değişikliği kaybettirebilir,ezebilir ya da birbiriyle çakışma durumu oluşabilir.