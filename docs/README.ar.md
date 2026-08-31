**🌐 Languages:** [中文](../README.md) · [English](README.en.md) · [Deutsch](README.de.md) · [Español](README.es.md) · [العربية](README.ar.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md)

# Avalon — عميل بروكسي متعدد المنصات يدعم العقد المفردة وسلاسل البروكسي

> Avalon مشتق من [FlClash](https://github.com/chen08209/FlClash) ويعتمد على نواة mihomo‏ (Clash.Meta). إضافةً إلى أسلوب الاشتراكات المعتاد، يضيف **مكتبة عقد مستقلة** و**سلاسل بروكسي متعددة القفزات**: يمكنك إضافة عقدة واحدة من نوع VLESS أو VMess أو Shadowsocks أو Trojan أو Hysteria2 أو TUIC أو AnyTLS أو SOCKS4/4a/5 أو HTTP(S) بشكل منفرد، ثم ترتيبها في مسار «العميل ← العقدة الأمامية ← العقدة الرئيسية ← العقدة اللاحقة ← الوجهة»، وكل ذلك داخل **نسخة واحدة من النواة** دون تشغيل عملية ثانية.

> ⚠️ **هذا المشروع مخصص للتعلّم والبحث والتبادل التقني فقط، ويُمنع منعًا باتًا استخدامه في أي غرض غير قانوني.** على المستخدم الالتزام بقوانين بلده أو منطقته وتحمّل كامل المسؤولية عن استخدام هذا البرنامج. راجع [إخلاء المسؤولية](#إخلاء-المسؤولية).

<p>
  <a href="https://github.com/MasterAlanLab/Avalon/releases/"><img alt="Downloads" src="https://img.shields.io/github/downloads/MasterAlanLab/Avalon/total?style=flat-square&logo=github"></a>
  <a href="https://github.com/MasterAlanLab/Avalon/releases/"><img alt="Last Version" src="https://img.shields.io/github/release/MasterAlanLab/Avalon/all.svg?style=flat-square"></a>
  <a href="../LICENSE"><img alt="License" src="https://img.shields.io/badge/License-AGPL--3.0-blue?style=flat-square"></a>
  <img alt="Platforms" src="https://img.shields.io/badge/Platforms-Android%20·%20Windows%20·%20macOS%20·%20Linux-brightgreen?style=flat-square">
  <img alt="Purpose" src="https://img.shields.io/badge/%D8%A7%D9%84%D8%A7%D8%B3%D8%AA%D8%AE%D8%AF%D8%A7%D9%85-%D9%84%D9%84%D8%AA%D8%B9%D9%84%D9%85%20%D9%88%D8%A7%D9%84%D8%A8%D8%AD%D8%AB%20%D9%81%D9%82%D8%B7-orange?style=flat-square">
</p>

أشارك المبادئ التقنية وتجارب الاستخدام وأخبار التحديثات عبر القنوات التالية:

[![YouTube](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/@MasterAlanLab)
[![Bilibili](https://img.shields.io/badge/Bilibili-00A1D6?style=for-the-badge&logo=bilibili&logoColor=white)](https://space.bilibili.com/3691004225914941)
[![Telegram](https://img.shields.io/badge/Telegram-0088CC?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/MasterAlanLab_Channel)

على سطح المكتب:

<p style="text-align: center;">
    <img alt="desktop" src="../snapshots/desktop.gif">
</p>

على الهاتف:

<p style="text-align: center;">
    <img alt="mobile" src="../snapshots/mobile.gif">
</p>

---

## ما الذي يضيفه Avalon مقارنةً بـ FlClash

### 1. مكتبة عقد مستقلة (دعم العقدة المفردة)

لم يعد الاشتراك شرطًا لاستخدام أي عقدة. العقد موارد عامة يمكن إضافتها وتحريرها وتجميعها وربطها بشكل منفرد:

- **نماذج مخصّصة لكل بروتوكول واستيراد عبر URI**: ‏VLESS و VMess و Shadowsocks و Trojan و Hysteria2 و TUIC و AnyTLS و SOCKS4/4a/5، إضافةً إلى HTTP(S) الذي يتضمن منفذًا أو بيانات اعتماد صريحة.
- **عقد Raw بصيغة YAML / JSON**: تغطي **جميع** أنواع البروكسي التي تدعمها mihomo، بما فيها البروتوكولات التي لا تغطيها النماذج المخصّصة بعد. وتظل عقد Raw قابلة للحفظ والربط والاستخدام في السلاسل والتصدير.
- **طرق إدخال متعددة**: لصق رابط URI، أو مسح رمز QR، أو فتح مخطط URL من النظام، أو تعبئة النموذج يدويًا.
- **تعايش الاشتراكات مع العقد المفردة**: يُزامَن العنوان العادي `http(s)://` باعتباره اشتراكًا، بينما يُحلَّل العنوان الذي يحمل منفذًا أو بيانات اعتماد أو معاملات بروكسي باعتباره عقدة مفردة، أما المدخلات الملتبسة فيمكن معالجتها عبر محرّر Raw.
- **التصدير**: يمكن تصدير العقد والسلاسل بصيغة إعدادات Clash أو JSON.

### 2. سلاسل البروكسي (قفزات متعددة / بروكسي أمامي)

- اتجاه العرض والاتصال ثابت: **العميل ← العقدة الأمامية ← العقدة الرئيسية ← العقدة اللاحقة ← الوجهة**، وترتيب القائمة هو نفسه ترتيب التداخل.
- يمكن أن تكون كل قفزة عقدة، أو مجموعة سياسات عامة، أو مجموعة من الاشتراك الحالي، أو **نقطة نهاية محلية قائمة من نوع SOCKS / HTTP / HTTPS** (مثل منفذ فتحه عميل آخر على الجهاز نفسه).
- عند التجميع يشير `dialer-proxy` لكل قفزة إلى القفزة السابقة، فتكون النتيجة **إعدادًا واحدًا ودورة حياة واحدة للنواة**. والسلسلة ذات القفزة الواحدة تعادل استخدام تلك العقدة مباشرة.
- تتوسّع مجموعة السياسات المستخدمة كقفزة إلى مصفوفة تفرّعات، بحدّ افتراضي 64 مسارًا (قابل للضبط بين 1 و1024)، مع عرض فوري لعدد المسارات ونتائج التشخيص قبل الحفظ.
- السلاسل كائنات عامة: يمكن نسخها وإعادة تسميتها وإعادة ترتيبها، وربط السلسلة نفسها بعدة اشتراكات. تمنع تشخيصات المستوى `error` تطبيق السلسلة على إعدادات التشغيل، بينما يتطلب المستوى `warning` تأكيدًا.
- عند الربط تختار صراحةً «مجموعات الدخول»: يُضاف محدِّد السلسلة إلى نهاية تلك المجموعات دون المساس باختيار الاشتراك الأصلي.

### 3. ما هو موروث من FlClash

✈️ متعدد المنصات: ‏Android و Windows و macOS و Linux

💻 يتكيّف مع أحجام شاشات متعددة، مع سمات ألوان متنوعة

💡 تصميم Material You بواجهة شبيهة بـ [Surfboard](https://github.com/getsurfboard/surfboard)

☁️ مزامنة البيانات عبر WebDAV

✨ استيراد الاشتراك بنقرة واحدة، والوضع الداكن

---

## التثبيت

### التنزيل

<a href="https://github.com/MasterAlanLab/Avalon/releases"><img alt="Get it on GitHub" src="../snapshots/get-it-on-github.svg" width="200px"/></a>

### متطلبات Linux

⚠️ تأكد من تثبيت الحزم التالية قبل الاستخدام:

```bash
sudo apt-get install libayatana-appindicator3-dev
sudo apt-get install libkeybinder-3.0-dev
```

### أوامر البث في Android

الإجراءات المدعومة:

```bash
com.masteralanlab.avalon.action.START

com.masteralanlab.avalon.action.STOP

com.masteralanlab.avalon.action.TOGGLE
```

---

## البدء السريع

1. **أضف إعدادًا**: الصق رابط اشتراك في صفحة «الاشتراكات»، أو الصق مباشرةً رابط `vless://` أو `anytls://` أو `socks5://` في صفحة «العقد»، أو استوردها بمسح رمز QR.
2. **أنشئ سلسلة** (اختياري): في صفحة «السلاسل» اسحب العقد أو مجموعات السياسات بالترتيب: أمامية ← رئيسية ← لاحقة، وتحقّق من عدد المسارات ونتائج التشخيص قبل الحفظ.
3. **اربط ثم شغّل**: اربط السلسلة بالاشتراك الحالي واختر مجموعات الدخول، ثم شغّل من الصفحة الرئيسية. أما الاشتراكات غير المرتبطة بسلسلة فتحتفظ بسلوكها الأصلي.

---

## البناء

1. تحديث الوحدات الفرعية

   ```bash
   git submodule update --init --recursive
   ```

2. تثبيت بيئتَي `Flutter` و`Golang`

3. بناء التطبيق

    - android

        1. ثبّت `Android SDK` و`Android NDK`

        2. اضبط متغير البيئة `ANDROID_NDK`

        3. شغّل سكربت البناء

           ```bash
           dart setup.dart android
           ```

    - windows

        1. يتطلب جهازًا يعمل بنظام Windows

        2. ثبّت `GCC` و`Inno Setup`

        3. شغّل سكربت البناء

           ```bash
           dart setup.dart windows
           ```

    - linux

        1. يتطلب جهازًا يعمل بنظام Linux

        2. يتولى سكربت الإعداد تثبيت المتطلبات، أو ثبّتها يدويًا:

           ```bash
           sudo apt-get install -y libayatana-appindicator3-dev libkeybinder-3.0-dev
           ```

        3. شغّل سكربت البناء

           ```bash
           dart setup.dart linux
           ```

    - macOS

        1. يتطلب جهازًا يعمل بنظام macOS

        2. شغّل سكربت البناء

           ```bash
           dart setup.dart macos
           ```

---

## موارد مقترحة

خدمات أستخدمها بنفسي أو تناسب هذا المشروع. بعض الروابط ترويجية / بنظام العمولة (affiliate)، وقد يحصل المؤلف على عمولة صغيرة عند التسجيل أو الشراء من خلالها **دون أي تكلفة إضافية عليك**.

- **مجمّع بروكسي ذاتي الاستضافة**: [Free Proxy](https://github.com/MasterAlanLab/free-proxy) — يشغّل مجمّع عقد مجانية على خادمك الخاص ويوفّر SOCKS5 / HTTP، ويمكن استخدامه في Avalon كعقدة مفردة أو كقفزة ضمن سلسلة
- **خوادم VPS بخطوط محسّنة نحو الصين**: [BandwagonHost](https://cutt.ly/qywJNWzd) · [DMIT](https://cutt.ly/YywJIzY0) — لبناء عقد خاصة أو خوادم خروج
- **بطاقات ائتمان افتراضية**: [من هنا](https://cutt.ly/IyrMR4Mg) — لدفع قيمة الخدمات الأجنبية
- **بوت بحث عن الموارد في Telegram**: [من هنا](https://cutt.ly/2yeh3GOE)
- **حسابات وشرائح اتصال أجنبية**: [من هنا](https://cutt.ly/dywt86NC)
- **متصفح مضاد للبصمات**: [BitBrowser](https://client.bitbrowser.cn/register?lang=zh&code=Alan123) — لعزل البيئات فوق البروكسي المتسلسل
- **إدارة صناديق البريد بالجملة**: [Emailbox](https://github.com/MasterAlanLab/emailbox) — إدارة صناديق البريد دفعةً واحدة مع بروكسي لكل مجموعة
- **خدمات حل الكابتشا**: [Captcha.run](https://captcha.run/sso?inviter=542f4f4f-31b6-4b70-b485-c4762c45d1e8) · [YesCaptcha](https://cutt.ly/Mywt39r0)
- **وسيط واجهة GPT**: [CC / GPT relay](https://cutt.ly/JywJG3G5)
- **اشتراكات مشتركة**: [من هنا](https://cutt.ly/5ywt8vb4)

---

## إخلاء المسؤولية

- هذا المشروع **مخصص للتعلّم والبحث والتبادل التقني فقط، ويُمنع منعًا باتًا استخدامه في أي غرض غير قانوني**، بما في ذلك على سبيل المثال لا الحصر اختراق أنظمة الآخرين، أو تجاوز قيود الوصول حيث يحظر القانون المحلي ذلك، أو تنفيذ هجمات شبكية، أو نشر محتوى مخالف للقانون، أو أي نشاط إجرامي آخر.
- على المستخدم الالتزام بقوانين بلده أو منطقته. ويتحمّل المستخدم وحده كل ما ينتج عن الاستخدام، ولا يتحمّل المؤلفون والمساهمون أي مسؤولية عن أضرار مباشرة أو غير مباشرة.
- هذا المشروع **لا يوفّر ولا يبيع ولا يوصي بأي عقد بروكسي أو خدمات اشتراك**، ولا يضمن توافر عقد الأطراف الثالثة ولا خصوصيتها ولا أمانها. لا ترسل معلومات حساسة عبر عقد مجهولة المصدر.
- إذا كان هذا النوع من البرامج محظورًا في بلدك أو منطقتك، فتوقّف عن استخدامه واحذفه فورًا.
- روابط خوادم VPS والبطاقات الافتراضية وبوتات Telegram وما شابهها الواردة أعلاه هي روابط ترويجية / بنظام العمولة، وقد تدرّ على المؤلف عمولة صغيرة **دون أي تكلفة إضافية عليك**. شكرًا لدعمك ❤️

---

## الرخصة

تخضع الإضافات والتعديلات التي كتبها Avalon لرخصة **AGPL-3.0**. ويبقى كود FlClash الأصلي وmihomo والمكوّنات الأخرى التابعة لجهات خارجية خاضعًا لرخصها الخاصة. راجع [LICENSE](../LICENSE) لشروط AGPL، و[LICENSE-GPL-3.0](../LICENSE-GPL-3.0) لنص GPLv3 الخاص بالمشروع الأصلي، و[NOTICE](../NOTICE) لإشعار الاشتقاق ومكوّنات الجهات الخارجية.

‏Avalon نسخة معدَّلة (fork) من [FlClash](https://github.com/chen08209/FlClash):

- حقوق العمل الأصلي مملوكة لمؤلفي FlClash والمساهمين فيه، وقد جرى الإبقاء على جميع إشعارات حقوق النشر والرخصة الأصلية.
- يعدّل هذا المشروع العمل الأصلي، وأبرز التعديلات: مكتبة العقد المستقلة، وسلاسل البروكسي متعددة القفزات، وتجميع السلاسل داخل نواة واحدة، إضافةً إلى تغيير اسم المشروع ومعرّفات التطبيق. راجع [CHANGELOG.md](../CHANGELOG.md) للاطلاع على ملخّص.
- تُوزَّع إضافات وتعديلات Avalon بموجب AGPL-3.0؛ ويجب أن تلتزم عمليات إعادة التوزيع بمتطلبات المصدر والتفاعل عبر الشبكة وأن تحافظ على الإشعارات المذكورة أعلاه.
- ‏Avalon **غير تابع** لمشروع FlClash الأصلي، فالرجاء عدم فتح تذاكر تخص هذا المشروع في مستودعهم.

## شكر وتقدير

- [FlClash](https://github.com/chen08209/FlClash) — المشروع الأصلي الذي بُني عليه هذا الاشتقاق 🙏
- [mihomo (Clash.Meta)](https://github.com/MetaCubeX/mihomo) — نواة البروكسي
- [Surfboard](https://github.com/getsurfboard/surfboard) — مرجع تصميم الواجهة

## التواصل

- قناة Telegram: <https://t.me/MasterAlanLab_Channel>
- للتعاون التجاري: <masteralanlab@gmail.com>

## نجمة

أسهل طريقة لدعم المطوّر هي الضغط على النجمة (⭐) أعلى الصفحة.

<p style="text-align: center;">
    <a href="https://api.star-history.com/svg?repos=MasterAlanLab/Avalon&Date">
        <img alt="star" width=50% src="https://api.star-history.com/svg?repos=MasterAlanLab/Avalon&Date"/>
    </a>
</p>
