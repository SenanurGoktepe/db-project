-- Bölüm 3: SELECT ve WHERE
--psql -d llm_ops 
-- Soru 1: Bütün robotların adı ve modeli
SELECT name, model
FROM robots;
-- 12 satır döndü.

--Soru 2: Model adı "model", toplam token sayısını göster.
SELECT model_name AS model,
       prompt_tokens + completion_tokens AS total_tokens
     FROM llm_calls; 
--12 satır döndü.Satır sayısı değişmedi.


-- Soru 3: Gecikmesi 2 saniyeyi aşan çağrılar.
SELECT id, model_name, latency_ms
FROM llm_calls
 WHERE latency_ms > 2000;
--Bu sefer 5 satır döndü.   

-- Soru 4: Ece'nin yaptığı çağrıları listelemek.
SELECT id, model_name, task_type
FROM llm_calls
WHERE user_name = 'Ece';
-- Kullanıcı adını Ece olarak filtreledim ve Ece'ye ait 3 çağrı buldum. 3 satır döndü.


-- Soru 5: Sohbet dışındaki çağrıları listelemek.
SELECT id, model_name, task_type
FROM llm_calls
WHERE task_type <> 'chat';
-- Chat türündeki çağrıları dışarıda bıraktım, diğer görev türlerindeki 9 çağrıyı listeledim. 9 satır döndü.


-- Soru 6: Claude modellerine yapılan, 1 saniyeden uzun süren çağrıları listelemek.
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE model_name LIKE 'claude%'
  AND latency_ms > 1000;
-- Claude ile başlayan modelleri ve 1000 ms üzerindeki gecikmeleri filtreledim. 2 satır döndü.


-- Soru 7: Kod veya çeviri işi yapılan ve maliyeti 0.01 dolardan fazla olan çağrıları listelemek.
SELECT id, model_name, task_type, cost_usd
FROM llm_calls
WHERE (task_type = 'code' OR task_type = 'translate')
  AND cost_usd > 0.01;
-- Kod ve çeviri görevlerini birlikte kontrol ettim, sonra maliyeti 0.01 dolardan fazla olan çağrıları seçtim. 3 satır döndü.


-- Soru 8: Gecikmesi 500 ile 1500 ms arasında olan çağrıları bulmak.
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE latency_ms BETWEEN 500 AND 1500;
-- Gecikme süresi bu aralıkta kalan çağrıları seçtim. 3 satır döndü.


-- Soru 9:  Claude modellerine yapıilan çağrıları listelemek.
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE model_name IN ('claude-sonnet', 'claude-haiku');
-- İstediğim iki modelin çağrılarını seçtim. 4 satır döndü.


-- Soru 10: Model adında mini geçen çağrıları listelemek.
SELECT id, model_name
FROM llm_calls
WHERE model_name LIKE '%mini%';
-- Model adında mini ifadesi bulunan çağrıları seçtim. 1 satır döndü.


-- Soru 11: Çağrıları kullanıcıya göre, aynı kullanıcı içinde maliyeti yüksekten düşüğe sıralaması.
SELECT id, user_name, cost_usd
FROM llm_calls
ORDER BY user_name ASC, cost_usd DESC;
-- Önce kullanıcıları sıraladım, sonra her kullanıcının pahalı çağrılarını üstte gösterdim. 12 satır döndü.Ben 11 satır olarak görmüştüm ama 12 satır döndü gözden kaçırmışım.


-- Soru 12: Maliyeti en yüksek olan 3 çağrıyı listeleme.
SELECT id, model_name, cost_usd
FROM llm_calls
ORDER BY cost_usd DESC
LIMIT 3;
-- Çağrıları maliyetlerine göre büyükten küçüğe sıralayıp ilk 3 kaydı aldım. 3 satır döndü.


-- Soru 13: Tabloda bulunan farklı iş türlerini listeleme.
SELECT DISTINCT task_type
FROM llm_calls;
-- 5 satır döndü.


-- Soru 14: Kullanıcı adlarını tekrarsız listeleyip sıralama..
SELECT DISTINCT user_name
FROM llm_calls
ORDER BY user_name;
-- Kullanıcı adlarını tekrarsız şekilde 4 satır döndü.


-- Soru 15: 14 Ekim'den sonra yapılan ve 1 saniyeden uzun süren çağrıları en yavaştan başlayarak listelemek.
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE created_at >= '2026-10-15'
  AND latency_ms > 1000
ORDER BY latency_ms DESC;
-- Tarih ve gecikme koşulları ile birlikte 5 satır döndü. 14 ekimi alsaydık 6 satir dönecekti.


-- Soru 12: Önce maliyeti boş olan çağrıyı = NULL ile bulmayı deneyimledik.
SELECT *
FROM llm_calls
WHERE cost_usd = NULL;
-- Sonuç gelmedi çünkü NULL değeri eşittir işaretiyle kontrol edilemiyor. 0 satır döndü.

--burada null'un eşit ile değil is null ile kontrol edilmesini kavradım.
-- Eksik maliyet bilgisini IS NULL ile aramak.
SELECT *
FROM llm_calls
WHERE cost_usd IS NULL;
-- 11 numaralı çağrının maliyet bilgisinin boş olduğunu buldum. Fatura henüz gelmediği için bu çağrının maliyeti bilinmiyor. 1 satır döndü.


-- Soru 13: Ortalama gecikmeyi boş değerleri atlayarak ve sıfır kabul ederek hesapla.
SELECT
    ROUND(AVG(latency_ms), 1) AS null_atlanarak,
    ROUND(AVG(COALESCE(latency_ms, 0)), 1) AS null_sifir_sayilarak
FROM llm_calls;
--- İki ortalama da 1848.3 ms çıktı. Gecikme sütununda eksik değer olmadığı için sıfır kabul etmek sonucu değiştirmedi.


-- Ek kontrol: Ortalama maliyeti boş değerleri atlayarak ve sıfır kabul ederek karşılaştırma.
SELECT
    ROUND(AVG(cost_usd), 4) AS null_atlanarak,
    ROUND(AVG(COALESCE(cost_usd, 0)), 4) AS null_sifir_sayilarak
FROM llm_calls;
-- Eksik maliyeti atlayınca ortalama 0.0057 dolar, sıfır kabul edince 0.0053 dolar oldu. Faturası gelmeyen çağrıyı sıfır saymak ortalamayı olduğundan düşük gösterebilir.


-- Soru 14: Günlük çağrı sayısını ve toplam maliyeti hesaplamak.
SELECT
    created_at::date AS gun,
    COUNT(*) AS cagri_sayisi,
    SUM(cost_usd) AS toplam_maliyet
FROM llm_calls
GROUP BY created_at::date
ORDER BY gun;

-- Çağrıları günlere göre grupladım. En çok çağrı 16 Ekim'de yapılmış olmasına rağmen toplam maliyet düşük görünüyor; çünkü bir çağrının maliyeti henüz bilinmiyor ve SUM bu NULL değeri toplama katmıyor. 


-- Soru 15: Çağrıları gecikme sürelerine göre kategorilere ayırma.
SELECT
    CASE
        WHEN latency_ms < 1000 THEN 'Hızlı'
        WHEN latency_ms < 2500 THEN 'Orta'
        ELSE 'Yavaş'
    END AS gecikme_kategorisi,
    COUNT(*) AS cagri_sayisi,
    ROUND(AVG(latency_ms), 1) AS ortalama_gecikme_ms
FROM llm_calls
GROUP BY gecikme_kategorisi
ORDER BY gecikme_kategorisi;

-- Çağrıları üç gecikme kategorisine ayırdım. Hızlı çağrılar kısa sürede yanıt verirken yavaş kategorisindeki çağrılar daha uzun sürdü; ortalamalar her kategorinin yanıt süresini karşılaştırmamı sağlıyor.
