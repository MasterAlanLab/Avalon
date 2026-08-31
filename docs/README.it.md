**🌐 Languages:** [中文](../README.md) · [English](README.en.md) · [Deutsch](README.de.md) · [Español](README.es.md) · [العربية](README.ar.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md)

# Avalon — Client proxy multipiattaforma con nodi singoli e catene di proxy

> Avalon è un fork di [FlClash](https://github.com/chen08209/FlClash) basato sul core mihomo (Clash.Meta). Oltre al consueto flusso basato su abbonamenti, aggiunge una **libreria di nodi indipendente** e **catene di proxy multi-hop**: puoi aggiungere singolarmente un nodo VLESS, VMess, Shadowsocks, Trojan, Hysteria2, TUIC, AnyTLS, SOCKS4/4a/5 o HTTP(S) e comporli nel percorso `client → pre-nodo → nodo principale → post-nodo → destinazione`, il tutto all'interno di **una sola istanza del core**, senza avviare un secondo processo.

> ⚠️ **Questo progetto è destinato esclusivamente a studio, ricerca e scambio tecnico: qualsiasi uso illecito è severamente vietato.** Chi lo utilizza deve rispettare le leggi del proprio Paese o della propria regione e si assume ogni responsabilità derivante dall'uso del software. Vedi il [Disclaimer](#disclaimer).

<p>
  <a href="https://github.com/MasterAlanLab/Avalon/releases/"><img alt="Downloads" src="https://img.shields.io/github/downloads/MasterAlanLab/Avalon/total?style=flat-square&logo=github"></a>
  <a href="https://github.com/MasterAlanLab/Avalon/releases/"><img alt="Last Version" src="https://img.shields.io/github/release/MasterAlanLab/Avalon/all.svg?style=flat-square"></a>
  <a href="../LICENSE"><img alt="License" src="https://img.shields.io/badge/License-GPL--3.0-blue?style=flat-square"></a>
  <img alt="Platforms" src="https://img.shields.io/badge/Piattaforme-Android%20·%20Windows%20·%20macOS%20·%20Linux-brightgreen?style=flat-square">
  <img alt="Purpose" src="https://img.shields.io/badge/Uso-Solo%20studio%20e%20ricerca-orange?style=flat-square">
</p>

Condivido principi tecnici, esperienze d'uso e aggiornamenti sui canali:

[![YouTube](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/@MasterAlanLab)
[![Bilibili](https://img.shields.io/badge/Bilibili-00A1D6?style=for-the-badge&logo=bilibili&logoColor=white)](https://space.bilibili.com/3691004225914941)
[![Telegram](https://img.shields.io/badge/Telegram-0088CC?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/MasterAlanLab_Channel)

Desktop:

<p style="text-align: center;">
    <img alt="desktop" src="../snapshots/desktop.gif">
</p>

Mobile:

<p style="text-align: center;">
    <img alt="mobile" src="../snapshots/mobile.gif">
</p>

---

## Cosa aggiunge Avalon rispetto a FlClash

### 1. Libreria di nodi indipendente (supporto al nodo singolo)

Non serve più un abbonamento per usare un nodo. I nodi sono oggetti globali che si possono aggiungere, modificare, raggruppare e collegare singolarmente:

- **Moduli dedicati per protocollo e import da URI**: VLESS, VMess, Shadowsocks, Trojan, Hysteria2, TUIC, AnyTLS, SOCKS4/4a/5 e HTTP(S) con porta o credenziali esplicite.
- **Nodi Raw YAML / JSON**: coprono **tutti** i proxy type supportati da mihomo, compresi quelli non ancora previsti dai moduli dedicati. Anche i nodi Raw si salvano, si collegano, si usano nelle catene e si esportano.
- **Più modi per inserirli**: incollare un URI, scansionare un QR code, aprire uno schema URL di sistema o compilare il modulo a mano.
- **Abbonamenti e nodi singoli convivono**: un normale indirizzo `http(s)://` viene sincronizzato come abbonamento, mentre un indirizzo con porta, credenziali o parametri proxy espliciti viene interpretato come nodo singolo. Gli input ambigui si gestiscono con l'editor Raw.
- **Esportazione**: nodi e catene si esportano come configurazione Clash o JSON.

### 2. Catene di proxy (multi-hop / proxy a monte)

- La direzione di visualizzazione e di connessione è fissa: **client → pre-nodo → nodo principale → post-nodo → destinazione**; l'ordine dell'elenco è l'ordine di annidamento.
- Ogni hop può essere un nodo, un gruppo di policy globale, un gruppo dell'abbonamento corrente oppure un **endpoint locale SOCKS / HTTP / HTTPS già attivo** (per esempio una porta aperta da un altro client sulla stessa macchina).
- In fase di compilazione il `dialer-proxy` di ogni hop punta a quello precedente, quindi il risultato è **una sola configurazione e un solo ciclo di vita del core**. Una catena con un solo hop equivale a usare direttamente quel nodo.
- Un gruppo di policy usato come hop si espande in una matrice di rami, con limite predefinito di 64 (configurabile da 1 a 1024) e anteprima in tempo reale del numero di percorsi e delle diagnostiche prima del salvataggio.
- Le catene sono oggetti globali: si possono copiare, rinominare e riordinare, e più abbonamenti possono collegare la stessa catena. Le diagnostiche di livello `error` impediscono l'applicazione alla configurazione in esecuzione, quelle `warning` richiedono conferma.
- Al momento del collegamento scegli esplicitamente i *gruppi di ingresso*: il selector generato viene aggiunto in coda a quei gruppi di policy, senza toccare la selezione originale dell'abbonamento.

### 3. Tutto ciò che eredita da FlClash

✈️ Multipiattaforma: Android, Windows, macOS e Linux

💻 Si adatta a molte dimensioni di schermo, diversi temi di colore

💡 Design Material You con un'interfaccia in stile [Surfboard](https://github.com/getsurfboard/surfboard)

☁️ Sincronizzazione dei dati via WebDAV

✨ Import degli abbonamenti con un clic, modalità scura

---

## Installazione

### Download

<a href="https://github.com/MasterAlanLab/Avalon/releases"><img alt="Get it on GitHub" src="../snapshots/get-it-on-github.svg" width="200px"/></a>

### Dipendenze su Linux

⚠️ Prima dell'uso installa le seguenti dipendenze:

```bash
sudo apt-get install libayatana-appindicator3-dev
sudo apt-get install libkeybinder-3.0-dev
```

### Azioni broadcast su Android

Sono supportate le seguenti azioni:

```bash
com.masteralanlab.avalon.action.START

com.masteralanlab.avalon.action.STOP

com.masteralanlab.avalon.action.TOGGLE
```

---

## Avvio rapido

1. **Aggiungi una configurazione**: incolla un link di abbonamento in «Abbonamenti», oppure incolla direttamente un URI `vless://`, `anytls://`, `socks5://`… in «Nodi», o importalo scansionando un QR code.
2. **Costruisci una catena** (facoltativo): in «Catene» trascina nodi o gruppi di policy nell'ordine pre-nodo → nodo principale → post-nodo e controlla numero di percorsi e diagnostiche prima di salvare.
3. **Collega e avvia**: collega la catena all'abbonamento corrente, scegli i gruppi di ingresso e avvia dalla schermata principale. Gli abbonamenti senza catena collegata mantengono il comportamento originale.

---

## Compilazione

1. Aggiorna i submodule

   ```bash
   git submodule update --init --recursive
   ```

2. Installa gli ambienti `Flutter` e `Golang`

3. Compila l'applicazione

    - android

        1. Installa `Android SDK` e `Android NDK`

        2. Imposta la variabile d'ambiente `ANDROID_NDK`

        3. Esegui lo script di build

           ```bash
           dart setup.dart android
           ```

    - windows

        1. Richiede una macchina Windows

        2. Installa `GCC` e `Inno Setup`

        3. Esegui lo script di build

           ```bash
           dart setup.dart windows
           ```

    - linux

        1. Richiede una macchina Linux

        2. Le dipendenze vengono installate dallo script di setup, oppure manualmente:

           ```bash
           sudo apt-get install -y libayatana-appindicator3-dev libkeybinder-3.0-dev
           ```

        3. Esegui lo script di build

           ```bash
           dart setup.dart linux
           ```

    - macOS

        1. Richiede una macchina macOS

        2. Esegui lo script di build

           ```bash
           dart setup.dart macos
           ```

---

## Risorse consigliate

Servizi che uso personalmente o che si abbinano bene a questo progetto. Alcuni link sono promozionali / di affiliazione: registrandoti o acquistando tramite essi l'autore può ricevere una piccola commissione, **senza costi aggiuntivi per te**.

- **Pool di proxy self-hosted**: [Free Proxy](https://github.com/MasterAlanLab/free-proxy) — esegue un pool di nodi gratuiti sul tuo VPS ed espone SOCKS5 / HTTP, utilizzabile da Avalon come nodo singolo o come hop di una catena
- **VPS con rotte ottimizzate verso la Cina**: [BandwagonHost](https://cutt.ly/qywJNWzd) · [DMIT](https://cutt.ly/YywJIzY0) — per nodi propri o server di uscita
- **Carte di credito virtuali**: [qui](https://cutt.ly/IyrMR4Mg) — per pagare servizi esteri
- **Bot Telegram per la ricerca di risorse**: [qui](https://cutt.ly/2yeh3GOE)
- **Account e SIM esteri**: [qui](https://cutt.ly/dywt86NC)
- **Browser anti-detect**: [BitBrowser](https://client.bitbrowser.cn/register?lang=zh&code=Alan123) — isolamento degli ambienti sopra ai proxy concatenati
- **Gestione massiva di caselle email**: [Emailbox](https://github.com/MasterAlanLab/emailbox) — gestisce caselle in blocco con proxy per gruppo
- **Risoluzione captcha**: [Captcha.run](https://captcha.run/sso?inviter=542f4f4f-31b6-4b70-b485-c4762c45d1e8) · [YesCaptcha](https://cutt.ly/Mywt39r0)
- **Relay API GPT**: [CC / GPT relay](https://cutt.ly/JywJG3G5)
- **Abbonamenti condivisi**: [qui](https://cutt.ly/5ywt8vb4)

---

## Disclaimer

- Questo progetto è **destinato solo a studio, ricerca e scambio tecnico e qualsiasi uso illecito è severamente vietato**: sono inclusi, a titolo esemplificativo, l'intrusione nei sistemi altrui, l'aggiramento di restrizioni di accesso dove la legge locale lo vieta, gli attacchi di rete, la diffusione di contenuti illegali e qualsiasi altra attività criminale.
- Chi lo utilizza deve rispettare le leggi del proprio Paese o della propria regione. Tutte le conseguenze dell'uso ricadono sull'utente; autori e contributori non rispondono di danni diretti o indiretti.
- Questo progetto **non fornisce, non vende e non consiglia alcun nodo proxy o servizio in abbonamento** e non garantisce disponibilità, riservatezza o sicurezza dei nodi di terze parti. Non trasmettere mai informazioni sensibili attraverso nodi di origine sconosciuta.
- Se nel tuo Paese o nella tua regione software di questo tipo è vietato, interrompine subito l'uso ed eliminalo.
- I link a VPS, carte virtuali, bot Telegram e simili sono promozionali / di affiliazione. Gli ordini effettuati tramite essi possono generare una piccola commissione per l'autore, **senza costi aggiuntivi per te**. Grazie del supporto ❤️

---

## Licenza

Questo progetto è distribuito con licenza **GPL-3.0**, la stessa del progetto originale. Il testo completo è in [LICENSE](../LICENSE). L'avviso di fork e i componenti di terze parti sono in [NOTICE](../NOTICE).

Avalon è una versione modificata (fork) di [FlClash](https://github.com/chen08209/FlClash):

- Il copyright dell'opera originale appartiene agli autori e ai contributori di FlClash; tutti gli avvisi originali di copyright e licenza sono conservati.
- Questo progetto modifica l'opera originale, principalmente aggiungendo la libreria di nodi indipendente, le catene di proxy multi-hop e la compilazione delle catene in un unico core, oltre a cambiare il nome del progetto e gli identificatori dell'applicazione. Una panoramica è in [CHANGELOG.md](../CHANGELOG.md).
- Ai sensi della GPL-3.0, ogni ridistribuzione basata su questo progetto deve essere anch'essa rilasciata sotto GPL-3.0 e conservare gli avvisi sopra indicati.
- Avalon **non è affiliato** al progetto originale FlClash: non aprire issue su questo fork nel loro repository.

## Ringraziamenti

- [FlClash](https://github.com/chen08209/FlClash) — il progetto originale su cui si basa questo fork 🙏
- [mihomo (Clash.Meta)](https://github.com/MetaCubeX/mihomo) — il core proxy
- [Surfboard](https://github.com/getsurfboard/surfboard) — riferimento per il design dell'interfaccia

## Contatti

- Canale Telegram: <https://t.me/MasterAlanLab_Channel>
- Richieste commerciali: <masteralanlab@gmail.com>

## Star

Il modo più semplice per sostenere lo sviluppo è cliccare la stella (⭐) in cima alla pagina.

<p style="text-align: center;">
    <a href="https://api.star-history.com/svg?repos=MasterAlanLab/Avalon&Date">
        <img alt="star" width=50% src="https://api.star-history.com/svg?repos=MasterAlanLab/Avalon&Date"/>
    </a>
</p>
