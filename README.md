# WordQuiz Pro — PWA + APK firmato + app Windows

La tua `prova_3.html` è diventata `www/index.html` (con manifest, service worker offline, icone e backup compatibile con Android).

## Cosa c'è
- `www/` → la PWA
- `electron/` → app Windows
- `assets/` → immagini per l'icona Android
- `.github/workflows/build.yml` → compila in cloud PWA, **APK firmato** ed **.exe**
- `scripts/` → utility per Windows (doppio clic)

## 1. Prova in locale
Doppio clic su `scripts\prova-locale.bat` (serve Node.js: `winget install OpenJS.NodeJS.LTS`).

## 2. Pubblica su GitHub (una volta sola)
1. `winget install Git.Git`
2. Su github.com crea un repository **pubblico** (Pages gratis; i privati richiedono un piano a pagamento).
3. Nella cartella del progetto:
```
git init
git add .
git commit -m "WordQuiz Pro"
git branch -M main
git remote add origin https://github.com/TUO-UTENTE/NOME-REPO.git
git push -u origin main
```
4. Repo → Settings → Pages → Source: **GitHub Actions**.

Alternativa senza Git: sulla pagina del repository vuoto clicca *uploading an existing file* e trascina **il contenuto** della cartella (non la cartella stessa).

La PWA sarà su `https://TUO-UTENTE.github.io/NOME-REPO/` → aprila in Chrome/Edge → **Installa app** (telefono o PC).

## 3. APK firmato
1. `winget install EclipseAdoptium.Temurin.21.JDK`
2. Doppio clic su `scripts\1-genera-keystore.bat` → crea `wordquiz.keystore` e `segreti-github.txt` nella cartella `C:\Users\TUO-NOME\WordQuiz-chiavi` (fuori dal progetto, così non finiscono su GitHub per sbaglio).
3. Repo → Settings → Secrets and variables → Actions → crea 3 secret con i valori di `segreti-github.txt`: `KEYSTORE_BASE64`, `KEYSTORE_PASSWORD`, `KEY_ALIAS`.
4. Actions → *Build WordQuiz Pro* → Run workflow (parte anche a ogni push).
5. A fine build scarica l'artifact `WordQuizPro-apk`, copialo sul telefono e installalo (consenti le origini sconosciute).

**Backup della cartella `WordQuiz-chiavi`** (keystore e password; non caricarla mai su GitHub): senza, non potrai più aggiornare l'app installata.

## 4. App Windows
- Cloud: artifact `WordQuizPro-windows` (installer + versione portable).
- Locale: `scripts\build-windows.bat` → cartella `dist\`.
- SmartScreen avvisa perché manca un certificato a pagamento: *Ulteriori informazioni → Esegui comunque*.

## Da sapere
- Ogni versione (PWA, APK, Windows) ha i **propri dati**: per spostarli usa *Scarica backup* e *Importa*.
- Riconoscimento vocale (microfono): funziona nella PWA su Chrome/Edge; nell'APK è disabilitato e nell'.exe probabilmente non funziona. La sintesi vocale (voce che legge) è un'altra funzione.
- Per aggiornare: modifica `www/index.html`, poi `git add . && git commit -m "agg" && git push`.
