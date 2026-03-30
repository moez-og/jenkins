# 🚀 Java-CICD-Pipeline

> **Projet personnel DevOps** – Mise en place d'un pipeline CI/CD complet pour une application Java (Maven) avec Jenkins et Docker.

---

## 📌 Contexte

Ce projet implémente une chaîne d'intégration et de déploiement continus (**CI/CD**) pour une application Java, en automatisant les étapes de build, containerisation et déploiement via **Jenkins** et **Docker**.

---

## 🏗️ Architecture du Pipeline

```
┌─────────────┐    ┌─────────────┐    ┌──────────────┐    ┌─────────────┐
│  Code Push  │───▶│ Maven Build │───▶│ Docker Build │───▶│  Docker Hub │
│   GitHub    │    │  (Package)  │    │   & Tag      │    │   (Push)    │
└─────────────┘    └─────────────┘    └──────────────┘    └─────────────┘
                         ▲
                    Jenkins Pipeline
```

### Stages du Pipeline Jenkins

| Stage | Description |
|---|---|
| **Build Maven** | Compilation et packaging de l'app (`mvn clean package`) |
| **Build Docker Image** | Construction de l'image Docker taguée avec le numéro de build |
| **Push Image** | Push vers Docker Hub avec credentials sécurisés |

---

## 🛠️ Stack Technique

| Technologie | Usage |
|---|---|
| **Jenkins** | Orchestration du pipeline CI/CD |
| **Docker** | Containerisation de l'application |
| **Docker Compose** | Déploiement multi-services |
| **Maven 3.9** | Build et gestion des dépendances Java |
| **Java 17** | Runtime (Eclipse Temurin JDK) |
| **Docker Hub** | Registry des images |

---

## 📁 Structure du Projet

```
java-cicd-pipeline/
│
├── Jenkinsfile              # Pipeline CI/CD principal (Build → Docker → Push)
├── Jenkinsfile_deploy       # Pipeline de déploiement
├── Dockerfile               # Image Docker de l'application
├── docker-compose.app.yml   # Déploiement de l'application
├── docker-compose.jenkins.yml # Déploiement de Jenkins
├── pom.xml                  # Configuration Maven
│
└── src/
    └── main/java/
        └── com/example/
            └── App.java     # Application Java
```

---

## ⚙️ Pipeline CI/CD (Jenkinsfile)

```groovy
pipeline {
    agent any
    environment {
        IMAGE_NAME = "moezog/my-app"
        TAG = "${BUILD_NUMBER}"
    }
    stages {
        stage('Build Maven')       { /* mvn clean package */ }
        stage('Build Docker Image'){ /* docker build + tag  */ }
        stage('Push Image')        { /* docker push vers Hub */ }
    }
}
```

---

## 🚀 Lancer le Lab

### Prérequis
- Docker & Docker Compose installés
- Jenkins (via Docker ou installation locale)
- Compte Docker Hub

### 1. Démarrer Jenkins
```bash
docker-compose -f docker-compose.jenkins.yml up -d
```

### 2. Configurer Jenkins
- Accéder à `http://localhost:8080`
- Installer les plugins : **Docker**, **Maven Integration**, **Git**
- Ajouter les credentials Docker Hub (ID : `first_jenkin`)
- Configurer Maven 3.9.0 dans *Global Tool Configuration*

### 3. Créer le Pipeline
- Nouveau job → **Pipeline**
- Source : ce dépôt GitHub
- Script : `Jenkinsfile`

### 4. Lancer le Build
```bash
# Ou déclencher manuellement depuis l'UI Jenkins
# L'image sera poussée sur Docker Hub : moezog/my-app:<BUILD_NUMBER>
```

### 5. Déployer l'application
```bash
docker-compose -f docker-compose.app.yml up -d
```

---

## 🐳 Dockerfile

```dockerfile
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app
COPY target/my-app-1.0.jar app.jar
CMD ["java", "-jar", "app.jar"]
```

---

## 🔐 Gestion des Credentials

Les credentials Docker Hub sont gérés de façon sécurisée via **Jenkins Credentials Manager** (jamais en clair dans le code) :

```groovy
withCredentials([usernamePassword(
    credentialsId: 'first_jenkin',
    usernameVariable: 'DOCKER_USER',
    passwordVariable: 'DOCKER_PASS'
)]) {
    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
}
```

---

## 📚 Concepts Couverts

- ✅ Pipeline as Code (Jenkinsfile)
- ✅ Containerisation avec Docker
- ✅ Gestion sécurisée des secrets (Jenkins Credentials)
- ✅ Versionnage des images Docker (BUILD_NUMBER)
- ✅ Orchestration multi-services avec Docker Compose
- ✅ Intégration GitHub → Jenkins → Docker Hub

---

## 👤 Auteur

**Moez Ouaghrem**  
Étudiant Ingénieur – Esprit, Tunis  
🔗 [LinkedIn](https://www.linkedin.com/in/moez-ouaghrem/) | [GitHub](https://github.com/moez-og)
