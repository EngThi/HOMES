# 🗄️ Firebase Schema & Data Structure

O HOMES utiliza **Firebase Firestore** como banco de dados NoSQL principal e **Firebase Storage** para armazenar assets gerados (imagens e áudios).

---

## 🔥 Firestore Collections

### 1. `projects` (Coleção Principal)
Armazena todo o estado de cada vídeo solicitado.

**Document ID:** `random_uuid` ou `auto_generated`

```json
{
  "userId": "user_123",
  "status": "READY_TO_RENDER", // Enum: PENDING, GENERATING_SCRIPT, GENERATING_ASSETS, READY_TO_RENDER, RENDERING, COMPLETED, FAILED
  "config": {
    "prompt": "Evolução da IA",
    "style": "documentary",
    "aspectRatio": "9:16",
    "language": "pt-BR"
  },
  "script": [
    {
      "index": 0,
      "text": "Desde os primeiros algoritmos...",
      "imagePrompt": "Ancient mechanical computer gears, cinematic lighting",
      "imageUrl": "https://storage.googleapis.com/.../img0.png",
      "duration": 5.2
    }
  ],
  "assets": {
    "bgmUrl": "https://storage.googleapis.com/.../music.mp3",
    "finalVideoUrl": null,
    "totalDuration": 35.0
  },
  "metadata": {
    "createdAt": "2026-01-05T10:00:00Z",
    "completedAt": null,
    "renderTime": 0
  }
}
```

### 2. `users`
Perfis de usuários e preferências de marca.

```json
{
  "displayName": "EngThi",
  "email": "thiago@example.com",
  "brandProfile": {
    "preferredVoice": "pt-BR-AntonioNeural",
    "defaultStyle": "cinematic",
    "watermarkText": "@EngThi"
  },
  "usage": {
    "totalVideos": 42,
    "lastUsed": "2026-01-06T00:30:00Z"
  }
}
```

---

## 📁 Firebase Storage Structure

Os arquivos são organizados por ID de projeto para facilitar a limpeza posterior.

```
/projects/
  /{projectId}/
    ├── script.json
    ├── scenes/
    │   ├── scene_0.png
    │   ├── scene_1.png
    │   └── scene_2.png
    ├── audio/
    │   ├── voice_full.mp3
    │   └── background_music.mp3
    └── render/
        └── final_video.mp4
```

---

## 🔒 Security Rules (Sugestão)

```javascript
service cloud.firestore {
  match /databases/{database}/documents {
    match /projects/{projectId} {
      allow read, write: if request.auth != null && request.auth.uid == resource.data.userId;
      allow create: if request.auth != null;
    }
  }
}
```
