# Avalon

Client proxy per Android, Windows, macOS e Linux, basato su [mihomo](https://github.com/MetaCubeX/mihomo). Supporta nodi indipendenti, gestione delle sottoscrizioni e catene di proxy multi-hop. Sviluppato con Flutter.

> Avalon è basato su [FlClash](https://github.com/chen08209/FlClash).

Scarica il pacchetto di installazione per la tua piattaforma da [Releases](https://github.com/MasterAlanLab/avalon/releases).

## Funzionalità

- Protocolli supportati: VLESS, VMess, Shadowsocks, Trojan, Hysteria2, TUIC, AnyTLS, SOCKS4/4a/5, HTTP(S) e altri.
- Gestione dei nodi: gestisci i singoli nodi in modo indipendente, aggiungendoli, modificandoli, duplicandoli e associandoli ai profili.
- Sottoscrizioni: importa profili da URL o file locali, con aggiornamento automatico delle sottoscrizioni.
- Catene di proxy: combina nodi, gruppi di proxy ed endpoint proxy locali, con proxy a monte, connessioni multi-hop e anteprima dei percorsi.
- Generazione dei profili: crea profili pronti all'uso a partire dalle catene oppure aggiungi le catene ai gruppi di proxy dei profili esistenti.
- Importazione ed esportazione: supporto per URI dei nodi, codici QR e YAML / JSON; esportazione di nodi e catene in un pacchetto con i relativi allegati.
- Regole di instradamento: modalità Rule, Global e Direct, con regole e gruppi di proxy modificabili.
- Diagnostica di rete: test di latenza dei nodi, visualizzazione delle connessioni in tempo reale e log di esecuzione.
- Sincronizzazione dei dati: backup e ripristino locali, con sincronizzazione tramite WebDAV.
- Temi: layout per desktop e dispositivi mobili, modalità scura e colori personalizzabili.

## Modalità operative

| Modalità | Descrizione |
| :--- | :--- |
| Rule | Seleziona l'uscita in base alle regole del profilo |
| Global | Invia tutto il traffico che entra nel core attraverso l'uscita selezionata nel gruppo proxy globale |
| Direct | Si connette direttamente alla destinazione, senza un nodo proxy |

Il traffico può essere acquisito tramite il proxy di sistema o TUN. Il proxy di sistema serve le applicazioni che rispettano le impostazioni di sistema; TUN acquisisce il traffico tramite un'interfaccia di rete virtuale e lo instrada secondo la modalità selezionata.

## Motore proxy

[mihomo](https://github.com/MetaCubeX/mihomo) gestisce le connessioni proxy, la risoluzione DNS, l'instradamento basato su regole e il traffico TUN. Oltre ai moduli specifici per protocollo, è possibile usare Raw YAML / JSON per configurare altri tipi di nodi mihomo.

Sottoscrizioni, libreria dei nodi e catene di proxy confluiscono in un'unica configurazione di esecuzione. Le catene collegano i vari hop tramite `dialer-proxy`, nell'ordine «client → proxy a monte → nodo principale → proxy a valle → destinazione», all'interno di una sola istanza del core.

## Compilazione

```bash
git clone --recurse-submodules https://github.com/MasterAlanLab/avalon.git
cd avalon
flutter pub get
```

La compilazione richiede Flutter, Go e Rust. La CI utilizza attualmente Flutter 3.44.4 e Go 1.26.4. Comandi e dipendenze aggiuntive per piattaforma:

| Piattaforma | Comando di compilazione | Dipendenze aggiuntive |
| :--- | :--- | :--- |
| Android | `dart setup.dart android` | Android SDK e NDK; impostare `ANDROID_NDK` |
| Windows | `dart setup.dart windows` | Toolchain C++ di Visual Studio, GCC, Inno Setup |
| macOS | `dart setup.dart macos` | Xcode, CocoaPods, Node.js / npm |
| Linux | `dart setup.dart linux` | Lo script installa GTK, AppIndicator, Keybinder e altre dipendenze tramite apt |

I pacchetti desktop vengono compilati sul rispettivo sistema operativo e salvati in `dist/`. La configurazione completa dell'ambiente è disponibile nel [workflow di compilazione](../.github/workflows/build.yaml).

## Test

```bash
# Analisi statica
flutter analyze --no-fatal-infos

# Test unitari e dei widget
flutter test

# Test del wrapper del core in Go
(cd core && go test .)

# Test dei componenti Rust
cargo test --manifest-path services/helper/Cargo.toml
cargo test --manifest-path plugins/rust_api/rust/Cargo.toml
```

## Stack tecnologico

- Linguaggi: Dart, Go, Rust
- Framework UI: Flutter / Material Design
- Gestione dello stato: Riverpod
- Database: SQLite / Drift
- Core proxy: mihomo
- Gestione dei pacchetti: Pub, Go Modules, Cargo

## Risorse consigliate

Alcuni link sono affiliati. L'autore può ricevere una commissione in caso di registrazione o acquisto tramite questi link. Dettagli dei servizi e prezzi sono indicati sui rispettivi siti.

| Categoria | Progetto / Servizio | Descrizione |
| :--- | :--- | :--- |
| Pool di proxy | [Free Proxy](https://github.com/MasterAlanLab/free-proxy) | Pool autogestito da usare con la libreria dei nodi o le catene di proxy |
| VPS | [BandwagonHost](https://cutt.ly/qywJNWzd) · [DMIT](https://cutt.ly/YywJIzY0) | Hosting di nodi e applicazioni |
| Carte di credito virtuali | [Carte virtuali internazionali](https://cutt.ly/IyrMR4Mg) | Pagamenti per servizi internazionali |
| Ricerca di risorse | [Bot di ricerca Telegram](https://cutt.ly/2yeh3GOE) | Ricerca di risorse su Telegram |
| Account e SIM | [Account e SIM internazionali](https://cutt.ly/dywt86NC) | Servizi di account e comunicazione |
| Browser con fingerprint | [BitBrowser](https://client.bitbrowser.cn/register?lang=zh&code=Alan123) | Gestione di ambienti browser indipendenti |
| Hosting email | [Emailbox](https://github.com/MasterAlanLab/emailbox) | Gestione in blocco delle email e raggruppamento dei proxy |
| Servizi CAPTCHA | [Captcha.run](https://captcha.run/sso?inviter=542f4f4f-31b6-4b70-b485-c4762c45d1e8) · [YesCaptcha](https://cutt.ly/Mywt39r0) | Riconoscimento CAPTCHA |
| API di IA | [Relay CC / GPT](https://cutt.ly/JywJG3G5) | Servizi API per modelli |
| Abbonamenti condivisi | [Piattaforma di abbonamenti condivisi](https://cutt.ly/5ywt8vb4) | Condivisione degli abbonamenti |

## Licenza

[AGPL-3.0](../LICENSE). Il codice di terze parti mantiene le rispettive licenze. Le informazioni su copyright e licenze sono in [NOTICE](../NOTICE).

## Ringraziamenti

- [FlClash](https://github.com/chen08209/FlClash)
- [mihomo](https://github.com/MetaCubeX/mihomo)
- [Surfboard](https://github.com/getsurfboard/surfboard)
