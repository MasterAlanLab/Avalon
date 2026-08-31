# Avalon

عميل بروكسي لأنظمة Android وWindows وmacOS وLinux، يعتمد على نواة [mihomo](https://github.com/MetaCubeX/mihomo). يدعم العقد المستقلة وإدارة الاشتراكات وسلاسل البروكسي متعددة القفزات. طُوّر باستخدام Flutter.

> طُوّر Avalon بالاعتماد على [FlClash](https://github.com/chen08209/FlClash).

نزّل حزمة التثبيت المناسبة لنظامك من [Releases](https://github.com/MasterAlanLab/Avalon/releases).

## الميزات

- دعم البروتوكولات: VLESS وVMess وShadowsocks وTrojan وHysteria2 وTUIC وAnyTLS وSOCKS4/4a/5 وHTTP(S) وغيرها.
- إدارة العقد: إدارة كل عقدة بشكل مستقل، مع الإضافة والتعديل والنسخ والربط بملفات التعريف.
- إدارة الاشتراكات: استيراد ملفات التعريف من الروابط أو الملفات المحلية، مع التحديث التلقائي للاشتراكات.
- سلاسل البروكسي: الجمع بين العقد ومجموعات البروكسي ونقاط اتصال البروكسي المحلية، مع دعم البروكسي الأمامي والاتصالات متعددة القفزات ومعاينة المسارات.
- إنشاء ملفات التعريف: إنشاء ملفات جاهزة للتشغيل من السلاسل، أو إضافة السلاسل إلى مجموعات البروكسي في ملفات التعريف الحالية.
- الاستيراد والتصدير: دعم روابط URI للعقد ورموز QR وصيغ YAML / JSON، وتصدير العقد والسلاسل في حزمة تشمل مرفقاتها.
- قواعد التوجيه: أوضاع Rule وGlobal وDirect، مع إمكانية تعديل قواعد التوجيه ومجموعات البروكسي.
- تشخيص الشبكة: اختبار زمن استجابة العقد، وعرض الاتصالات في الوقت الفعلي، وسجلات التشغيل.
- مزامنة البيانات: نسخ احتياطي واستعادة محليان، مع المزامنة عبر WebDAV.
- المظهر: واجهات للحاسوب والهاتف، مع الوضع الداكن وتخصيص الألوان.

## أوضاع التشغيل

| الوضع | الوصف |
| :--- | ---: |
| Rule | اختيار مسار الخروج وفق قواعد ملف التعريف |
| Global | توجيه كل حركة المرور الداخلة إلى النواة عبر مسار الخروج المحدد في مجموعة البروكسي العامة |
| Direct | الاتصال بالوجهة مباشرة دون عقدة بروكسي |

يمكن استقبال حركة المرور عبر بروكسي النظام أو TUN. يخدم بروكسي النظام التطبيقات التي تتبع إعدادات النظام، بينما يستقبل TUN حركة المرور عبر واجهة شبكة افتراضية ويوجهها وفق الوضع المحدد.

## النواة

تتولى [mihomo](https://github.com/MetaCubeX/mihomo) اتصالات البروكسي وحل أسماء DNS والتوجيه القائم على القواعد وحركة مرور TUN. إلى جانب نماذج الإعداد الخاصة بالبروتوكولات، يمكن استخدام Raw YAML / JSON لإعداد أنواع أخرى من عقد mihomo.

تُدمج الاشتراكات ومكتبة العقد وسلاسل البروكسي في إعداد تشغيل موحد. تربط السلاسل القفزات باستخدام `dialer-proxy` بترتيب «العميل ← البروكسي الأمامي ← العقدة الرئيسية ← البروكسي الخلفي ← الوجهة»، ضمن مثيل واحد للنواة.

## البناء

```bash
git clone --recurse-submodules https://github.com/MasterAlanLab/Avalon.git
cd Avalon
flutter pub get
```

يتطلب البناء Flutter وGo وRust. تستخدم بيئة التكامل المستمر حاليًا Flutter 3.44.4 وGo 1.26.4. أوامر البناء والاعتماديات الإضافية لكل منصة:

| المنصة | أمر البناء | الاعتماديات الإضافية |
| :--- | :--- | ---: |
| Android | `dart setup.dart android` | Android SDK وNDK، مع ضبط `ANDROID_NDK` |
| Windows | `dart setup.dart windows` | أدوات C++ في Visual Studio وGCC وInno Setup |
| macOS | `dart setup.dart macos` | Xcode وCocoaPods وNode.js / npm |
| Linux | `dart setup.dart linux` | يثبت السكربت GTK وAppIndicator وKeybinder وغيرها من الاعتماديات عبر apt |

تُبنى حزم سطح المكتب على نظام التشغيل المقابل، وتُحفظ المخرجات في `dist/`. إعدادات البيئة الكاملة متاحة في [سير عمل البناء](../.github/workflows/build.yaml).

## الاختبارات

```bash
# التحليل الساكن
flutter analyze --no-fatal-infos

# اختبارات الوحدات وعناصر الواجهة
flutter test

# اختبارات غلاف النواة المكتوب بلغة Go
(cd core && go test .)

# اختبارات مكونات Rust
cargo test --manifest-path services/helper/Cargo.toml
cargo test --manifest-path plugins/rust_api/rust/Cargo.toml
```

## التقنيات المستخدمة

- اللغات: Dart وGo وRust
- إطار الواجهة: Flutter / Material Design
- إدارة الحالة: Riverpod
- قاعدة البيانات: SQLite / Drift
- نواة البروكسي: mihomo
- إدارة الحزم: Pub وGo Modules وCargo

## موارد موصى بها

بعض الروابط هي روابط تسويق بالعمولة. قد يحصل المؤلف على عمولة عند التسجيل أو الشراء عبرها. تفاصيل الخدمات وأسعارها موضحة في المواقع المعنية.

| الفئة | المشروع / الخدمة | الوصف |
| ---: | ---: | ---: |
| مجمّع بروكسي | [Free Proxy](https://github.com/MasterAlanLab/free-proxy) | مجمّع بروكسي ذاتي الاستضافة للاستخدام مع مكتبة العقد أو سلاسل البروكسي |
| VPS | [BandwagonHost](https://cutt.ly/qywJNWzd) · [DMIT](https://cutt.ly/YywJIzY0) | استضافة العقد والتطبيقات |
| بطاقات ائتمان افتراضية | [بطاقات افتراضية دولية](https://cutt.ly/IyrMR4Mg) | الدفع للخدمات الدولية |
| البحث عن الموارد | [بوت بحث Telegram](https://cutt.ly/2yeh3GOE) | البحث عن موارد على Telegram |
| الحسابات وشرائح SIM | [حسابات وشرائح SIM دولية](https://cutt.ly/dywt86NC) | خدمات الحسابات والاتصالات |
| متصفح البصمات الرقمية | [BitBrowser](https://client.bitbrowser.cn/register?lang=zh&code=Alan123) | إدارة بيئات متصفح مستقلة |
| استضافة البريد | [Emailbox](https://github.com/MasterAlanLab/emailbox) | إدارة البريد بالجملة وتجميع البروكسيات |
| خدمات CAPTCHA | [Captcha.run](https://captcha.run/sso?inviter=542f4f4f-31b6-4b70-b485-c4762c45d1e8) · [YesCaptcha](https://cutt.ly/Mywt39r0) | التعرف على رموز CAPTCHA |
| واجهات الذكاء الاصطناعي | [وسيط CC / GPT](https://cutt.ly/JywJG3G5) | خدمات واجهات برمجة النماذج |
| مشاركة الاشتراكات | [منصة مشاركة الاشتراكات](https://cutt.ly/5ywt8vb4) | استخدام الاشتراكات بشكل مشترك |

## الترخيص

[AGPL-3.0](../LICENSE). تحتفظ أكواد الأطراف الثالثة بتراخيصها الخاصة. تفاصيل حقوق النشر والتراخيص متاحة في [NOTICE](../NOTICE).

## شكر وتقدير

- [FlClash](https://github.com/chen08209/FlClash)
- [mihomo](https://github.com/MetaCubeX/mihomo)
- [Surfboard](https://github.com/getsurfboard/surfboard)
