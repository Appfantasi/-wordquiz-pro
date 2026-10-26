$out = Join-Path $env:USERPROFILE 'WordQuiz-chiavi'
New-Item -ItemType Directory -Force -Path $out | Out-Null
$ks = Join-Path $out 'wordquiz.keystore'
if (Test-Path $ks) { Write-Host "Hai gia un keystore in: $out - non lo sovrascrivo. Riusa i 3 segreti gia salvati in segreti-github.txt."; exit 1 }
$pw = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 24 | ForEach-Object { [char]$_ })
keytool -genkeypair -storetype PKCS12 -keystore $ks -alias wordquiz -keyalg RSA -keysize 2048 -validity 10000 -storepass $pw -keypass $pw -dname 'CN=WordQuiz Pro, O=Personale, C=IT'
if ($LASTEXITCODE -ne 0) { Write-Host 'Errore nella creazione del keystore.'; exit 1 }
$b64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes($ks))
@('KEYSTORE_BASE64', $b64, '', 'KEYSTORE_PASSWORD', $pw, '', 'KEY_ALIAS', 'wordquiz') | Set-Content -Encoding ascii (Join-Path $out 'segreti-github.txt')
Write-Host ''
Write-Host "Creati in: $out"
Write-Host 'Fai un BACKUP di quella cartella e NON caricarla su GitHub.'
Start-Process explorer.exe $out
