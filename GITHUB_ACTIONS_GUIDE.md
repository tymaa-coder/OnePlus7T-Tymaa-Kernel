# GitHub Actions Kernel Build — Швидкий старт (тільки Windows, 0 встановлення)

## 1. Створи репозиторій на GitHub (2 хв)

```cmd
# В cmd / PowerShell у C:\Users\Tymofii\
git init
git add .
git commit -m "Initial: Tymaa kernel + SELinuxSwitcher"
```

Потім на **github.com/new** → назва `OnePlus7T-Tymaa-Kernel` → **Public** (Actions безкоштовно для публічних) → **Create repository**.

```cmd
git branch -M main
git remote add origin https://github.com/ТВІЙ_НІК/OnePlus7T-Tymaa-Kernel.git
git push -u origin main
```

---

## 2. Запуск білду (автоматично)

Білд запуститься **сам** після `git push`. Або вручну:

1. Відкрий репозиторій на GitHub
2. Вкладка **Actions** → **Build OnePlus 7T Custom Kernel**
3. **Run workflow** → вибери `permissive` / `enforcing` / `disabled` → **Run workflow**

---

## 3. Качай готові ZIP (через 10-15 хв)

### Варіант А: Artifacts (без релізу)
- Actions → останній запуск → **Artifacts** внизу:
  - `kernel-7t-tymaa-permissive` → `kernel_7t_Tymaa_Permissive_YYYYMMDD.zip`
  - `SELinuxSwitcher-module` → `SELinuxSwitcher_v1.0_YYYYMMDD.zip`

### Варіант Б: Releases (якщо пушнеш тег)
```cmd
git tag v1.0.0
git push origin v1.0.0
```
→ GitHub створить **Release** з обома ZIP.

---

## 4. Прошив на телефон

```cmd
# 1. Ядро (Permissive за дефолтом)
adb push kernel_7t_Tymaa_Permissive_*.zip /sdcard/
# TWRP: Install → ZIP → Reboot
# АБО: fastboot boot kernel_7t_Tymaa_Permissive_*.zip

# 2. Magisk модуль
adb push SELinuxSwitcher_v1.0_*.zip /sdcard/
# Magisk App → Modules → Install from storage → Reboot
```

---

## 5. Використання

```bash
su -c selinux-switch
# Меню: 1=Enforcing, 2=Permissive, 3=Disabled (окремий kernel), 0=Exit
# Авто-ребут
```

---

## Файли в репозиторії

```
.github/workflows/build.yml     # CI/CD pipeline (головне)
GITHUB_ACTIONS_GUIDE.md         # Цей файл
```

**Все. Немає ніяких WSL, Docker, Linux VM — тільки GitHub сервери роблять роботу.** 🚀