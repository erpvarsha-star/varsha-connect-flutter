# Firebase Studio / IDX

Open this folder in Firebase Studio or IDX.

Then run:

```bash
flutter create --platforms=android --org com.varshaforgings .
mkdir -p android/app
cp google-services.json android/app/google-services.json
flutter pub get
flutter build apk --debug
```
