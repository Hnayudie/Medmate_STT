# MedMate STT Everywhere — Keyboard Extension

## Ý tưởng

User cài MedMate một lần, sau đó dùng được tính năng STT từ bất kỳ app nào (Messenger, Zalo, Google Docs, v.v.) thông qua custom keyboard.

**Flow:** User switch sang MedMate keyboard → nhấn mic → nói → text insert thẳng vào input field của app host.

---

## Giải pháp: Custom Keyboard Extension

### iOS — Keyboard Extension (App Extension)
- Viết bằng **Swift/SwiftUI** (Flutter không support)
- Cần xin `RequestsOpenAccess` để gọi network
- Giới hạn RAM ~50MB cho extension
- Share auth token với app chính qua **App Group**

### Android — InputMethodService
- Viết bằng **Kotlin** (Flutter không support)
- Thoải mái hơn iOS, API chuẩn của Android
- Share credentials qua **SharedPreferences**

---

## Kiến trúc

```
MedMate App (Flutter)
    └── login, settings, history, subscription

MedMate Keyboard Extension (Swift / Kotlin)
    └── UI mic button + waveform
    └── Gọi MedMate STT API (shared auth token từ app chính)
    └── Insert text vào host app
```

---

## Effort ước tính

| Phần | Effort |
|---|---|
| iOS Keyboard Extension | ~3-4 tuần |
| Android IME | ~2-3 tuần |
| Shared auth (app ↔ extension) | ~3-5 ngày |
| UI mic + waveform trong keyboard | ~1 tuần |

> Keyboard extension phải viết **native hoàn toàn** — không tái dùng được Flutter code hiện tại. Cần assign native iOS (Swift) và Android (Kotlin) dev riêng.
