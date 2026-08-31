**🌐 Languages:** [中文](README.md) · [English](README.en.md) · [Deutsch](README.de.md) · [Español](README.es.md) · [العربية](README.ar.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md)

# Avalon — Cliente proxy multiplataforma con nodos individuales y cadenas de proxy

> Avalon es un fork de [FlClash](https://github.com/chen08209/FlClash) que utiliza el núcleo mihomo (Clash.Meta). Además del flujo basado en suscripciones, añade una **biblioteca de nodos independiente** y **cadenas de proxy de varios saltos**: puedes añadir por separado un nodo VLESS, VMess, Shadowsocks, Trojan, Hysteria2, TUIC, AnyTLS, SOCKS4/4a/5 o HTTP(S) y encadenarlos como `cliente → previo → nodo principal → posterior → destino`, todo dentro de **una única instancia del núcleo**, sin lanzar un segundo proceso.

> ⚠️ **Este proyecto se ofrece únicamente con fines de estudio, investigación e intercambio técnico. Queda estrictamente prohibido cualquier uso ilegal.** Quien lo utilice debe cumplir las leyes de su país o región y asume toda la responsabilidad derivada del uso de este software. Consulta el [Aviso legal](#aviso-legal).

<p>
  <a href="https://github.com/MasterAlanLab/Avalon/releases/"><img alt="Downloads" src="https://img.shields.io/github/downloads/MasterAlanLab/Avalon/total?style=flat-square&logo=github"></a>
  <a href="https://github.com/MasterAlanLab/Avalon/releases/"><img alt="Last Version" src="https://img.shields.io/github/release/MasterAlanLab/Avalon/all.svg?style=flat-square"></a>
  <a href="LICENSE"><img alt="License" src="https://img.shields.io/badge/License-GPL--3.0-blue?style=flat-square"></a>
  <img alt="Platforms" src="https://img.shields.io/badge/Plataformas-Android%20·%20Windows%20·%20macOS%20·%20Linux-brightgreen?style=flat-square">
  <img alt="Purpose" src="https://img.shields.io/badge/Uso-Solo%20estudio%20e%20investigación-orange?style=flat-square">
</p>

Comparto los fundamentos técnicos, la experiencia de uso y las novedades en estos canales:

[![YouTube](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/@MasterAlanLab)
[![Bilibili](https://img.shields.io/badge/Bilibili-00A1D6?style=for-the-badge&logo=bilibili&logoColor=white)](https://space.bilibili.com/3691004225914941)
[![Telegram](https://img.shields.io/badge/Telegram-0088CC?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/MasterAlanLab_Channel)

Escritorio:

<p style="text-align: center;">
    <img alt="desktop" src="snapshots/desktop.gif">
</p>

Móvil:

<p style="text-align: center;">
    <img alt="mobile" src="snapshots/mobile.gif">
</p>

---

## Qué añade Avalon respecto a FlClash

### 1. Biblioteca de nodos independiente (soporte de nodo único)

Ya no hace falta una suscripción para usar un nodo. Los nodos son objetos globales que se pueden añadir, editar, agrupar y vincular por separado:

- **Formularios por protocolo e importación de URI**: VLESS, VMess, Shadowsocks, Trojan, Hysteria2, TUIC, AnyTLS, SOCKS4/4a/5 y HTTP(S) con puerto o credenciales explícitos.
- **Nodos Raw YAML / JSON**: cubren **todos** los tipos de proxy admitidos por mihomo, incluidos los que aún no tienen formulario propio. Los nodos Raw también se guardan, vinculan, usan en cadenas y exportan.
- **Varias formas de añadir**: pegar una URI, escanear un código QR, abrir un esquema de URL del sistema o rellenar el formulario.
- **Suscripciones y nodos individuales conviven**: una dirección `http(s)://` normal se sincroniza como suscripción, mientras que una dirección con puerto, credenciales o parámetros de proxy explícitos se interpreta como nodo individual. Las entradas ambiguas pueden tratarse con el editor Raw.
- **Exportación**: nodos y cadenas se pueden exportar como configuración de Clash o JSON.

### 2. Cadenas de proxy (varios saltos / proxy previo)

- La dirección de visualización y de conexión es fija: **cliente → previo → nodo principal → posterior → destino**; el orden de la lista es el orden de anidamiento.
- Cada salto puede ser un nodo, un grupo de políticas global, un grupo de la suscripción actual o un **endpoint local SOCKS / HTTP / HTTPS ya existente** (por ejemplo, un puerto abierto por otro cliente en la misma máquina).
- Al compilar, el `dialer-proxy` de cada salto apunta al anterior, de modo que el resultado es **una sola configuración y un solo ciclo de vida del núcleo**. Una cadena de un solo salto equivale a usar ese nodo directamente.
- Un grupo de políticas usado como salto se expande en una matriz de ramas, con un límite predeterminado de 64 (configurable de 1 a 1024) y una vista previa en vivo del número de rutas y los diagnósticos antes de guardar.
- Las cadenas son objetos globales: se pueden copiar, renombrar y reordenar, y varias suscripciones pueden vincular la misma cadena. Los diagnósticos de nivel `error` impiden aplicar la cadena a la configuración en ejecución; los de nivel `warning` requieren confirmación.
- Al vincular eliges explícitamente los *grupos de entrada*: el selector generado se añade al final de esos grupos de políticas y la selección propia de la suscripción no se altera.

### 3. Todo lo heredado de FlClash

✈️ Multiplataforma: Android, Windows, macOS y Linux

💻 Se adapta a muchos tamaños de pantalla, varios temas de color

💡 Diseño Material You con una interfaz al estilo de [Surfboard](https://github.com/getsurfboard/surfboard)

☁️ Sincronización de datos mediante WebDAV

✨ Importación de suscripciones con un clic, modo oscuro

---

## Instalación

### Descarga

<a href="https://github.com/MasterAlanLab/Avalon/releases"><img alt="Get it on GitHub" src="snapshots/get-it-on-github.svg" width="200px"/></a>

### Dependencias en Linux

⚠️ Instala estas dependencias antes de usarlo:

```bash
sudo apt-get install libayatana-appindicator3-dev
sudo apt-get install libkeybinder-3.0-dev
```

### Acciones de broadcast en Android

Se admiten las siguientes acciones:

```bash
com.masteralanlab.avalon.action.START

com.masteralanlab.avalon.action.STOP

com.masteralanlab.avalon.action.TOGGLE
```

---

## Inicio rápido

1. **Añade una configuración**: pega un enlace de suscripción en «Suscripciones» o pega directamente una URI `vless://`, `anytls://`, `socks5://`… en «Nodos», o impórtala escaneando un código QR.
2. **Crea una cadena** (opcional): en «Cadenas», arrastra nodos o grupos de políticas en el orden previo → nodo principal → posterior y revisa el número de rutas y los diagnósticos antes de guardar.
3. **Vincula e inicia**: vincula la cadena a la suscripción actual, elige los grupos de entrada y arranca desde la pantalla principal. Las suscripciones sin cadena vinculada mantienen su comportamiento original.

---

## Compilación

1. Actualiza los submódulos

   ```bash
   git submodule update --init --recursive
   ```

2. Instala los entornos de `Flutter` y `Golang`

3. Compila la aplicación

    - android

        1. Instala `Android SDK` y `Android NDK`

        2. Define la variable de entorno `ANDROID_NDK`

        3. Ejecuta el script de compilación

           ```bash
           dart setup.dart android
           ```

    - windows

        1. Requiere una máquina con Windows

        2. Instala `GCC` e `Inno Setup`

        3. Ejecuta el script de compilación

           ```bash
           dart setup.dart windows
           ```

    - linux

        1. Requiere una máquina con Linux

        2. El script de setup instala las dependencias, o hazlo a mano:

           ```bash
           sudo apt-get install -y libayatana-appindicator3-dev libkeybinder-3.0-dev
           ```

        3. Ejecuta el script de compilación

           ```bash
           dart setup.dart linux
           ```

    - macOS

        1. Requiere una máquina con macOS

        2. Ejecuta el script de compilación

           ```bash
           dart setup.dart macos
           ```

---

## Recursos recomendados

Servicios que uso o que encajan bien con este proyecto. Algunos enlaces son promocionales o de afiliado: registrarse o comprar a través de ellos puede darle al autor una pequeña comisión **sin coste adicional para ti**.

- **Pool de proxies propio**: [Free Proxy](https://github.com/MasterAlanLab/free-proxy) — ejecuta un pool de nodos gratuitos en tu propio VPS y expone SOCKS5 / HTTP, que Avalon puede usar como nodo individual o como un salto de la cadena
- **VPS con rutas optimizadas hacia China**: [BandwagonHost](https://cutt.ly/qywJNWzd) · [DMIT](https://cutt.ly/YywJIzY0) — para nodos propios o servidores de salida
- **Tarjetas de crédito virtuales**: [aquí](https://cutt.ly/IyrMR4Mg) — para pagar servicios extranjeros
- **Bot de búsqueda de recursos en Telegram**: [aquí](https://cutt.ly/2yeh3GOE)
- **Cuentas y SIM extranjeras**: [aquí](https://cutt.ly/dywt86NC)
- **Navegador antidetección**: [BitBrowser](https://client.bitbrowser.cn/register?lang=zh&code=Alan123) — aislamiento de entornos junto a proxies encadenados
- **Gestión masiva de buzones**: [Emailbox](https://github.com/MasterAlanLab/emailbox) — administra buzones en bloque con proxies por grupo
- **Resolución de captchas**: [Captcha.run](https://captcha.run/sso?inviter=542f4f4f-31b6-4b70-b485-c4762c45d1e8) · [YesCaptcha](https://cutt.ly/Mywt39r0)
- **Relay de API GPT**: [CC / GPT relay](https://cutt.ly/JywJG3G5)
- **Suscripciones compartidas**: [aquí](https://cutt.ly/5ywt8vb4)

---

## Aviso legal

- Este proyecto es **solo para estudio, investigación e intercambio técnico, y queda estrictamente prohibido cualquier uso ilegal**, incluidos, entre otros, intrusiones en sistemas ajenos, elusión de restricciones de acceso allí donde la ley local lo prohíba, ataques de red, difusión de contenidos ilícitos o cualquier otra actividad delictiva.
- Quien lo utilice debe cumplir las leyes de su país o región. Todas las consecuencias del uso recaen en la persona usuaria; autores y colaboradores no responden por daños directos ni indirectos.
- Este proyecto **no proporciona, vende ni recomienda ningún nodo proxy ni servicio de suscripción**, y no garantiza la disponibilidad, privacidad o seguridad de nodos de terceros. Nunca envíes información sensible a través de nodos de origen desconocido.
- Si en tu país o región este tipo de software está prohibido, deja de usarlo y elimínalo de inmediato.
- Los enlaces a VPS, tarjetas virtuales, bots de Telegram y similares son promocionales o de afiliado. Comprar a través de ellos puede darle al autor una pequeña comisión **sin coste adicional para ti**. Gracias por el apoyo ❤️

---

## Licencia

Este proyecto se publica bajo **GPL-3.0**, la misma licencia que el proyecto original. El texto completo está en [LICENSE](LICENSE). El aviso de fork y los componentes de terceros están en [NOTICE](NOTICE).

Avalon es una versión modificada (fork) de [FlClash](https://github.com/chen08209/FlClash):

- Los derechos de autor de la obra original pertenecen a los autores y colaboradores de FlClash; se conservan todos los avisos originales de copyright y licencia.
- Este proyecto modifica la obra original, principalmente añadiendo la biblioteca de nodos independiente, las cadenas de proxy de varios saltos y la compilación de cadenas en un único núcleo, además de cambiar el nombre del proyecto y los identificadores de la aplicación. Consulta [CHANGELOG.md](CHANGELOG.md) para ver un resumen.
- Conforme a la GPL-3.0, toda redistribución basada en este proyecto debe publicarse igualmente bajo GPL-3.0 y conservar los avisos anteriores.
- Avalon **no está afiliado** al proyecto original FlClash: no abras incidencias sobre este fork en su repositorio.

## Agradecimientos

- [FlClash](https://github.com/chen08209/FlClash) — el proyecto original en el que se basa este fork 🙏
- [mihomo (Clash.Meta)](https://github.com/MetaCubeX/mihomo) — el núcleo de proxy
- [Surfboard](https://github.com/getsurfboard/surfboard) — referencia de diseño de la interfaz

## Contacto

- Canal de Telegram: <https://t.me/MasterAlanLab_Channel>
- Consultas comerciales: <masteralanlab@gmail.com>

## Star

La forma más sencilla de apoyar al desarrollador es pulsar la estrella (⭐) en la parte superior de la página.

<p style="text-align: center;">
    <a href="https://api.star-history.com/svg?repos=MasterAlanLab/Avalon&Date">
        <img alt="star" width=50% src="https://api.star-history.com/svg?repos=MasterAlanLab/Avalon&Date"/>
    </a>
</p>
