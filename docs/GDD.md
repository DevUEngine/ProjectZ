# ProjectZ — Neon Requiem: Bullet Heaven Roguelike

## Сеттинг: Cyberpunk Gothic
Киберпанк-город **Neo-Vesper**, где корпорации открыли цифровой портал в Измерение Старых Богов. Технология и проклятие слились. Игрок — **Кибер-Охотник** с имплантами, сражающийся с ордами кибер-зомби, культистов-корпоративных наемников и эльдрич-ИИ. Неон, кровь, пиксель-арт.

## Механики (топ из исследования)
1. Авто-атака ближайшей цели + активное уклонение (Vampire Survivors + Brotato)
2. Система левел-апа: выбор из 3 случайных оружий/пассивок (синергии оружия)
3. Волны врагов, прогрессивная сложность, боссы каждые 5 минут
4. Сессия ~20 минут, финальный босс
5. Мета-прогрессия: души → постоянные апгрейды
6. 4 playable characters с уникальными пассивками
7. 8+ оружий с эволюциями (combo эффекты)
8. 3 биома: Neon Slums → Corporate Labs → Abyss Core
9. Сбор: XP (орбы), души (валюта), здоровье (редкие)
10. Кроссплатформенность: Win/Mac/Linux/Web/Android

## Этапы

### Stage 1 — Foundation
- project.godot, export_presets.cfg
- GDD (этот файл)
- Базовая структура сцен

### Stage 2 — Asset Generation (parallel)
- Player спрайты (idle, walk, death)
- Enemy спрайты (zombie, cultist, drone, boss)
- Weapon/projectile спрайты
- Environment тайлсет
- UI элементы

### Stage 3 — Core Code (parallel)
- Player controller + movement
- Auto-attack + weapon system
- Enemy AI + spawning
- XP/Level-up system
- UI/HUD
- Meta-progression
- Main menu + Game Over

### Stage 4 — Integration
- Сборка сцен, связывание скриптов
- Балансировка
- Экспорт пресеты

### Stage 5 — GitHub Push
- Коммит всех файлов
- README с инструкциями
