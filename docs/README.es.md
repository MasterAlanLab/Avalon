# Avalon

Cliente proxy para Android, Windows, macOS y Linux, basado en [mihomo](https://github.com/MetaCubeX/mihomo). Admite nodos independientes, gestión de suscripciones y cadenas de proxies de varios saltos. Desarrollado con Flutter.

> Avalon está basado en [FlClash](https://github.com/chen08209/FlClash).

Descarga el paquete de instalación para tu plataforma desde [Releases](https://github.com/MasterAlanLab/avalon/releases).

## Funciones

- Protocolos compatibles: VLESS, VMess, Shadowsocks, Trojan, Hysteria2, TUIC, AnyTLS, SOCKS4/4a/5, HTTP(S) y otros.
- Gestión de nodos: administra nodos individuales de forma independiente; permite añadirlos, editarlos, duplicarlos y vincularlos a perfiles.
- Suscripciones: importa perfiles desde enlaces o archivos locales, con actualización automática de las suscripciones.
- Cadenas de proxies: combina nodos, grupos de proxies y endpoints proxy locales, con proxies previos, conexiones de varios saltos y vista previa de las rutas.
- Generación de perfiles: crea perfiles listos para usar a partir de cadenas o añade cadenas a los grupos de proxies de perfiles existentes.
- Importación y exportación: admite URI de nodos, códigos QR y YAML / JSON; permite exportar nodos y cadenas junto con sus archivos adjuntos en un paquete.
- Reglas de enrutamiento: modos Rule, Global y Direct, con reglas y grupos de proxies editables.
- Diagnóstico de red: pruebas de latencia de nodos, consulta de conexiones en tiempo real y registros de ejecución.
- Sincronización de datos: copia de seguridad y restauración locales, con sincronización mediante WebDAV.
- Temas: diseños para escritorio y móvil, modo oscuro y colores personalizables.

## Modos de funcionamiento

| Modo | Descripción |
| :--- | :--- |
| Rule | Selecciona la salida según las reglas del perfil |
| Global | Envía todo el tráfico que entra en el núcleo por la salida elegida en el grupo global de proxies |
| Direct | Conecta directamente con el destino, sin un nodo proxy |

El tráfico puede entrar mediante el proxy del sistema o TUN. El proxy del sistema sirve a las aplicaciones que respetan la configuración del sistema; TUN captura el tráfico mediante una interfaz de red virtual y lo enruta según el modo seleccionado.

## Motor de proxy

[mihomo](https://github.com/MetaCubeX/mihomo) gestiona las conexiones proxy, la resolución DNS, el enrutamiento por reglas y el tráfico TUN. Además de los formularios específicos de cada protocolo, se puede usar Raw YAML / JSON para configurar otros tipos de nodos de mihomo.

Las suscripciones, la biblioteca de nodos y las cadenas de proxies se integran en una única configuración de ejecución. Las cadenas enlazan cada salto mediante `dialer-proxy`, en el orden «cliente → proxy previo → nodo principal → proxy posterior → destino», dentro de una sola instancia del núcleo.

## Compilación

```bash
git clone --recurse-submodules https://github.com/MasterAlanLab/avalon.git
cd avalon
flutter pub get
```

La compilación requiere Flutter, Go y Rust. La CI utiliza actualmente Flutter 3.44.4 y Go 1.26.4. Comandos y dependencias adicionales por plataforma:

| Plataforma | Comando de compilación | Dependencias adicionales |
| :--- | :--- | :--- |
| Android | `dart setup.dart android` | Android SDK y NDK; definir `ANDROID_NDK` |
| Windows | `dart setup.dart windows` | Herramientas de C++ de Visual Studio, GCC, Inno Setup |
| macOS | `dart setup.dart macos` | Xcode, CocoaPods, Node.js / npm |
| Linux | `dart setup.dart linux` | El script instala GTK, AppIndicator, Keybinder y otras dependencias mediante apt |

Los paquetes de escritorio se compilan en el sistema operativo correspondiente y se guardan en `dist/`. La configuración completa del entorno está en el [flujo de compilación](../.github/workflows/build.yaml).

## Pruebas

```bash
# Análisis estático
flutter analyze --no-fatal-infos

# Pruebas unitarias y de widgets
flutter test

# Pruebas de la capa de integración del núcleo en Go
(cd core && go test .)

# Pruebas de los componentes Rust
cargo test --manifest-path services/helper/Cargo.toml
cargo test --manifest-path plugins/rust_api/rust/Cargo.toml
```

## Tecnologías

- Lenguajes: Dart, Go, Rust
- Framework de interfaz: Flutter / Material Design
- Gestión de estado: Riverpod
- Base de datos: SQLite / Drift
- Núcleo proxy: mihomo
- Gestión de paquetes: Pub, Go Modules, Cargo

## Recursos recomendados

Algunos enlaces son de afiliación. El autor puede recibir una comisión si te registras o compras a través de ellos. Los servicios y precios se detallan en los sitios correspondientes.

| Categoría | Proyecto / Servicio | Descripción |
| :--- | :--- | :--- |
| Pool de proxies | [Free Proxy](https://github.com/MasterAlanLab/free-proxy) | Pool autohospedado para la biblioteca de nodos o las cadenas de proxies |
| VPS | [BandwagonHost](https://cutt.ly/qywJNWzd) · [DMIT](https://cutt.ly/YywJIzY0) | Alojamiento de nodos y aplicaciones |
| Tarjetas de crédito virtuales | [Tarjetas virtuales internacionales](https://cutt.ly/IyrMR4Mg) | Pagos de servicios internacionales |
| Búsqueda de recursos | [Bot de búsqueda de Telegram](https://cutt.ly/2yeh3GOE) | Búsqueda de recursos en Telegram |
| Cuentas y tarjetas SIM | [Cuentas y tarjetas SIM internacionales](https://cutt.ly/dywt86NC) | Servicios de cuentas y comunicación |
| Navegador con huella digital | [BitBrowser](https://client.bitbrowser.cn/register?lang=zh&code=Alan123) | Gestión de entornos de navegador independientes |
| Alojamiento de correo | [Emailbox](https://github.com/MasterAlanLab/emailbox) | Gestión de correo en lotes y agrupación de proxies |
| Servicios CAPTCHA | [Captcha.run](https://captcha.run/sso?inviter=542f4f4f-31b6-4b70-b485-c4762c45d1e8) · [YesCaptcha](https://cutt.ly/Mywt39r0) | Reconocimiento de CAPTCHA |
| API de IA | [Intermediario CC / GPT](https://cutt.ly/JywJG3G5) | Servicios de API de modelos |
| Suscripciones compartidas | [Plataforma de suscripciones compartidas](https://cutt.ly/5ywt8vb4) | Uso compartido de suscripciones |

## Licencia

[AGPL-3.0](../LICENSE). El código de terceros conserva sus respectivas licencias. Consulta [NOTICE](../NOTICE) para ver los avisos de derechos de autor y licencias.

## Agradecimientos

- [FlClash](https://github.com/chen08209/FlClash)
- [mihomo](https://github.com/MetaCubeX/mihomo)
- [Surfboard](https://github.com/getsurfboard/surfboard)
